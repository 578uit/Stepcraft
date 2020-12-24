local t = Def.ActorFrame {};

local EvalPages = 2

local PageInd = {
	["PlayerNumber_P1"] = 1,
	["PlayerNumber_P2"] = 1,
};

local ScrollLock = {
	["PlayerNumber_P1"] = false,
	["PlayerNumber_P2"] = false,
}

local function side(pn)
	local s = 1
	if pn == PLAYER_1 then return s end
	return s*(-1)
end

local function CheckValueOffsets(pn)
	if PageInd[pn] > EvalPages then PageInd[pn] = EvalPages return end
	if PageInd[pn] < 1 then PageInd[pn] = 1 return end
	setenv("PageIndex", PageInd)
	setenv("APNow", pn)
	MESSAGEMAN:Broadcast("PageUpdated")
	return
end

local function ChangeValOffset(item,player,val)
	item[player] = item[player] + val
	CheckValueOffsets(player)
end

local eval_parts = Def.ActorFrame {}

for ip, p in ipairs(GAMESTATE:GetHumanPlayers()) do
	for i=1,EvalPages do
		eval_parts[#eval_parts+1] = Def.ActorFrame{
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X+(-145*side(p)),SCREEN_CENTER_Y+54)
			self:addx( (-SCREEN_WIDTH/2)*side(p) )
			:sleep(3):decelerate(0.3)
			:addx( (SCREEN_WIDTH/2)*side(p) )
		end,
		OffCommand=function(self)
			self:accelerate(0.3):addx( (-SCREEN_WIDTH/2)*side(p) )
		end;
		LoadActor("./Pane"..i.."/default.lua", p)..{
			OnCommand=function(self)
				local match = (PageInd[p] == i)
				self:diffusealpha( match and 1 or 0 )
			end;
			PageUpdatedMessageCommand=function(self,player)
				local match = (PageInd[p] == i)
				self:finishtweening():decelerate(0.25):diffusealpha( match and 1 or 0 )
			end;
			},
		};
	end
end

t[#t+1] = eval_parts;

local BTInput = {
	-- This will control the menus
	["MenuRight"] = function(PlEv) ChangeValOffset(not ScrollLock[PlEv] and PageInd , PlEv, 1) end,
	["MenuLeft"] = function(PlEv) ChangeValOffset(not ScrollLock[PlEv] and PageInd , PlEv, -1) end,
};

local function InputHandler(event)
	-- Safe check to input nothing if any value happens to be not a player.
	-- ( AI, or engine input )
	if not event.PlayerNumber then return end
	local ET = ToEnumShortString(event.type)
	-- Input that occurs at the moment the button is pressed.
	if ET == "FirstPress" or ET == "Repeat" then
			if GAMESTATE:IsHumanPlayer(event.PlayerNumber) and BTInput[event.GameButton] then
					BTInput[event.GameButton](event.PlayerNumber)
					MESSAGEMAN:Broadcast( event.GameButton.. ToEnumShortString(event.PlayerNumber) .."Pressed" )
			end
	end
end

local Controller = Def.ActorFrame{
	OnCommand=function(self)
	SCREENMAN:GetTopScreen():AddInputCallback(InputHandler) end;
};

t[#t+1] = Controller;


return t