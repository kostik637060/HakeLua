local Pudge = {}
Pudge.option = Menu.AddOption({ "Hero Specific", "Pudge" }, " 1. Turn Me On", "")
Pudge.Deny = Menu.AddOption({ "Hero Specific", "Pudge" }, " 2. Pudge Auto Suicide", "Trying to get you a Suicide")
Pudge.thresholdofrot = Menu.AddOption({ "Hero Specific", "Pudge" }, "3. Hp count threshhold", "", 2, 10, 2)


function Pudge.OnUpdate()

local myHero = Heroes.GetLocal()
    if NPC.GetUnitName(myHero) ~= "npc_dota_hero_pudge" then return end
local rotAbility = NPC.GetAbilityByIndex(myHero, 1)
    if not Ability.IsCastable(rotAbility, NPC.GetMana(myHero)) then end
    if Menu.IsEnabled(Pudge.Deny) then
     Pudge.EnableRot(myHero, rotAbility, Menu.GetValue(Pudge.thresholdofrot))
   end
 end

function Pudge.EnableRot(myHero, rotAbility, thresholdofrot)

local  min = 999

local  pdg = Heroes.Get(1)
  local  dil = math.floor(Entity.GetHealth(pdg) / Entity.GetMaxHealth(pdg) * 100)
      if Entity.GetHealth(pdg) > 0 and Entity.GetHealth(pdg) < min and dil <= thresholdofrot then
       min = Entity.GetHealth(pdg)
     end

   if(min < 999) then
     Ability.Toggle(rotAbility)
   end

 end


return Pudge
