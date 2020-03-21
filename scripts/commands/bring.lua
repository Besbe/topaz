---------------------------------------------------------------------------------------------------
-- func: bring <player>
-- desc: Brings the target to the player.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 2,
    parameters = "si"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!bring <player> {forceZone}")
end

function onTrigger(player, target, forceZone)
    -- validate target
    if (target == nil) then
        error(player, "You must enter a target player name.")
        return
    end
    local targ = GetPlayerByName( target )
    if (targ == nil) then
        if not player:bringPlayer( target ) then
            error(player, string.format( "Player named '%s' not found!", target ) )
        end
        return
    end

    -- validate forceZone
    if (forceZone ~= nil) then
        if (forceZone ~= 0 and forceZone ~= 1) then
            error(player, "If provided, forceZone must be 1 (true) or 0 (false).")
            return
        end
    else
        forceZone = 1
    end
    -- bring target
	targ:setCharVar("prev_x",targ:getXPos());
	targ:setCharVar("prev_y", targ:getYPos());
	targ:setCharVar("prev_z", targ:getZPos());
	targ:setCharVar("prev_rot", targ:getRotPos());
	targ:setCharVar("prev_bringzone", targ:getZoneID())
	if (targ:getZoneID() ~= player:getZoneID() or forceZone == 1) then
        targ:setPos( player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos(), player:getZoneID() );
    else
        targ:setPos( player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos() )
    end
end
