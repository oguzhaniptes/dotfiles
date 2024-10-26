return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
  },
  config = function()
      require("neo-tree").setup({
          filesystem = {
              filtered_items = {
                  visible = true,
                  hide_dotfiles = false,
                  hide_gitignored = true,
              },
              follow_current_file = true,
          },
      })
  end,
}
