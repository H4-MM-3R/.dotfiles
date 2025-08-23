local root_dir = vim.fs.root(0, {"settings.gradle.kts", "settings.gradle"})
if not root_dir then
    root_dir = vim.fs.root(0, {"build.gradle.kts", "build.gradle"})
end

vim.lsp.config['kotlinlsp'] = {
    cmd = { '/home/hemram/tester/kotlin-lsp/lsp-dist/kotlin-lsp-1.5/bin/kotlin-lsp' },
    -- cmd = vim.lsp.rpc.connect('0.0.0.0', tonumber(2090)),
    filetypes = { 'kotlin' },
    root_dir = root_dir
}


vim.lsp.enable('kotlinlsp')
