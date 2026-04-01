---@brief
---
--- https://taplo.tamasfe.dev/cli/usage/language-server.html
---
--- Language server for Taplo, a TOML toolkit.
---
--- `taplo-cli` can be installed via `cargo`:
--- ```sh
--- cargo install --features lsp --locked taplo-cli
--- ```

---@type vim.lsp.Config
return {
    cmd = { 'taplo', 'lsp', 'stdio' },
    filetypes = { 'toml' },
    -- root_markers is used by vim.lsp.enable to find the project root automatically
    root_markers = { '.taplo.toml', 'taplo.toml', '.git', 'Cargo.toml', 'starship.toml' },

    -- Settings to ensure schemas are processed
    settings = {
        evenBetterToml = {
            schema = {
                enabled = true,
            },
        },
    },
}
