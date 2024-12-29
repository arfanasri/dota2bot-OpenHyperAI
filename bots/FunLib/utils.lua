--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
-- Lua Library inline imports
local function __TS__ObjectEntries(obj)
    local result = {}
    local len = 0
    for key in pairs(obj) do
        len = len + 1
        result[len] = {key, obj[key]}
    end
    return result
end

local __TS__Symbol, Symbol
do
    local symbolMetatable = {__tostring = function(self)
        return ("Symbol(" .. (self.description or "")) .. ")"
    end}
    function __TS__Symbol(description)
        return setmetatable({description = description}, symbolMetatable)
    end
    Symbol = {
        asyncDispose = __TS__Symbol("Symbol.asyncDispose"),
        dispose = __TS__Symbol("Symbol.dispose"),
        iterator = __TS__Symbol("Symbol.iterator"),
        hasInstance = __TS__Symbol("Symbol.hasInstance"),
        species = __TS__Symbol("Symbol.species"),
        toStringTag = __TS__Symbol("Symbol.toStringTag")
    }
end

local function __TS__ArrayEntries(array)
    local key = 0
    return {
        [Symbol.iterator] = function(self)
            return self
        end,
        next = function(self)
            local result = {done = array[key + 1] == nil, value = {key, array[key + 1]}}
            key = key + 1
            return result
        end
    }
end

local __TS__Iterator
do
    local function iteratorGeneratorStep(self)
        local co = self.____coroutine
        local status, value = coroutine.resume(co)
        if not status then
            error(value, 0)
        end
        if coroutine.status(co) == "dead" then
            return
        end
        return true, value
    end
    local function iteratorIteratorStep(self)
        local result = self:next()
        if result.done then
            return
        end
        return true, result.value
    end
    local function iteratorStringStep(self, index)
        index = index + 1
        if index > #self then
            return
        end
        return index, string.sub(self, index, index)
    end
    function __TS__Iterator(iterable)
        if type(iterable) == "string" then
            return iteratorStringStep, iterable, 0
        elseif iterable.____coroutine ~= nil then
            return iteratorGeneratorStep, iterable
        elseif iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            return iteratorIteratorStep, iterator
        else
            return ipairs(iterable)
        end
    end
end

local function __TS__StringEndsWith(self, searchString, endPosition)
    if endPosition == nil or endPosition > #self then
        endPosition = #self
    end
    return string.sub(self, endPosition - #searchString + 1, endPosition) == searchString
end

local function __TS__StringIncludes(self, searchString, position)
    if not position then
        position = 1
    else
        position = position + 1
    end
    local index = string.find(self, searchString, position, true)
    return index ~= nil
end

local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end

local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end

local function __TS__ClassExtends(target, base)
    target.____super = base
    local staticMetatable = setmetatable({__index = base}, base)
    setmetatable(target, staticMetatable)
    local baseMetatable = getmetatable(base)
    if baseMetatable then
        if type(baseMetatable.__index) == "function" then
            staticMetatable.__index = baseMetatable.__index
        end
        if type(baseMetatable.__newindex) == "function" then
            staticMetatable.__newindex = baseMetatable.__newindex
        end
    end
    setmetatable(target.prototype, base.prototype)
    if type(base.prototype.__index) == "function" then
        target.prototype.__index = base.prototype.__index
    end
    if type(base.prototype.__newindex) == "function" then
        target.prototype.__newindex = base.prototype.__newindex
    end
    if type(base.prototype.__tostring) == "function" then
        target.prototype.__tostring = base.prototype.__tostring
    end
end

local Error, RangeError, ReferenceError, SyntaxError, TypeError, URIError
do
    local function getErrorStack(self, constructor)
        if debug == nil then
            return nil
        end
        local level = 1
        while true do
            local info = debug.getinfo(level, "f")
            level = level + 1
            if not info then
                level = 1
                break
            elseif info.func == constructor then
                break
            end
        end
        if __TS__StringIncludes(_VERSION, "Lua 5.0") then
            return debug.traceback(("[Level " .. tostring(level)) .. "]")
        else
            return debug.traceback(nil, level)
        end
    end
    local function wrapErrorToString(self, getDescription)
        return function(self)
            local description = getDescription(self)
            local caller = debug.getinfo(3, "f")
            local isClassicLua = __TS__StringIncludes(_VERSION, "Lua 5.0") or _VERSION == "Lua 5.1"
            if isClassicLua or caller and caller.func ~= error then
                return description
            else
                return (description .. "\n") .. tostring(self.stack)
            end
        end
    end
    local function initErrorClass(self, Type, name)
        Type.name = name
        return setmetatable(
            Type,
            {__call = function(____, _self, message) return __TS__New(Type, message) end}
        )
    end
    local ____initErrorClass_1 = initErrorClass
    local ____class_0 = __TS__Class()
    ____class_0.name = ""
    function ____class_0.prototype.____constructor(self, message)
        if message == nil then
            message = ""
        end
        self.message = message
        self.name = "Error"
        self.stack = getErrorStack(nil, self.constructor.new)
        local metatable = getmetatable(self)
        if metatable and not metatable.__errorToStringPatched then
            metatable.__errorToStringPatched = true
            metatable.__tostring = wrapErrorToString(nil, metatable.__tostring)
        end
    end
    function ____class_0.prototype.__tostring(self)
        return self.message ~= "" and (self.name .. ": ") .. self.message or self.name
    end
    Error = ____initErrorClass_1(nil, ____class_0, "Error")
    local function createErrorClass(self, name)
        local ____initErrorClass_3 = initErrorClass
        local ____class_2 = __TS__Class()
        ____class_2.name = ____class_2.name
        __TS__ClassExtends(____class_2, Error)
        function ____class_2.prototype.____constructor(self, ...)
            ____class_2.____super.prototype.____constructor(self, ...)
            self.name = name
        end
        return ____initErrorClass_3(nil, ____class_2, name)
    end
    RangeError = createErrorClass(nil, "RangeError")
    ReferenceError = createErrorClass(nil, "ReferenceError")
    SyntaxError = createErrorClass(nil, "SyntaxError")
    TypeError = createErrorClass(nil, "TypeError")
    URIError = createErrorClass(nil, "URIError")
end

local function __TS__ObjectGetOwnPropertyDescriptors(object)
    local metatable = getmetatable(object)
    if not metatable then
        return {}
    end
    return rawget(metatable, "_descriptors") or ({})
end

local function __TS__Delete(target, key)
    local descriptors = __TS__ObjectGetOwnPropertyDescriptors(target)
    local descriptor = descriptors[key]
    if descriptor then
        if not descriptor.configurable then
            error(
                __TS__New(
                    TypeError,
                    ((("Cannot delete property " .. tostring(key)) .. " of ") .. tostring(target)) .. "."
                ),
                0
            )
        end
        descriptors[key] = nil
        return true
    end
    target[key] = nil
    return true
end

local Set
do
    Set = __TS__Class()
    Set.name = "Set"
    function Set.prototype.____constructor(self, values)
        self[Symbol.toStringTag] = "Set"
        self.size = 0
        self.nextKey = {}
        self.previousKey = {}
        if values == nil then
            return
        end
        local iterable = values
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                self:add(result.value)
            end
        else
            local array = values
            for ____, value in ipairs(array) do
                self:add(value)
            end
        end
    end
    function Set.prototype.add(self, value)
        local isNewValue = not self:has(value)
        if isNewValue then
            self.size = self.size + 1
        end
        if self.firstKey == nil then
            self.firstKey = value
            self.lastKey = value
        elseif isNewValue then
            self.nextKey[self.lastKey] = value
            self.previousKey[value] = self.lastKey
            self.lastKey = value
        end
        return self
    end
    function Set.prototype.clear(self)
        self.nextKey = {}
        self.previousKey = {}
        self.firstKey = nil
        self.lastKey = nil
        self.size = 0
    end
    function Set.prototype.delete(self, value)
        local contains = self:has(value)
        if contains then
            self.size = self.size - 1
            local next = self.nextKey[value]
            local previous = self.previousKey[value]
            if next ~= nil and previous ~= nil then
                self.nextKey[previous] = next
                self.previousKey[next] = previous
            elseif next ~= nil then
                self.firstKey = next
                self.previousKey[next] = nil
            elseif previous ~= nil then
                self.lastKey = previous
                self.nextKey[previous] = nil
            else
                self.firstKey = nil
                self.lastKey = nil
            end
            self.nextKey[value] = nil
            self.previousKey[value] = nil
        end
        return contains
    end
    function Set.prototype.forEach(self, callback)
        for ____, key in __TS__Iterator(self:keys()) do
            callback(nil, key, key, self)
        end
    end
    function Set.prototype.has(self, value)
        return self.nextKey[value] ~= nil or self.lastKey == value
    end
    Set.prototype[Symbol.iterator] = function(self)
        return self:values()
    end
    function Set.prototype.entries(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = {key, key}}
                key = nextKey[key]
                return result
            end
        }
    end
    function Set.prototype.keys(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = key}
                key = nextKey[key]
                return result
            end
        }
    end
    function Set.prototype.values(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = key}
                key = nextKey[key]
                return result
            end
        }
    end
    function Set.prototype.union(self, other)
        local result = __TS__New(Set, self)
        for ____, item in __TS__Iterator(other) do
            result:add(item)
        end
        return result
    end
    function Set.prototype.intersection(self, other)
        local result = __TS__New(Set)
        for ____, item in __TS__Iterator(self) do
            if other:has(item) then
                result:add(item)
            end
        end
        return result
    end
    function Set.prototype.difference(self, other)
        local result = __TS__New(Set, self)
        for ____, item in __TS__Iterator(other) do
            result:delete(item)
        end
        return result
    end
    function Set.prototype.symmetricDifference(self, other)
        local result = __TS__New(Set, self)
        for ____, item in __TS__Iterator(other) do
            if self:has(item) then
                result:delete(item)
            else
                result:add(item)
            end
        end
        return result
    end
    function Set.prototype.isSubsetOf(self, other)
        for ____, item in __TS__Iterator(self) do
            if not other:has(item) then
                return false
            end
        end
        return true
    end
    function Set.prototype.isSupersetOf(self, other)
        for ____, item in __TS__Iterator(other) do
            if not self:has(item) then
                return false
            end
        end
        return true
    end
    function Set.prototype.isDisjointFrom(self, other)
        for ____, item in __TS__Iterator(self) do
            if other:has(item) then
                return false
            end
        end
        return true
    end
    Set[Symbol.species] = Set
