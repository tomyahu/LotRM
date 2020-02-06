require "lib.classes.class"
require "Battle.consts"
--------------------------------------------------------------------------------------------------------

-- class: RogueGuard
-- param: entity:Entity -> the entity that is using this guard style
-- A knight guard style, this style is centered using armor and shields to block incoming damage and maintaining
-- equilibrium, thus strength (STR) is a strong factor in this guard and so is resistance (RES). But also the reactions
-- of the user are important (RCT) and can make the difference between a succesful block and a direct hit.
local RogueGuard = class(function(self, entity)
end)

-- getMaxGuard: None -> num
-- gets the maximum guard of the entity using this style
function RogueGuard.getMaxGuard(self)
    local spd = self.entity:getSpeed()
    local agi = self.entity:getAgility()
    local rct = self.entity:getReaction()

    local aux = math.pow(spd,1.5) * math.pow(agi,1.5)

    return math.floor(math.pow(aux, rct/90))
end

return RogueGuard