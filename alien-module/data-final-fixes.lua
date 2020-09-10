local tech = data.raw["technology"]

local gun_turret_modifier = {
  [1] = 0.1,
  [2] = 0.1,
  [3] = 0.2,
  [4] = 0.2,
  [5] = 0.2,
  [6] = 0.4,
  [7] = 0.7
}
local tech_lv

for _, tech in pairs(tech) do
  if tech.name:match("^physical%-projectile%-damage%-") and tech.effects then
    for _, eff in pairs(tech.effects) do
      if eff.type == "turret-attack" and eff.turret_id == "gun-turret" then
        tech_lv = tech.name:match("[%a%s%-]+(%d+)")
        gun_turret_modifier[tech_lv] = eff.modifier
      end
    end
    table.insert(tech.effects, {type="turret-attack", turret_id = "alien-gun-turret", modifier = gun_turret_modifier[tech_lv]})
  end
end