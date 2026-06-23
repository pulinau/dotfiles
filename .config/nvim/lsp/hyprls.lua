---@brief
---
--- https://github.com/hyprland-community/hyprls
---
--- `hyprls` can be installed via `go`:
--- ```sh
--- go install github.com/hyprland-community/hyprls/cmd/hyprls@latest
--- ```

---@type vim.lsp.Config
return {
  cmd = { "hyprls" },
  filetypes = { "hyprland" },
  root_dir = vim.fn.getcwd(),
  settings = {
    hyprls = {
      preferIgnoreFile = false,
      ignore = { "hyprlock.conf", "hypridle.conf" }
    }
  }
}
