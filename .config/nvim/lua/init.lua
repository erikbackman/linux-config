-- Create an event handler for the FileType autocommand
vim.api.nvim_create_autocmd('FileType', {
  -- This handler will fire when the buffer's 'filetype' is "python"
  pattern = 'zig',
  callback = function(args)
    vim.lsp.start({
      name = 'zls',
      cmd = {'zls' }, --, '--option', 'arg1', 'arg2'},
      -- Set the "root directory" to the parent directory of the file in the
      -- current buffer (`args.buf`) that contains either a "setup.py" or a
      -- "pyproject.toml" file. Files that share a root directory will reuse
      -- the connection to the same LSP server.
      root_dir = vim.fs.root(args.buf, { 'build.zig' }),
    })
  end,
})
--
--
--vim.api.nvim_create_autocmd("LspAttach", {
--	callback = function(args)
--		local bufnr = args.buf
--		local client = vim.lsp.get_client_by_id(args.data.client_id)
--		if client.server_capabilities.completionProvider then
--			vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
--		end
--		if client.server_capabilities.definitionProvider then
--			vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
--		end
--	end,
--})