end

local function __TS__ArrayIsArray(value)
    return type(value) == "table" and (value[1] ~= nil or next(value) == nil)
end

local function __TS__ArrayConcat(self, ...)
    local items = {...}
    local result = {}
    local len = 0
    for i = 1, #self do
        len = len + 1
        result[len] = self[i]
    end
    for i = 1, #items do
        local item = items[i]
        if __TS__ArrayIsArray(item) then
            for j = 1, #item do
                len = len + 1
                result[len] = item[j]
            end
        else
            len = len + 1
            result[len] = item
        end
    end
    return result
end

local function __TS__ArraySome(self, callbackfn, thisArg)
    for i = 1, #self do
        if callbackfn(thisArg, self[i], i - 1, self) then
            return true
        end
    end
    return false
end

local function __TS__StringTrim(self)
    local result = string.gsub(self, "^[%s ﻿]*(.-)[%s ﻿]*$", "%1")
    return result
end

local function __TS__ArrayFilter(self, callbackfn, thisArg)
    local result = {}
    local len = 0
    for i = 1, #self do
        if callbackfn(thisArg, self[i], i - 1, self) then
            len = len + 1
            result[len] = self[i]
        end
    end
    return result
end
-- End of Lua Library inline imports
local ____exports = {}
local avoidanceZones, IsHumanPlayerInTeamCache
local ____dota = require(GetScriptDirectory().."/ts_libs/dota/index")
local Barracks = ____dota.Barracks
local BotMode = ____dota.BotMode
local Lane = ____dota.Lane
local Team = ____dota.Team
local Tower = ____dota.Tower
local UnitType = ____dota.UnitType
local ____http_req = require(GetScriptDirectory().."/ts_libs/utils/http_utils/http_req")
local Request = ____http_req.Request
local ____native_2Doperators = require(GetScriptDirectory().."/ts_libs/utils/native-operators")
local add = ____native_2Doperators.add
local dot = ____native_2Doperators.dot
local length2D = ____native_2Doperators.length2D
local multiply = ____native_2Doperators.multiply
local sub = ____native_2Doperators.sub
local ____heroes = require(GetScriptDirectory().."/ts_libs/dota/heroes")
local HeroName = ____heroes.HeroName
function ____exports.SetCachedVars(key, value)
    if not ____exports.GameStates.cachedVars then
        ____exports.GameStates.cachedVars = {}
    end
    ____exports.GameStates.cachedVars[key] = value
    ____exports.GameStates.cachedVars[key .. "-Time"] = DotaTime()
end
function ____exports.GetCachedVars(key, withinTime)
    if not ____exports.GameStates.cachedVars or not ____exports.GameStates.cachedVars[key] then
        return nil
    end
    if DotaTime() - ____exports.GameStates.cachedVars[key .. "-Time"] <= withinTime then
        return ____exports.GameStates.cachedVars[key]
    end
    return nil
end
function ____exports.GetLocationToLocationDistance(fLoc, sLoc)
    local x1 = fLoc.x
    local x2 = sLoc.x
    local y1 = fLoc.y
    local y2 = sLoc.y
    return math.sqrt((y2 - y1) * (y2 - y1) + (x2 - x1) * (x2 - x1))
end
function ____exports.findSafePosition(currentPosition, targetPosition)
    local direction = sub(targetPosition, currentPosition):Normalized()
    local safeDistance = ____exports.getSafeDistance(currentPosition, targetPosition)
    return add(
        currentPosition,
        multiply(direction, safeDistance)
    )
end
function ____exports.getSafeDistance(currentPosition, targetPosition)
    local maxDistance = length2D(sub(targetPosition, currentPosition))
    for ____, zone in ipairs(avoidanceZones) do
        local projectedPoint = ____exports.projectPointOntoLine(currentPosition, targetPosition, zone.center)
        local distanceToZone = length2D(sub(projectedPoint, zone.center))
        if distanceToZone <= zone.radius then
            local distanceToAvoid = length2D(sub(projectedPoint, currentPosition)) - zone.radius
            return math.max(0, distanceToAvoid)
        end
    end
    return maxDistance
end
function ____exports.projectPointOntoLine(startPoint, endPoint, point)
    local lineDir = sub(endPoint, startPoint):Normalized()
    local toPoint = sub(point, startPoint)
    local projectionLength = dot(toPoint, lineDir)
    return add(
        startPoint,
        multiply(lineDir, projectionLength)
    )
end
function ____exports.IsAnyOfTheBuildingsAlive(buildings)
    for ____, building in ipairs(buildings) do
        if building ~= nil and (not building:CanBeSeen() or building:GetHealth() > 0) then
            return true
        end
    end
    return false
end
function ____exports.IsHumanPlayerInTeam(team)
    if IsHumanPlayerInTeamCache[team] ~= nil then
        return IsHumanPlayerInTeamCache[team]
    end
    for ____, playerdId in ipairs(GetTeamPlayers(team)) do
        if not IsPlayerBot(playerdId) then
            IsHumanPlayerInTeamCache[team] = true
            return true
        end
    end
    IsHumanPlayerInTeamCache[team] = false
    return false
