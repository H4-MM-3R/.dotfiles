-- parse_inspect.lua
-- Reads an inspect-style Lua table literal from stdin and reconstructs shared references

-- Slurp full input (e.g. { sometable = <1>{ ... }, anothertable = <table 1> })
local input = io.read("*all")

-- 1) Extract definitions: any "<N>{...}" -> store in refs[N]
local refs = {}
local def_pat = "<(%d+)>%s*(%b{})"
for id, body in input:gmatch(def_pat) do
  refs[tonumber(id)] = body
end

-- 2) Rewrite input:
--    - replace each "<N>{...}" def with "refs[N]"
--    - replace each "<table N>" ref with "refs[N]"
local cleaned = input
  :gsub(def_pat, function(id, body)
    return string.format("refs[%s]", id)
  end)
  :gsub("<table%s+(%d+)>", "refs[%1]")

-- 3) Build a chunk that seeds refs[] and returns the cleaned table literal
local lines = {"local refs = {}"}
for i, body in pairs(refs) do
  table.insert(lines, string.format("refs[%d] = %s", i, body))
end
table.insert(lines, "return " .. cleaned)
local chunk_src = table.concat(lines, "\n")

-- 4) Load/run using Lua 5.1+ compatible loader
local loader = loadstring or load
local fn, err = loader(chunk_src)
if not fn then
  error("Failed to load reconstructed chunk:\n" .. err .. "\n\nSource:\n" .. chunk_src)
end
local ok, tbl = pcall(fn)
if not ok then
  error("Runtime error while reconstructing table: " .. tbl)
end

-- 5) Output as JSON (requires lua-json installed) for easy consumption
local JSON = require("JSON")
print(JSON:encode(tbl))

