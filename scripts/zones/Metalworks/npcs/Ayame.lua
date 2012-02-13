-----------------------------------
-- Area: Metalworks
-- NPC:  Ayame
-- Involved in Missions
-- Starts and Finishes Quest: True Strength
-- @zone 237
-- @pos 133 -19 34
-----------------------------------
package.loaded["scripts/zones/Metalworks/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/titles");
require("scripts/globals/keyitems");
require("scripts/globals/missions");
require("scripts/globals/quests");
require("scripts/zones/Metalworks/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
	
	if(player:getQuestStatus(BASTOK,TRUE_STRENGTH) == QUEST_ACCEPTED) then 
		if(trade:hasItemQty(1100,1) and trade:getItemCount() == 1) then -- Trade Xalmo Feather
			player:startEvent(0x02ed); -- Finish Quest "True Strength"
		end	
	end
	
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	
	trueStrength = player:getQuestStatus(BASTOK,TRUE_STRENGTH);
	
	if(player:getCurrentMission(BASTOK) == THE_CRYSTAL_LINE and player:hasKeyItem(C_L_REPORTS)) then
		player:startEvent(0x02c8);
	elseif(trueStrength == QUEST_AVAILABLE and player:getMainJob() == 2 and player:getMainLvl() >= 50) then
		player:startEvent(0x02ec); -- Start Quest "True Strength"
	else
		player:startEvent(0x02bd); -- Standard dialog
	end
	
end;

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player,csid,option)
--printf("CSID: %u",csid);
--printf("RESULT: %u",option);
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player,csid,option)
--printf("CSID: %u",csid);
--printf("RESULT: %u",option);

	if(csid == 0x02c8) then
		player:completeMission(1);
		player:delKeyItem(C_L_REPORTS);
		player:addRankPoints(10);
		player:setVar("MissionStatus",0);
	elseif(csid == 0x02ec) then
		player:addQuest(BASTOK,TRUE_STRENGTH);
	elseif(csid == 0x02ed) then
		if (player:getFreeSlotsCount() == 0) then 
			player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,14215); -- Temple Hose
		else
			player:tradeComplete();
			player:setTitle(PARAGON_OF_MONK_EXCELLENCE);
			player:addItem(14215);
			player:messageSpecial(ITEM_OBTAINED,14215); -- Temple Hose
			player:addFame(BASTOK,AF3_FAME);
			player:completeQuest(BASTOK,TRUE_STRENGTH);
		end
	end
	
end;