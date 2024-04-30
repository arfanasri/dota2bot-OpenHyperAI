-- Dependencies
 -- global debug flag
require 'FretBots.Debug'
 -- Global flags
 require 'FretBots.Flags'
 -- Data Tables and helper functions
require 'FretBots.DataTables'
-- Awards for bots
require 'FretBots.AwardBonus'
-- Settings
require 'FretBots.Settings'
-- Game State Tracker
require 'FretBots.GameState'

-- local debug flag
local thisDebug = false;
local isDebug = Debug.IsDebug() and thisDebug;

-- Instantiate ourself
if EntityKilled == nil then
	EntityKilled = {}
end

-- Event Listener
function EntityKilled:OnEntityKilled(event)
	-- Get Event Data
	local isHero, victim, killer = EntityKilled:GetEntityKilledEventData(event);
	-- Log Tower/Building kills to track game state
	if victim == nil then return end
	if victim:IsTower() or victim:IsBuilding() then
		GameState:Update(victim)
	end
	-- Drop out for non hero kills
	if not isHero then return end;
	-- Do Table Update
	DataTables:DoDeathUpdate(victim, killer);
	-- Dynamic Adjustment (maybe)
	DynamicDifficulty:Adjust(victim)
	-- Give Awards (maybe)
	AwardBonus:Death(victim)
	-- Sound if it is a player?
	if Settings.isPlayerDeathSound then
		Utilities:RandomSound(BAD_LIST)
	end
	-- Debug Print
	if isDebug then
		DeepPrintTable(victim)
	end
end

-- returns useful data about the kill event
function EntityKilled:GetEntityKilledEventData(event)
	-- Victim
	local victim = EntIndexToHScript(event.entindex_killed);
	-- Killer
	local killer = nil;
	if event.entindex_attacker ~= nil then
		killer = EntIndexToHScript( event.entindex_attacker )
	end
	-- IsHero
	local isHero = false;
	if victim:IsHero() and victim:IsRealHero() and not victim:IsIllusion() and not victim:IsClone() then
		isHero = true;

        -- 当击杀者是人类玩家时，给与击杀惩罚
        if killer == nil or killer.stats == nil or killer.stats.isBot then return end
        local goldPerLevel = -30
        local heroLevel = victim:GetLevel()
        -- 基于基础惩罚，死亡单位的等级，和难度来确定惩罚额度
        local goldBounty = math.floor(goldPerLevel * heroLevel/4 * (Settings.difficultyScale * 3) - math.random(1, 50))
        -- 给予击杀者赏金
        killer:ModifyGold(goldBounty, true, DOTA_ModifyGold_HeroKill)
        local msg = 'Balance Killer Award to ' .. PlayerResource:GetPlayerName(killer:GetPlayerID())..' for the kill. Gold: ' .. goldBounty
        Utilities:Print(msg, Utilities:GetPlayerColor(killer:GetPlayerID()))


	end

	return isHero, victim, killer;
end

-- Registers Event Listener
function EntityKilled:RegisterEvents()
	if not Flags.isEntityKilledRegistered then
		ListenToGameEvent('entity_killed', Dynamic_Wrap(EntityKilled, 'OnEntityKilled'), EntityKilled)
		Flags.isEntityKilledRegistered = true;
		if true then
			print('EntityKilled Event Listener Registered.')
		end
	end
end