end
--- Get the last seen enemy ids near a location.
-- 
-- @param vLoc - The location to check.
-- @param nDistance - The distance to check.
-- @returns An array of enemy ids.
function ____exports.GetLastSeenEnemyIdsNearLocation(vLoc, nDistance)
    local enemies = {}
    for ____, playerdId in ipairs(GetTeamPlayers(GetOpposingTeam())) do
        if IsHeroAlive(playerdId) then
            local lastSeenInfo = GetHeroLastSeenInfo(playerdId)
            if lastSeenInfo ~= nil and lastSeenInfo[1] ~= nil then
                local firstInfo = lastSeenInfo[1]
                if ____exports.GetLocationToLocationDistance(firstInfo.location, vLoc) <= nDistance and firstInfo.time_since_seen <= 3 then
                    enemies[#enemies + 1] = playerdId
                end
            end
        end
    end
    enemies = __TS__ArrayConcat(
        enemies,
        ____exports.GetEnemyIdsInTpToLocation(vLoc, nDistance)
    )
    return enemies
end
--- Get the enemy ids in teleport to a location.
-- 
-- @param vLoc - The location to check.
-- @param nDistance - The distance to check.
-- @returns An array of enemy ids.
function ____exports.GetEnemyIdsInTpToLocation(vLoc, nDistance)
    local enemies = {}
    for ____, tp in ipairs(GetIncomingTeleports()) do
        if tp ~= nil and ____exports.GetLocationToLocationDistance(vLoc, tp.location) <= nDistance and not IsTeamPlayer(tp.playerid) then
            enemies[#enemies + 1] = tp.playerid
        end
    end
    return enemies
end
--- Get an item from the bot's inventory with a specific total slots count.
-- 
-- @param bot - The bot to check.
-- @param itemName - The name of the item to get.
-- @param count - The number of slots in inventory to check.
-- @returns The item if found, null otherwise.
function ____exports.GetItemFromCountedInventory(bot, itemName, count)
    local cacheKey = (("GetItemFromCountedInventory" .. tostring(bot:GetPlayerID())) .. itemName) .. tostring(count)
    local cachedRes = ____exports.GetCachedVars(cacheKey, 2)
    if cachedRes ~= nil then
        return cachedRes
    end
    do
        local i = 0
        while i < count do
            local item = bot:GetItemInSlot(i)
            if item and item:GetName() == itemName then
                ____exports.SetCachedVars(cacheKey, item)
                return item
            end
            i = i + 1
        end
    end
    ____exports.SetCachedVars(cacheKey, nil)
    return nil
end
require(GetScriptDirectory().."/ts_libs/utils/json")
____exports.DebugMode = false
____exports.ScriptID = 3246316298
____exports.RadiantFountainTpPoint = Vector(-7172, -6652, 384)
____exports.DireFountainTpPoint = Vector(6982, 6422, 392)
____exports.BarrackList = {
    Barracks.TopMelee,
    Barracks.TopRanged,
    Barracks.MidMelee,
    Barracks.MidRanged,
    Barracks.BotMelee,
    Barracks.BotRanged
}
____exports.WisdomRunes = {
    [Team.Radiant] = Vector(-8126, -320, 256),
    [Team.Dire] = Vector(8319, 266, 256)
}
____exports.BuggyHeroesDueToValveTooLazy = {
    [HeroName.Muerta] = true,
    [HeroName.Marci] = true,
    [HeroName.LoneDruidBear] = true,
    [HeroName.PrimalBeast] = true,
    [HeroName.DarkWillow] = true,
    [HeroName.ElderTitan] = true,
    [HeroName.Hoodwink] = true,
    [HeroName.IO] = true,
    [HeroName.Kez] = true
}
____exports.HighGroundTowers = {
    Tower.Top3,
    Tower.Mid3,
    Tower.Bot3,
    Tower.Base1,
    Tower.Base2
}
____exports.FirstTierTowers = {Tower.Top1, Tower.Mid1, Tower.Bot1}
____exports.SecondTierTowers = {Tower.Top2, Tower.Mid2, Tower.Bot2}
____exports.AllTowers = {
    Tower.Top1,
    Tower.Mid1,
    Tower.Bot1,
    Tower.Top2,
    Tower.Mid2,
    Tower.Bot2,
    Tower.Top3,
    Tower.Mid3,
    Tower.Bot3,
    Tower.Base1,
    Tower.Base2
}
____exports.NonTier1Towers = {
    Tower.Top2,
    Tower.Mid2,
    Tower.Bot2,
    Tower.Top3,
    Tower.Mid3,
    Tower.Bot3,
    Tower.Base1,
    Tower.Base2
}
____exports.CachedVarsCleanTime = 5
local SpecialAOEHeroes = {
    HeroName.Axe,
    HeroName.Enigma,
    HeroName.Earthshaker,
    HeroName.Invoker,
    HeroName.SandKing,
    HeroName.TrollWarlord
}
--- A mapping from hero name to an array of important spell(s)
-- that have long cooldowns and can drastically change a team fight.
____exports.ImportantSpells = {
    npc_dota_hero_alchemist = {"alchemist_chemical_rage"},
    npc_dota_hero_axe = {"axe_culling_blade"},
    npc_dota_hero_bristleback = {"bristleback_bristleback"},
    npc_dota_hero_centaur = {"centaur_stampede"},
    npc_dota_hero_chaos_knight = {"chaos_knight_phantasm"},
    npc_dota_hero_dawnbreaker = {"dawnbreaker_solar_guardian"},
    npc_dota_hero_doom_bringer = {"doom_bringer_doom"},
    npc_dota_hero_dragon_knight = {"dragon_knight_elder_dragon_form"},
    npc_dota_hero_earth_spirit = {"earth_spirit_magnetize"},
    npc_dota_hero_earthshaker = {"earthshaker_echo_slam"},
    npc_dota_hero_elder_titan = {"elder_titan_earth_splitter"},
    npc_dota_hero_kunkka = {"kunkka_ghostship"},
    npc_dota_hero_legion_commander = {"legion_commander_duel"},
    npc_dota_hero_life_stealer = {"life_stealer_rage"},
    npc_dota_hero_mars = {"mars_arena_of_blood"},
    npc_dota_hero_night_stalker = {"night_stalker_darkness"},
    npc_dota_hero_omniknight = {"omniknight_guardian_angel"},
    npc_dota_hero_primal_beast = {"primal_beast_pulverize"},
    npc_dota_hero_sven = {"sven_gods_strength"},
    npc_dota_hero_tidehunter = {"tidehunter_ravage"},
    npc_dota_hero_treant = {"treant_overgrowth"},
    npc_dota_hero_undying = {"undying_tombstone", "undying_flesh_golem"},
    npc_dota_hero_skeleton_king = {"skeleton_king_reincarnation"},
    npc_dota_hero_antimage = {"antimage_mana_void"},
    npc_dota_hero_bloodseeker = {"bloodseeker_rupture"},
    npc_dota_hero_clinkz = {"clinkz_burning_barrage"},
    npc_dota_hero_faceless_void = {"faceless_void_chronosphere"},
    npc_dota_hero_gyrocopter = {"gyrocopter_flak_cannon"},
    npc_dota_hero_hoodwink = {"hoodwink_sharpshooter"},
    npc_dota_hero_juggernaut = {"juggernaut_omni_slash"},
    npc_dota_hero_luna = {"luna_eclipse"},
    npc_dota_hero_medusa = {"medusa_stone_gaze"},
    npc_dota_hero_monkey_king = {"monkey_king_wukongs_command"},
    npc_dota_hero_naga_siren = {"naga_siren_song_of_the_siren"},
    npc_dota_hero_razor = {"razor_static_link"},
    npc_dota_hero_nevermore = {"nevermore_requiem"},
    npc_dota_hero_slark = {"slark_shadow_dance"},
    npc_dota_hero_spectre = {"spectre_haunt_single", "spectre_haunt"},
    npc_dota_hero_terrorblade = {"terrorblade_metamorphosis", "terrorblade_sunder"},
    npc_dota_hero_troll_warlord = {"troll_warlord_battle_trance"},
    npc_dota_hero_ursa = {"ursa_enrage"},
    npc_dota_hero_viper = {"viper_viper_strike"},
    npc_dota_hero_weaver = {"weaver_time_lapse"},
    npc_dota_hero_ancient_apparition = {"ancient_apparition_ice_blast"},
    npc_dota_hero_crystal_maiden = {"crystal_maiden_freezing_field"},
    npc_dota_hero_death_prophet = {"death_prophet_exorcism"},
    npc_dota_hero_disruptor = {"disruptor_static_storm"},
    npc_dota_hero_grimstroke = {"grimstroke_dark_portrait", "grimstroke_soul_chain"},
    npc_dota_hero_jakiro = {"jakiro_macropyre"},
    npc_dota_hero_lich = {"lich_chain_frost"},
    npc_dota_hero_lina = {"lina_laguna_blade"},
    npc_dota_hero_lion = {"lion_finger_of_death"},
    npc_dota_hero_muerta = {"muerta_pierce_the_veil"},
    npc_dota_hero_necrolyte = {"necrolyte_ghost_shroud", "necrolyte_reapers_scythe"},
    npc_dota_hero_oracle = {"oracle_false_promise"},
    npc_dota_hero_obsidian_destroyer = {"obsidian_destroyer_sanity_eclipse"},
    npc_dota_hero_puck = {"puck_dream_coil"},
    npc_dota_hero_pugna = {"pugna_life_drain"},
    npc_dota_hero_queenofpain = {"queenofpain_sonic_wave"},
    npc_dota_hero_ringmaster = {"ringmaster_wheel"},
    npc_dota_hero_shadow_demon = {"shadow_demon_disruption", "shadow_demon_demonic_cleanse", "shadow_demon_demonic_purge"},
    npc_dota_hero_shadow_shaman = {"shadow_shaman_mass_serpent_ward"},
    npc_dota_hero_silencer = {"silencer_global_silence"},
    npc_dota_hero_skywrath_mage = {"skywrath_mage_mystic_flare"},
    npc_dota_hero_warlock = {"warlock_fatal_bonds", "warlock_golem"},
    npc_dota_hero_witch_doctor = {"witch_doctor_voodoo_switcheroo", "witch_doctor_death_ward"},
    npc_dota_hero_zuus = {"zuus_thundergods_wrath"},
    npc_dota_hero_abaddon = {"abaddon_borrowed_time"},
    npc_dota_hero_bane = {"bane_fiends_grip"},
    npc_dota_hero_batrider = {"batrider_flaming_lasso"},
    npc_dota_hero_beastmaster = {"beastmaster_primal_roar"},
    npc_dota_hero_brewmaster = {"brewmaster_primal_split"},
    npc_dota_hero_broodmother = {"broodmother_insatiable_hunger"},
    npc_dota_hero_chen = {"chen_hand_of_god"},
    npc_dota_hero_dark_seer = {"dark_seer_wall_of_replica"},
    npc_dota_hero_dark_willow = {"dark_willow_terrorize"},
    npc_dota_hero_enigma = {"enigma_black_hole"},
    npc_dota_hero_lycan = {"lycan_shapeshift"},
    npc_dota_hero_magnataur = {"magnataur_reverse_polarity"},
    npc_dota_hero_marci = {"marci_unleash"},
    npc_dota_hero_pangolier = {"pangolier_gyroshell"},
    npc_dota_hero_phoenix = {"phoenix_supernova"},
    npc_dota_hero_sand_king = {"sandking_epicenter"},
    npc_dota_hero_snapfire = {"snapfire_mortimer_kisses"},
    npc_dota_hero_vengefulspirit = {"vengefulspirit_nether_swap"},
    npc_dota_hero_venomancer = {"venomancer_noxious_plague"},
    npc_dota_hero_windrunner = {"windrunner_focusfire"},
    npc_dota_hero_winter_wyvern = {"winter_wyvern_cold_embrace", "winter_wyvern_winters_curse"}
}
____exports.ImportantItems = {"item_black_king_bar", "item_refresher"}
avoidanceZones = {}
____exports.GameStates = {defendPings = nil, recentDefendTime = -200, cachedVars = nil}
____exports.LoneDruid = {}
____exports.FrameProcessTime = 0.05
____exports.EstimatedEnemyRoles = {npc_dota_hero_any = {lane = Lane.Mid, role = 2}}
function ____exports.PrintTable(tbl, indent)
    if indent == nil then
        indent = 0
    end
    if tbl == nil then
        print("nil")
        return
    end
    for ____, ____value in ipairs(__TS__ObjectEntries(tbl)) do
        local key = ____value[1]
        local value = ____value[2]
        local prefix = (string.rep("  ", indent) .. tostring(key)) .. ": "
        if type(value) == "table" then
            if indent < 3 then
                print(prefix)
                ____exports.PrintTable(value, indent + 1)
            else
                print(prefix .. "[WARN] Table has deep nested tables in it, stop printing more nested tables.")
            end
        else
            print(prefix .. tostring(value))
        end
    end
end
function ____exports.PrintUnitModifiers(unit)
    local modifierCount = unit:NumModifiers()
    do
        local i = 0
        while i < modifierCount do
            local modifierName = unit:GetModifierName(i)
            local stackCount = unit:GetModifierStackCount(i)
            print((((("Unit " .. unit:GetUnitName()) .. " has modifier ") .. modifierName) .. " with stack count ") .. tostring(stackCount))
            i = i + 1
        end
    end
end
function ____exports.PrintPings(pingTimeGap)
    local listPings = {}
    local teamPlayers = GetTeamPlayers(GetTeam())
    for ____, ____value in __TS__Iterator(__TS__ArrayEntries(teamPlayers)) do
        local index = ____value[1]
        local _ = ____value[2]
        do
            local __continue13
            repeat
                local allyHero = GetTeamMember(index)
                if allyHero == nil or allyHero:IsIllusion() then
                    __continue13 = true
                    break
                end
                local ping = allyHero:GetMostRecentPing()
                if ping.time ~= 0 and GameTime() - ping.time < pingTimeGap then
                    listPings[#listPings + 1] = ping
                end
                __continue13 = true
            until true
            if not __continue13 then
                break
            end
        end
    end
    if #listPings > 0 then
        ____exports.PrintTable(listPings)
    end
end
function ____exports.PrintAllAbilities(unit)
    print("Get all abilities of bot " .. unit:GetUnitName())
    for index = 0, 10 do
        local ability = unit:GetAbilityInSlot(index)
        if ability and not ability:IsNull() then
            print((("Ability At Index " .. tostring(index)) .. ": ") .. ability:GetName())
        else
            print(("Ability At Index " .. tostring(index)) .. " is nil")
        end
    end
end
function ____exports.GetEnemyFountainTpPoint()
    if GetTeam() == Team.Dire then
        return ____exports.RadiantFountainTpPoint
    end
    return ____exports.DireFountainTpPoint
end
function ____exports.GetTeamFountainTpPoint()
    if GetTeam() == Team.Dire then
        return ____exports.DireFountainTpPoint
    end
    return ____exports.RadiantFountainTpPoint
end
--- Shuffle an array.
-- 
-- @param tbl - The array to shuffle.
-- @returns The shuffled array.
function ____exports.Shuffle(tbl)
    do
        local i = #tbl - 1
        while i >= 1 do
            local j = RandomInt(1, i + 1)
            local temp = tbl[i + 1]
            tbl[i + 1] = tbl[j + 1]
            tbl[j + 1] = temp
            i = i - 1
        end
    end
    return tbl
end
function ____exports.SetFrameProcessTime(bot)
    if bot.frameProcessTime == nil then
        bot.frameProcessTime = ____exports.FrameProcessTime
    end
end
function ____exports.GetHumanPing()
    local teamPlayers = GetTeamPlayers(GetTeam())
    for ____, ____value in __TS__Iterator(__TS__ArrayEntries(teamPlayers)) do
        local index = ____value[1]
        local _ = ____value[2]
        local teamMember = GetTeamMember(index)
        if teamMember ~= nil and not teamMember:IsBot() then
            return teamMember, teamMember:GetMostRecentPing()
        end
    end
    return nil, nil
end
function ____exports.IsPingedByAnyPlayer(bot, pingTimeGap, minDistance, maxDistance)
    if not bot:IsAlive() then
        return nil
    end
    local pings = {}
    local teamPlayerIds = GetTeamPlayers(GetTeam())
    minDistance = minDistance or 1500
    maxDistance = maxDistance or 10000
    for ____, ____value in __TS__Iterator(__TS__ArrayEntries(teamPlayerIds)) do
        local index = ____value[1]
        local _ = ____value[2]
        do
            local __continue36
            repeat
                local teamMember = GetTeamMember(index)
                if teamMember == nil or teamMember:IsIllusion() or teamMember == bot then
                    __continue36 = true
                    break
                end
                local ping = teamMember:GetMostRecentPing()
                if ping ~= nil then
                    pings[#pings + 1] = ping
                end
                __continue36 = true
            until true
            if not __continue36 then
                break
            end
        end
    end
    for ____, ping in ipairs(pings) do
        local distanceToBot = ____exports.GetLocationToLocationDistance(
            ping.location,
            bot:GetLocation()
        )
        local withinRange = minDistance <= distanceToBot and distanceToBot <= maxDistance
        local withinTimeRange = GameTime() - ping.time < pingTimeGap
        if withinRange and withinTimeRange then
            print(("Bot " .. bot:GetUnitName()) .. " noticed the ping")
            return ping
        end
    end
    return nil
end
function ____exports.CleanupCachedVars()
    if not ____exports.GameStates.cachedVars then
        return
    end
    for key in pairs(____exports.GameStates.cachedVars) do
        if __TS__StringEndsWith(key, "-Time") then
            local originalKey = string.sub(key, 1, -6)
            if DotaTime() - ____exports.GameStates.cachedVars[key] > ____exports.CachedVarsCleanTime then
                __TS__Delete(____exports.GameStates.cachedVars, originalKey)
                __TS__Delete(____exports.GameStates.cachedVars, key)
            end
        end
    end
end
function ____exports.IsValidUnit(target)
    return target ~= nil and not target:IsNull() and target:CanBeSeen() and target:IsAlive() and not target:IsInvulnerable()
end
function ____exports.IsValidHero(target)
    return ____exports.IsValidUnit(target) and target:IsHero()
end
function ____exports.IsValidCreep(target)
    return ____exports.IsValidUnit(target) and target:GetHealth() < 5000 and not target:IsHero() and (GetBot():GetLevel() > 9 or not target:IsAncientCreep())
end
function ____exports.IsValidBuilding(target)
    return ____exports.IsValidUnit(target) and target:IsBuilding()
end
function ____exports.HasItem(bot, itemName)
    local slot = bot:FindItemSlot(itemName)
    return slot >= 0 and slot <= 8
end
function ____exports.FindAllyWithName(name)
    for ____, ally in ipairs(GetUnitList(UnitType.AlliedHeroes)) do
        if ____exports.IsValidHero(ally) and ({string.find(
            ally:GetUnitName(),
            name
        )}) then
            return ally
        end
    end
    return nil
end
function ____exports.Deepcopy(orig)
    local originalType = type(orig)
    local copy
    if originalType == "table" then
        copy = {}
        for ____, ____value in ipairs(__TS__ObjectEntries(orig)) do
            local key = ____value[1]
            local value = ____value[2]
            copy[____exports.Deepcopy(key)] = ____exports.Deepcopy(value)
        end
        setmetatable(
            copy,
            ____exports.Deepcopy(getmetatable(orig))
        )
    else
        copy = orig
    end
    return copy
end
function ____exports.CombineTablesUnique(tbl1, tbl2)
    local set = __TS__New(Set)
    for ____, ____value in ipairs(__TS__ObjectEntries(tbl1)) do
        local _ = ____value[1]
        local value = ____value[2]
        set:add(value)
    end
    for ____, ____value in ipairs(__TS__ObjectEntries(tbl2)) do
        local _ = ____value[1]
        local value = ____value[2]
        set:add(value)
    end
    local result = {}
    for ____, element in __TS__Iterator(set) do
        result[#result + 1] = element
    end
    return result
end
function ____exports.MergeLists(a, b)
    return __TS__ArrayConcat(a, b)
end
function ____exports.RemoveValueFromTable(table_, valueToRemove, removeAll)
    for index = #table_, 1, -1 do
        if table_[index] == valueToRemove then
            __TS__Delete(table_, index)
            if not removeAll then
                return
            end
        end
    end
end
function ____exports.NumActionTypeInQueue(bot, searchedActionType)
    local count = 0
    for index = 1, bot:NumQueuedActions() do
        local actionType = bot:GetQueuedActionType(index)
        if actionType == searchedActionType then
            count = count + 1
        end
    end
    return count
end
local humanCountCache = {}
function ____exports.NumHumanBotPlayersInTeam(team)
    if not (humanCountCache[team] ~= nil) then
        local humans = 0
        local bots = 0
        for ____, playerdId in ipairs(GetTeamPlayers(team)) do
            if IsPlayerBot(playerdId) then
                bots = bots + 1
            else
                humans = humans + 1
            end
        end
        humanCountCache[team] = {humans, bots}
    end
    return humanCountCache[team][1], humanCountCache[team][2]
end
function ____exports.GetNearbyAllyAverageHpPercent(bot, radius)
    local averageHpPercent = 0
    local teamPlayers = GetTeamPlayers(bot:GetTeam())
    for ____, playerdId in ipairs(teamPlayers) do
        local ally = GetTeamMember(playerdId)
        if ally and ally:IsAlive() and GetUnitToUnitDistance(ally, bot) <= radius then
            averageHpPercent = averageHpPercent + ally:GetHealth() / ally:GetMaxHealth()
        end
    end
    return averageHpPercent / #teamPlayers
end
function ____exports.IsWithoutSpellShield(npcEnemy)
    return not npcEnemy:HasModifier("modifier_item_sphere_target") and not npcEnemy:HasModifier("modifier_antimage_spell_shield") and not npcEnemy:HasModifier("modifier_item_lotus_orb_active")
end
function ____exports.SetContains(set, key)
    return set[key] ~= nil
end
function ____exports.AddToSet(set, key)
    set[key] = true
end
function ____exports.RemoveFromSet(set, key)
    set[key] = nil
end
function ____exports.HasValue(set, value)
    for _, element in ipairs(set) do
        if value == element then
            return true
        end
    end
    return false
end
function ____exports.CountBackpackEmptySpace(bot)
    local count = 3
    for ____, slot in ipairs({6, 7, 8}) do
        if bot:GetItemInSlot(slot) ~= nil then
            count = count - 1
        end
    end
    return count
end
function ____exports.FloatEqual(a, b)
    return math.abs(a - b) < 0.000001
end
local magicTable = {}
magicTable.__index = magicTable
function ____exports.NewTable()
    local a = {}
    setmetatable(a, magicTable)
    return a
end
function ____exports.ForEach(_, tb, action)
    for key, value in ipairs(tb) do
        action(key, value)
    end
end
function ____exports.Remove_Modify(table_, item)
    local filter = item
    if type(item) ~= "function" then
        filter = function(t) return t == item end
    end
    local i = 1
    local d = table_.length
    while i <= d do
        if filter(table_[i]) then
            table.remove(table_, i)
            d = d - 1
        else
            i = i + 1
        end
    end
end
function ____exports.AbilityBehaviorHasFlag(behavior, flag)
    return bit.band(behavior, flag) == flag
end
local everySecondsCallRegistry = {}
local function EveryManySeconds(second, oldFunction)
    local functionName = tostring(oldFunction)
    everySecondsCallRegistry[functionName] = {
        lastCallTime = DotaTime() + RandomInt(0, second * 1000) / 1000,
        interval = second,
        startup = true
    }
    return function(...)
        local callTable = everySecondsCallRegistry[functionName]
        if callTable.startup then
            callTable.startup = nil
            return oldFunction(...)
        elseif callTable.lastCallTime <= DotaTime() - callTable.interval then
            callTable.lastCallTime = DotaTime()
            return oldFunction(...)
        end
        return ____exports.NewTable()
    end
end
function ____exports.RecentlyTookDamage(bot, delta)
    return bot:WasRecentlyDamagedByAnyHero(delta) or bot:WasRecentlyDamagedByTower(delta) or bot:WasRecentlyDamagedByCreep(delta)
end
function ____exports.IsUnitWithName(unit, name)
    local result = {string.find(
        unit:GetUnitName(),
        name
    )}
    return result ~= nil
end
function ____exports.IsBear(unit)
    return ____exports.IsUnitWithName(unit, "lone_druid_bear")
end
function ____exports.GetOffsetLocationTowardsTargetLocation(initLoc, targetLoc, offsetDist)
    local direrction = sub(targetLoc, initLoc):Normalized()
    return add(
        initLoc,
        multiply(direrction, offsetDist)
    )
end
function ____exports.TimeNeedToHealHP(bot)
    return (bot:GetMaxHealth() - bot:GetHealth()) / bot:GetHealthRegen()
end
function ____exports.TimeNeedToHealMP(bot)
    return (bot:GetMaxMana() - bot:GetMana()) / bot:GetManaRegen()
end
function ____exports.HasAnyEffect(unit, ...)
    local effects = {...}
    return __TS__ArraySome(
        effects,
        function(____, effect) return unit:HasModifier(effect) end
    )
end
function ____exports.IsModeTurbo()
    for ____, u in ipairs(GetUnitList(UnitType.Allies)) do
        if u and u:GetUnitName() == "npc_dota_courier" and u:GetCurrentMovementSpeed() == 1100 then
            return true
        end
    end
    return false
end
function ____exports.DetermineEnemyBotRole(bot)
    local botName = bot:GetUnitName()
    local estimatedRole = ____exports.EstimatedEnemyRoles[botName]
    if estimatedRole == nil then
        print(("Enemy bot " .. botName) .. " role not cached yet.")
        return 3
    end
    return estimatedRole.role
end
function ____exports.QueryCounters(heroId)
    print("heroId=" .. tostring(heroId))
    Request:RawGetRequest(
        ("https://api.opendota.com/api/heroes/" .. tostring(heroId)) .. "/matchups",
        function(res)
            ____exports.PrintTable(res)
        end
    )
end
function ____exports.InitiStats()
    Request:GetUUID(function(uuid)
        print("uuid=" .. uuid)
    end)
end
function ____exports.GetLoneDruid(bot)
    local res = ____exports.LoneDruid[bot:GetPlayerID()]
    if res == nil then
        ____exports.LoneDruid[bot:GetPlayerID()] = {}
        res = ____exports.LoneDruid[bot:GetPlayerID()]
    end
    return res
end
function ____exports.TrimString(str)
    return __TS__StringTrim(str)
end
--- TODO: AvoidanceZone work in progress.
-- 
-- Example: Adds a zone that expires after 10 seconds: addCustomAvoidanceZone(Vector(1000, 2000), 500, 10);
-- Example: Adds a zone lasts indefinitely: addCustomAvoidanceZone(Vector(1000, 2000), 500);
-- 
-- @param center
-- @param radius
-- @param duration
function ____exports.addCustomAvoidanceZone(center, radius, duration)
    local currentTime = DotaTime()
    local expirationTime = duration ~= nil and currentTime + duration or math.huge
    avoidanceZones[#avoidanceZones + 1] = {center = center, radius = radius, expirationTime = expirationTime}
end
function ____exports.cleanExpiredAvoidanceZones()
    local currentTime = DotaTime()
    avoidanceZones = __TS__ArrayFilter(
        avoidanceZones,
        function(____, zone) return zone.expirationTime > currentTime end
    )
end
function ____exports.getCustomAvoidanceZones()
    return avoidanceZones
end
function ____exports.isPositionInAvoidanceZone(position)
    for ____, zone in ipairs(avoidanceZones) do
        local distance = length2D(sub(position, zone.center))
        if distance <= zone.radius then
            return true
        end
    end
    return false
end
function ____exports.moveToPositionAvoidingZones(bot, targetPosition)
    if ____exports.isPositionInAvoidanceZone(targetPosition) then
        local safePosition = ____exports.findSafePosition(
            bot:GetLocation(),
            targetPosition
        )
        bot:Action_MoveToLocation(safePosition)
    else
        bot:Action_MoveToLocation(targetPosition)
    end
end
function ____exports.drawAvoidanceZones()
    for ____, zone in ipairs(avoidanceZones) do
        DebugDrawCircle(
            zone.center,
            zone.radius,
            0,
            255,
            0
        )
    end
end
function ____exports.findPathAvoidingZones(startPosition, endPosition)
    return {}
end
function ____exports.IsBuildingAttackedByEnemy(building)
    for ____, hero in ipairs(GetUnitList(UnitType.EnemyHeroes)) do
        if ____exports.IsValidHero(hero) and GetUnitToUnitDistance(building, hero) <= hero:GetAttackRange() + 200 and hero:GetAttackTarget() == building then
            return building
        end
    end
    return nil
end
function ____exports.IsAnyBarrackAttackByEnemyHero()
    for ____, barrackE in ipairs(____exports.BarrackList) do
        local barrack = GetBarracks(
            GetTeam(),
            barrackE
        )
        if barrack ~= nil and barrack:GetHealth() > 0 then
            local bar = ____exports.IsBuildingAttackedByEnemy(barrack)
            if bar ~= nil then
                return bar
            end
        end
    end
    return nil
end
function ____exports.IsAnyBarracksOnLaneAlive(bEnemy, lane)
    local barracks = {}
    local team = GetTeam()
    if bEnemy then
        team = GetOpposingTeam()
    end
    if lane == Lane.Top then
        barracks = {
            GetBarracks(team, Barracks.TopMelee),
            GetBarracks(team, Barracks.TopRanged)
        }
    elseif lane == Lane.Mid then
        barracks = {
            GetBarracks(team, Barracks.MidMelee),
            GetBarracks(team, Barracks.MidRanged)
        }
    elseif lane == Lane.Bot then
        barracks = {
            GetBarracks(team, Barracks.BotMelee),
            GetBarracks(team, Barracks.BotRanged)
        }
    end
    return ____exports.IsAnyOfTheBuildingsAlive(barracks)
end
IsHumanPlayerInTeamCache = {[Team.Radiant] = nil, [Team.Dire] = nil}
function ____exports.IsHumanPlayerInAnyTeam()
    return ____exports.IsHumanPlayerInTeam(Team.Radiant) or ____exports.IsHumanPlayerInTeam(Team.Dire)
end
--- Get the enemy hero by player id.
-- 
-- @param id - The player id to check.
-- @returns The enemy hero if found, null otherwise.
function ____exports.GetEnemyHeroByPlayerId(id)
    for ____, hero in ipairs(GetUnitList(UnitType.EnemyHeroes)) do
        if ____exports.IsValidHero(hero) and hero:GetPlayerID() == id then
            return hero
        end
    end
    return nil
end
--- Check if the unit is truely invisible.
-- 
-- @param unit - The unit to check.
-- @returns True if the unit is truely invisible, false otherwise.
function ____exports.IsTruelyInvisible(unit)
    return unit:IsInvisible() and not unit:HasModifier("modifier_item_dustofappearance") and not ____exports.RecentlyTookDamage(unit, 1.5)
end
--- Check if the unit has a modifier containing a specific name.
-- 
-- @param unit - The unit to check.
-- @param name - The name to check.
-- @returns True if the unit has a modifier containing the name, false otherwise.
function ____exports.HasModifierContainsName(unit, name)
    if not ____exports.IsValidUnit(unit) then
        return false
    end
    local modifierCount = unit:NumModifiers()
    do
        local i = 0
        while i < modifierCount do
            local modifierName = unit:GetModifierName(i)
            if (string.find(modifierName, name, nil, true) or 0) - 1 > -1 then
                return true
            end
            i = i + 1
        end
    end
    return false
end
--- Check if the unit is near an enemy second tier tower.
-- 
-- @param unit - The unit to check.
-- @param range - The range to check.
-- @returns True if the unit is near an enemy second tier tower, false otherwise.
function ____exports.IsNearEnemySecondTierTower(unit, range)
    for ____, towerId in ipairs(____exports.SecondTierTowers) do
        local tower = GetTower(
            GetOpposingTeam(),
            towerId
        )
        if tower ~= nil and ____exports.IsValidBuilding(tower) and GetUnitToUnitDistance(unit, tower) < range then
            return true
        end
    end
    return false
end
--- Get the enemy ids near non-tier 1 towers.
-- 
-- @param range - The range to check.
-- @returns An object with tower ids as keys and their corresponding enemy ids.
function ____exports.GetEnemyIdsNearNonTier1Towers(range)
    local result = {}
    for ____, towerId in ipairs(____exports.NonTier1Towers) do
        local tower = GetTower(
            GetTeam(),
            towerId
        )
        if tower ~= nil and ____exports.IsValidBuilding(tower) then
            local eIds = ____exports.GetLastSeenEnemyIdsNearLocation(
                tower:GetLocation(),
                range
            )
            result[towerId] = {tower = tower, enemyIds = eIds}
        end
    end
    return result
end
--- Get the non-tier 1 tower with the least enemies around.
-- 
-- @param range - The range to check.
-- @returns The non-tier 1 tower with the least enemies around.
function ____exports.GetNonTier1TowerWithLeastEnemiesAround(range)
    local towerEneCounts = ____exports.GetEnemyIdsNearNonTier1Towers(range)
    local minCount = 999
    local minCountTower = nil
    for ____, towerId in ipairs(____exports.NonTier1Towers) do
        local te = towerEneCounts[towerId]
        if te ~= nil and #te.enemyIds <= minCount then
            minCountTower = te.tower
            minCount = #te.enemyIds
        end
    end
    if minCount ~= 0 then
        return minCountTower
    end
    return nil
end
--- Get the closest tower or barrack to attack.
-- 
-- @param unit - The unit to check.
-- @returns The closest tower or barrack to attack.
function ____exports.GetClosestTowerOrBarrackToAttack(unit)
    local closestBuilding = nil
    local closestDistance = 2 ^ 1024
    for ____, barrackE in ipairs(____exports.BarrackList) do
        local barrack = GetBarracks(
            GetOpposingTeam(),
            barrackE
        )
        if barrack ~= nil and barrack:GetHealth() > 0 and not (barrack:HasModifier("modifier_fountain_glyph") or barrack:HasModifier("modifier_invulnerable") or barrack:HasModifier("modifier_backdoor_protection_active")) then
            local distance = GetUnitToUnitDistance(unit, barrack)
            if distance < closestDistance then
                closestDistance = distance
                closestBuilding = barrack
            end
        end
    end
    for ____, towerId in ipairs(____exports.HighGroundTowers) do
        local tower = GetTower(
            GetOpposingTeam(),
            towerId
        )
        if tower ~= nil and ____exports.IsValidBuilding(tower) and not (tower:HasModifier("modifier_fountain_glyph") or tower:HasModifier("modifier_invulnerable") or tower:HasModifier("modifier_backdoor_protection_active")) then
            local distance = GetUnitToUnitDistance(unit, tower)
            if distance < closestDistance then
                closestDistance = distance
                closestBuilding = tower
            end
        end
    end
    return closestBuilding
end
--- Check if the unit is near an enemy high ground tower.
-- 
-- @param unit - The unit to check.
-- @param range - The range to check.
-- @returns True if the unit is near an enemy high ground tower, false otherwise.
function ____exports.IsNearEnemyHighGroundTower(unit, range)
    for ____, towerId in ipairs(____exports.HighGroundTowers) do
        local tower = GetTower(
            GetOpposingTeam(),
            towerId
        )
        if tower ~= nil and ____exports.IsValidBuilding(tower) and GetUnitToUnitDistance(unit, tower) < range then
            return true
        end
    end
    return false
end
--- Check if the team is pushing second tier or high ground.
-- 
-- @param bot - The bot to check.
-- @returns True if the team is pushing second tier or high ground, false otherwise.
function ____exports.IsTeamPushingSecondTierOrHighGround(bot)
    local cachedRes = ____exports.GetCachedVars(
        "IsTeamPushingSecondTierOrHighGround" .. tostring(bot:GetTeam()),
        0.5
    )
    if cachedRes ~= nil then
        return cachedRes
    end
    local res = #bot:GetNearbyHeroes(2000, false, BotMode.None) > 2 and (____exports.IsNearEnemySecondTierTower(bot, 2000) or ____exports.IsNearEnemyHighGroundTower(bot, 3000) or GetUnitToUnitDistance(
        bot,
        GetAncient(GetOpposingTeam())
    ) < 3000)
    ____exports.SetCachedVars(
        "IsTeamPushingSecondTierOrHighGround" .. tostring(bot:GetTeam()),
        res
    )
    return res
end
--- Get the number of alive heroes.
-- 
-- @param bEnemy - Whether to count enemy heroes.
-- @returns The number of alive heroes.
function ____exports.GetNumOfAliveHeroes(bEnemy)
    local count = 0
    local nTeam = GetTeam()
    if bEnemy then
        nTeam = GetOpposingTeam()
    end
    for ____, playerdId in ipairs(GetTeamPlayers(nTeam)) do
        if IsHeroAlive(playerdId) then
            count = count + 1
        end
    end
    return count
end
--- Count the missing enemy heroes.
-- 
-- @returns The number of missing enemy heroes.
function ____exports.CountMissingEnemyHeroes()
    local cachedRes = ____exports.GetCachedVars(
        "CountMissingEnemyHeroes" .. tostring(GetTeam()),
        0.5
    )
    if cachedRes ~= nil then
        return cachedRes
    end
    local count = 0
    for ____, playerdId in ipairs(GetTeamPlayers(GetOpposingTeam())) do
        do
            local __continue230
            repeat
                if IsHeroAlive(playerdId) then
                    local lastSeenInfo = GetHeroLastSeenInfo(playerdId)
                    if lastSeenInfo ~= nil and lastSeenInfo[1] ~= nil then
                        local firstInfo = lastSeenInfo[1]
                        if firstInfo.time_since_seen >= 2.5 then
                            count = count + 1
                            __continue230 = true
                            break
                        end
                    end
                end
                __continue230 = true
            until true
            if not __continue230 then
                break
            end
        end
    end
    ____exports.SetCachedVars(
        "CountMissingEnemyHeroes" .. tostring(GetTeam()),
        count
    )
    return count
end
--- Find an ally with at least a certain distance away from a bot.
-- 
-- @param bot - The bot to check.
-- @param nDistance - The minimum distance to check.
-- @returns The ally if found, null otherwise.
function ____exports.FindAllyWithAtLeastDistanceAway(bot, nDistance)
    if bot:GetTeam() ~= GetTeam() then
        print("[ERROR] Wrong usage of the method")
        return nil
    end
    local teamPlayers = GetTeamPlayers(GetTeam())
    for ____, ____value in __TS__Iterator(__TS__ArrayEntries(teamPlayers)) do
        local index = ____value[1]
        local _ = ____value[2]
        local teamMember = GetTeamMember(index)
        if teamMember ~= nil and teamMember:IsAlive() and GetUnitToUnitDistance(teamMember, bot) >= nDistance then
            return teamMember
        end
    end
    return nil
end
--- Check if the bots should spread out.
-- 
-- @param bot - The bot to check.
-- @param minDistance - The minimum distance to check.
-- @returns True if the bots should spread out, false otherwise.
function ____exports.ShouldBotsSpreadOut(bot, minDistance)
    if #bot:GetNearbyHeroes(minDistance, false, BotMode.None) < 2 then
        return false
    end
    local cachedRes = ____exports.GetCachedVars(
        "ShouldBotsSpreadOut" .. tostring(bot:GetPlayerID()),
        2
    )
    if cachedRes ~= nil then
        return cachedRes
    end
    for ____, hero in ipairs(GetUnitList(UnitType.EnemyHeroes)) do
        if ____exports.IsValidHero(hero) then
            local heroName = hero:GetUnitName()
            if ____exports.HasValue(SpecialAOEHeroes, heroName) then
                if hero:GetLevel() >= 8 then
                    ____exports.SetCachedVars(
                        "ShouldBotsSpreadOut" .. tostring(bot:GetPlayerID()),
                        true
                    )
                    return true
                end
            else
                ____exports.SetCachedVars(
                    "ShouldBotsSpreadOut" .. tostring(bot:GetPlayerID()),
                    false
                )
            end
            if heroName == HeroName.TrollWarlord then
                if ____exports.HasItem(hero, "item_bfury") and hero:HasModifier("modifier_troll_warlord_battle_trance") and hero:GetAttackRange() < 500 then
                    ____exports.SetCachedVars(
                        "ShouldBotsSpreadOut" .. tostring(bot:GetPlayerID()),
                        true
                    )
                    return true
                end
            end
        end
    end
    ____exports.SetCachedVars(
        "ShouldBotsSpreadOut" .. tostring(bot:GetPlayerID()),
        false
    )
    return false
end
--- Get the ally ids in teleport to a location.
-- 
-- @param vLoc - The location to check.
-- @param nDistance - The distance to check.
-- @returns An array of ally ids.
function ____exports.GetAllyIdsInTpToLocation(vLoc, nDistance)
    local allies = {}
    for ____, tp in ipairs(GetIncomingTeleports()) do
        if tp ~= nil and ____exports.GetLocationToLocationDistance(vLoc, tp.location) <= nDistance and IsTeamPlayer(tp.playerid) then
            allies[#allies + 1] = tp.playerid
        end
    end
    return allies
end
--- Check if the bot is pushing a tower in danger.
-- 
-- @param bot - The bot to check.
-- @returns True if the bot is pushing a tower in danger, false otherwise.
function ____exports.IsBotPushingTowerInDanger(bot)
    local enemyTowerNearby = #bot:GetNearbyTowers(1100, true) >= 1
    if not enemyTowerNearby then
        return false
    end
    local nearbyAllies = bot:GetNearbyHeroes(1600, false, BotMode.None)
    local countAliveEnemies = ____exports.GetNumOfAliveHeroes(true)
    local nearbyEnemy = ____exports.GetLastSeenEnemyIdsNearLocation(
        bot:GetLocation(),
        2000
    )
    if enemyTowerNearby and #nearbyAllies < countAliveEnemies and #nearbyEnemy >= #nearbyAllies then
        return true
    end
    return false
end
--- Get the distance to the closest enemy tower.
-- 
-- @param bot - The bot to check.
-- @returns The distance to the closest enemy tower.
function ____exports.GetDistanceToCloestEnemyTower(bot)
    local cTower = nil
    local cDistance = 99999
    for ____, towerId in ipairs(____exports.AllTowers) do
        local tower = GetTower(
            GetOpposingTeam(),
            towerId
        )
        if tower ~= nil and ____exports.IsValidBuilding(tower) and not (tower:HasModifier("modifier_fountain_glyph") or tower:HasModifier("modifier_invulnerable") or tower:HasModifier("modifier_backdoor_protection_active")) then
            local tDistance = GetUnitToUnitDistance(bot, tower)
            if tDistance < cDistance then
                cTower = tower
                cDistance = tDistance
            end
        end
    end
    return cDistance, cTower
end
--- Get circular points around a center point.
-- 
-- @param vCenter - The center point.
-- @param nRadius - The radius of the circle.
-- @param numPoints - The number of points to get.
-- @returns An array of vectors representing the points.
function ____exports.GetCirclarPointsAroundCenterPoint(vCenter, nRadius, numPoints)
    local points = {vCenter}
    local angleStep = 360 / numPoints
    do
        local i = 1
        while i <= numPoints do
            local angleRad = angleStep * i * (math.pi / 180)
            local point = Vector(
                vCenter.x + nRadius * math.cos(angleRad),
                vCenter.y + nRadius * math.sin(angleRad),
                vCenter.z
            )
            points[#points + 1] = point
            i = i + 1
        end
    end
    return points
end
--- Check if the ability is valid.
-- 
-- @param ability - The ability to check.
-- @returns True if the ability is valid, false otherwise.
function ____exports.IsValidAbility(ability)
    if ability == nil or ability:IsNull() or ability:GetName() == "" or ability:IsHidden() or not ability:IsTrained() or not ability:IsActivated() then
        return false
    end
    return true
end
--- Check if the bot has a critical spell with a cooldown greater than nDuration.
-- 
-- @param bot - The bot to check.
-- @param nDuration - The duration to check against.
-- @returns True if the bot has a critical spell with a cooldown greater than nDuration, false otherwise.
function ____exports.HasCriticalSpellWithCooldown(bot, nDuration)
    local cacheKey = ("HasCriticalSpellWithCooldown" .. tostring(bot:GetPlayerID())) .. tostring(nDuration)
    local cachedRes = ____exports.GetCachedVars(cacheKey, 2)
    if cachedRes ~= nil then
        return cachedRes
    end
    local heroName = bot:GetUnitName()
    if ____exports.ImportantSpells[heroName] ~= nil then
        local ability = bot:GetAbilityByName(____exports.ImportantSpells[heroName][1])
        if ____exports.IsValidAbility(ability) and ability:GetCooldownTimeRemaining() > nDuration then
            ____exports.SetCachedVars(cacheKey, true)
            return true
        end
    end
    ____exports.SetCachedVars(cacheKey, false)
    return false
end
--- Get an item from the bot's active inventory.
-- 
-- @param bot - The bot to check.
-- @param itemName - The name of the item to get.
-- @returns The item if found, null otherwise.
function ____exports.GetItem(bot, itemName)
    return ____exports.GetItemFromCountedInventory(bot, itemName, 6)
end
--- Get an item from the bot's full inventory.
-- 
-- @param bot - The bot to check.
-- @param itemName - The name of the item to get.
-- @returns The item if found, null otherwise.
function ____exports.GetItemFromFullInventory(bot, itemName)
    return ____exports.GetItemFromCountedInventory(bot, itemName, 16)
end
--- Check if the team has a member with a critical spell in cooldown when the bot walks & arrives to the location.
-- 
-- @param bot - The bot to check.
-- @param targetLoc - The location to check.
-- @returns True if the team has a member with a critical spell in cooldown, false otherwise.
function ____exports.HasTeamMemberWithCriticalSpellInCooldown(targetLoc)
    local cacheKey = (("HasTeamMemberWithCriticalSpellInCooldown" .. tostring(GetTeam())) .. tostring(targetLoc.x)) .. tostring(targetLoc.y)
    local cachedRes = ____exports.GetCachedVars(cacheKey, 2)
    if cachedRes ~= nil then
        return cachedRes
    end
    for ____, ____value in __TS__Iterator(__TS__ArrayEntries(GetTeamPlayers(GetTeam()))) do
        local index = ____value[1]
        local _ = ____value[2]
        local teamMember = GetTeamMember(index)
        if teamMember ~= nil and teamMember:IsAlive() then
            local nDuration = GetUnitToLocationDistance(teamMember, targetLoc) / teamMember:GetCurrentMovementSpeed()
            if ____exports.HasCriticalSpellWithCooldown(teamMember, nDuration) then
                ____exports.SetCachedVars(cacheKey, true)
                print((("HasTeamMemberWithCriticalSpellInCooldown: " .. tostring(teamMember:GetUnitName())) .. " ") .. tostring(nDuration))
                return true
            end
        end
    end
    ____exports.SetCachedVars(cacheKey, false)
    return false
end
--- Check if the team has a member with a critical item in cooldown when the bot walks & arrives to the location.
-- 
-- @param bot - The bot to check.
-- @param targetLoc - The location to check.
-- @returns True if the team has a member with a critical item in cooldown, false otherwise.
function ____exports.HasTeamMemberWithCriticalItemInCooldown(targetLoc)
    local cacheKey = (("HasTeamMemberWithCriticalItemInCooldown" .. tostring(GetTeam())) .. tostring(targetLoc.x)) .. tostring(targetLoc.y)
    local cachedRes = ____exports.GetCachedVars(cacheKey, 2)
    if cachedRes ~= nil then
        return cachedRes
    end
    for ____, ____value in __TS__Iterator(__TS__ArrayEntries(GetTeamPlayers(GetTeam()))) do
        local index = ____value[1]
        local _ = ____value[2]
        local teamMember = GetTeamMember(index)
        if teamMember ~= nil and teamMember:IsAlive() then
            local nDuration = GetUnitToLocationDistance(teamMember, targetLoc) / teamMember:GetCurrentMovementSpeed()
            for ____, itemName in ipairs(____exports.ImportantItems) do
                local item = ____exports.GetItem(teamMember, itemName)
                if item and item:GetCooldownTimeRemaining() > nDuration then
                    ____exports.SetCachedVars(cacheKey, true)
                    print((((("HasTeamMemberWithCriticalItemInCooldown: " .. tostring(teamMember:GetUnitName())) .. " ") .. tostring(itemName)) .. " ") .. tostring(item:GetCooldownTimeRemaining()))
                    return true
                end
            end
        end
    end
    ____exports.SetCachedVars(cacheKey, false)
    return false
end
return ____exports
