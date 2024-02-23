-- Commands 
commands.add_command("log_am", nil, function(command)
  for name,player in pairs(game.players) do   log(name .. "  Player: " .. player.name .. ", force: " .. player.force.name .. ", module level: " .. global.modulelevel[player.force.name] .. ", current module level: " .. global.currentmodulelevel[player.force.name] .. ", kill count: " .. global.killcount[player.force.name] ) end
end)
