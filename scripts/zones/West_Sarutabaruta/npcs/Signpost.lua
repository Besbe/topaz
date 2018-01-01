-----------------------------------
-- Area: West Sarutabaruta
-- NPC:  Signpost (18 total)
-----------------------------------
package.loaded["scripts/zones/West_Sarutabaruta/TextIDs"] = nil;
package.loaded["scripts/zones/West_Sarutabaruta/MobIDs"] = nil;
-----------------------------------
require("scripts/zones/West_Sarutabaruta/TextIDs");
require("scripts/zones/West_Sarutabaruta/MobIDs");

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)
    local offset = npc:getID() - SIGNPOST_OFFSET;
    if (offset >= 0 and offset <= 18) then
        player:messageSpecial(SIGN_1 + math.floor(offset / 2));
    end
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)
end;
