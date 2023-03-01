return {
  "goolord/alpha-nvim",
  opts = function(_, opts)
    local logo = [[
                                __                
   ___     ___    ___   __  __ /\_\    ___ ___    
  / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  
 /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ 
 \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\
  \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/
    ]]
    opts.section.header.val = vim.split(logo, "\n", { trimempty = true })
  end,
}
