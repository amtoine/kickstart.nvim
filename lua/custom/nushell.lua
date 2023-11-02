vim.filetype.add({
    extension = {
        nu = "nu",
        nush = "nu",
        nuon = "nu",
    },
    pattern = {
        [".*"] = {
            function(path, bufnr)
                local content = vim.filetype.getlines(bufnr, 1)
                if vim.filetype.matchregex(content, [[^#!/usr/bin/env nu]]) then
                    return "nu"
                end
            end,
            priority = -math.huge,
        },
    },
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.nu = {
  install_info = {
    url = "https://github.com/nushell/tree-sitter-nu",
    files = { "src/parser.c" },
    branch = "main",
  },
  filetype = "nu",
}

local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>lrn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>lca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('<leader>lgd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('<leader>lgr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('<leader>lrr', vim.lsp.buf.references, '[G]oto [R]eferences')
  nmap('<leader>lgI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>lD', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>lds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>lws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('<leader>lh', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<leader>ls', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('<leader>lgD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>lwa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>lwr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>lwf', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace list [F]olders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

local on_init = function () end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
configs.nulsp = {
    default_config = {
        cmd = { "nu-lsp" },
        filetypes = { "nu" },
        root_dir = function(fname)
            local git_root = lspconfig.util.find_git_ancestor(fname)
            if git_root then
                return git_root
            else
                return vim.fn.fnamemodify(fname, ":p:h")  -- get the parent directory of the file
            end
        end
    },
}
lspconfig.nulsp.setup({ capabilities = capabilities, on_attach = on_attach, on_init = on_init })
