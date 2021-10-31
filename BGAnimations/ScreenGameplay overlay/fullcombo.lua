local pn = ...;
assert(pn);
local t = Def.ActorFrame{};
local Center1Player = PREFSMAN:GetPreference('Center1Player');
local NumPlayers = GAMESTATE:GetNumPlayersEnabled();
local NumSides = GAMESTATE:GetNumSidesJoined();
local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn);
local st = GAMESTATE:GetCurrentStyle():GetStepsType();

local function GetPosition(pn)
	if Center1Player and NumPlayers == 1 and NumSides == 1 then return SCREEN_CENTER_X; end;
	return THEME:GetMetric("ScreenGameplay","Player".. ToEnumShortString(pn) .. "MiscX");
end;

t[#t+1] = LoadActor("twinkle1") .. {
	OffCommand=function(self)
		if (pss:FullCombo() or pss:FullComboOfScore('TapNoteScore_W3')) then
			self:play();
		end;
	end;
};

t[#t+1] = Def.ActorFrame{
	InitCommand=function(self)
		self:y(SCREEN_CENTER_Y)
		self:x(GetPosition(pn))
	end;

	-- Marvelous FullCombo
	LoadFont("_minecraft 14px")..{
		InitCommand=function(self)
			self:zoom(0)
			self:wag()
			self:effectmagnitude(0,0,2.5)
		end;
		OffCommand=function(self)
			if pss:FullComboOfScore('TapNoteScore_W1') then
				self:settext("PERFECT!");
				self:diffusealpha(0);
				self:diffuse(color("#5DFBF7"));
				self:zoom(0);
				self:sleep(0.2);
				self:diffusealpha(1);
				self:bounceend(0.5);
				self:zoom(1.7);
			elseif pss:FullComboOfScore('TapNoteScore_W2') then
				self:settext("FULL COMBO!");
				self:diffusealpha(0);
				self:diffuse(color("#FFF863"));
				self:zoom(0);
				self:sleep(0.2);
				self:diffusealpha(1);
				self:bounceend(0.5);
				self:zoom(1.7);
			elseif pss:FullComboOfScore('TapNoteScore_W3') then
				self:settext("FULL COMBO!");
				self:diffusealpha(0);
				self:diffuse(color("#4DFF3D"));
				self:zoom(0);
				self:sleep(0.2);
				self:diffusealpha(1);
				self:bounceend(0.5);
				self:zoom(1.7);
			else
				self:visible(false);
			end;
		end;
	};
};

t[#t+1] = Def.ActorFrame{
	InitCommand=function(self)
		self:y(SCREEN_CENTER_Y)
		self:x(GetPosition(pn))
	end;

	-- Marvelous FullCombo
	LoadActor("firework")..{
		InitCommand=function(self)
			self:zoom(0)
		end;
		OffCommand=function(self)
			if pss:FullComboOfScore('TapNoteScore_W1') then
				self:blend("BlendMode_Add");
				self:zoom(0);
				self:diffuse(color("#5DFBF7"));
				self:rotationz(10);
				self:decelerate(1.5);
				self:diffusealpha(0);
				self:rotationz(120);
				self:zoom(1.2);
			elseif pss:FullComboOfScore('TapNoteScore_W2') then
				self:blend("BlendMode_Add");
				self:zoom(0);
				self:diffuse(color("#FFF863"));
				self:rotationz(10);
				self:decelerate(1.5);
				self:diffusealpha(0);
				self:rotationz(120);
				self:zoom(1.2);
			elseif pss:FullComboOfScore('TapNoteScore_W3') then
				self:blend("BlendMode_Add");
				self:zoom(0);
				self:diffuse(color("#4DFF3D"));
				self:rotationz(10);
				self:decelerate(1.5);
				self:diffusealpha(0);
				self:rotationz(120);
				self:zoom(1.2);
			else
				self:visible(false);
			end;
		end;
	};
};

return t;