local function getPlayerBPM(pn)
	local ts = SCREENMAN:GetTopScreen()
	if ts:GetScreenType() == 'ScreenType_Gameplay' then
		return ts:GetTrueBPS(pn) * 60
	end
	return 0
end

local t = Def.ActorFrame {}

if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
	t[#t+1] = LoadFont("Common Normal") .. {
	    Name="Player1BPM";
		InitCommand = function(self)
			self:pulse()
			self:effectclock('bgm')
			self:effectmagnitude(0.9,1,0)
			self:effectperiod(1)
		end;
	    OnCommand = function(self)
	        self:x(SCREEN_CENTER_X):y(SCREEN_TOP+64):zoom(1)
		end;
		OffCommand=cmd(decelerate,0.8;diffusealpha,0);
	};
end;

if GAMESTATE:IsPlayerEnabled(PLAYER_2) and not GAMESTATE:IsPlayerEnabled(PLAYER_1) then
	t[#t+1] = LoadFont("Common Normal") .. {
	    Name="Player2BPM";
		InitCommand = function(self)
			self:pulse()
			self:effectclock('bgm')
			self:effectmagnitude(0.9,1,0)
			self:effectperiod(1)
		end;
	    OnCommand = function(self)
	        self:x(SCREEN_CENTER_X):y(SCREEN_TOP+64):zoom(1)	
		end;
		OffCommand=cmd(decelerate,0.8;diffusealpha,0);
	};
end;

-- Updates bpm text.
local function Update(self)
	t.InitCommand=cmd(SetUpdateFunction,Update)

	if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
		self:GetChild("Player1BPM"):settextf("%.2f",getPlayerBPM(PLAYER_1))
	end
	if GAMESTATE:IsPlayerEnabled(PLAYER_2) and not GAMESTATE:IsPlayerEnabled(PLAYER_1) then
		self:GetChild("Player2BPM"):settextf("%.2f",getPlayerBPM(PLAYER_2))
	end
end

if true then
	t.InitCommand=cmd(SetUpdateFunction,Update)
end

return t