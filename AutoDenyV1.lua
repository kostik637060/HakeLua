local PudgeDeny = {}

PudgeDeny.optionEnable= Menu.AddOption({ "Hero Specific", "Pudge" }, "Use ROT to die", "On/Off")

--PudgeDeny.optionAutoDeny = Menu.AddOption({ "Hero Specific", "Pudge" }, "AutoDeny after hp lowest than", "")
PudgeDeny.threshold = Menu.AddOption({ "Hero Specific", "Pudge" }, "AutoDeny threshold", "", 1, 100, 5)


function PudgeDeny.OnUpdate()



    if not Menu.IsEnabled(PudgeDeny.optionEnable) then return end
    local myHero = Heroes.GetLocal()
    if  NPC.GetUnitName(myHero) ~= "npc_dota_hero_pudge" then return end
    local PudgeROT = NPC.GetAbilityByIndex(myHero, 1)

    if Menu.IsEnabled(PudgeDeny.optionEnable) then
       PudgeDeny.PudgeSuicide(myHero, PudgeROT, Menu.GetValue(PudgeDeny.threshold))
     end

    PudgeDeny.PudgeSuicide()
end

function  PudgeDeny.PudgeSuicide(myHero, PudgeROT, threshold)

  local myHero = Heroes.GetLocal()
  local min = 99999
  local percents = math.floor (Entity.GetHealth(myHero) / Entity.GetMaxHealth(myHero) * 100)

    if Entity.GetHealth(myHero) > 0 and Entity.GetHealth(myHero) < min and percents <= threshold then
          min = Entity.GetHealth(myHero)
     end

     if(min < 99999) and PudgeROT ~= nil and Ability.IsReady(PudgeROT) then
        Ability.CastTarget(PudgeROT, myHero)
     end
end

  return PudgeDeny
