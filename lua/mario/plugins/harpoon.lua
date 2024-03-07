return {
    "theprimeagen/harpoon",
    config = function ()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Add file to harpoon" })
        vim.keymap.set("n", "<leader>e", ui.toggle_quick_menu, { desc = "Toggle harpoon menu" })

        vim.keymap.set("n", "<C-u>", function() ui.nav_file(1) end)
        vim.keymap.set("n", "<C-i>", function() ui.nav_file(2) end)
        vim.keymap.set("n", "<C-o>", function() ui.nav_file(3) end)
    end
}
