-- local client = nil
-- return {}

vim.lsp.set_log_level("debug")

 -- vim.api.nvim_create_autocmd("FileType", {
 -- 	pattern = "kotlin",
 -- 	callback = function()
 -- 		local bufnr = vim.api.nvim_get_current_buf()
 -- 		client = vim.lsp.start({
 -- 			-- name = "kt_lsp",
 -- 			-- cmd = { "/home/hemram/git-repos/kt_lsp/app/build/install/app/bin/app" },
 -- 			-- name = "kotlin-analysis-server",
 -- 			-- cmd = { "/home/hemram/git-repos/kotlin-analysis-server/build/install/kotlin-analysis-server/bin/kotlin-analysis-server" },
 -- 			-- name = "kotlin-lsp",
 -- 			-- cmd = { "/home/hemram/git-repos/kotlin-lsp/server/build/install/server/bin/server" },
 -- 			-- name = "kotlin-lsp",
 --    --          name = "kotlin-lsp",
 -- 			-- cmd = { "/home/hemram/test/kotlin-lsp-base/lsp-dist/kotlin-lsp-0.1a/bin/kotlin-lsp" },
 --             cmd = {"/home/hemram/.local/bin/kotlinlsp", "--stdio"},
 --             -- cmd = {"/home/hemram/git-repos/kotlin-ls/app/build/install/app/bin/app"},
 --             single_file_support = true,
 --             filetypes = { "kotlin" },
 --             root_markers = { "build.gradle", "build.gradle.kts", "pom.xml"},
 -- 			capabilities = vim.lsp.protocol.make_client_capabilities(),
 -- 		})
 --
 -- 		if not client then
 -- 			vim.notify("something went wrong with kt_lsp")
 -- 			return
 -- 		end
 -- 		vim.lsp.buf_attach_client(bufnr, client)
 -- 	end,
 -- })

local root_dir = vim.fs.root(0, {"settings.gradle.kts", "settings.gradle"})
if not root_dir then
    root_dir = vim.fs.root(0, {"build.gradle.kts", "build.gradle"})
end

vim.lsp.config['kotlinlsp'] = {
    -- cmd = { '/home/hemram/git-repos/kotlin-lsp/lsp-dist/kotlin-lsp-1.8/bin/kotlin-lsp' },
    cmd = vim.lsp.rpc.connect('0.0.0.0', tonumber(2090)),
    filetypes = { 'kotlin' },
    root_dir = root_dir
}


vim.lsp.enable('kotlinlsp')
