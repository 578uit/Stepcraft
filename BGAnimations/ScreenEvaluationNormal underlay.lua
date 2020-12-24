local newBPS, oldBPS
local swoosh, move

local Update = function(self)

	newBPS = GAMESTATE:GetSongBPS()
	move = (newBPS*-1)/32

	if GAMESTATE:GetSongFreeze() then move = 0 end
	if swoosh1 then swoosh1:texcoordvelocity(move,0) end
	if swoosh2 then swoosh2:texcoordvelocity(move,0) end

	oldBPS = newBPS
end

local t = Def.ActorFrame{
	InitCommand=function(self) self:SetUpdateFunction(Update) end,
	LoadActor("arrow")..{
	InitCommand=function(self)
		self:x(SCREEN_CENTER_X):y(SCREEN_TOP+40):diffuse(color("#FF0707"))
		self:customtexturerect(0,0,1,1)
		swoosh1 = self
	end;
	},
	LoadActor("arrow")..{
	InitCommand=function(self)
		self:rotationz(180):x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y+194):diffuse(color("#60AEF6"))
		self:customtexturerect(0,0,1,1)
		swoosh2 = self
	end;
	},
}
if ThemePrefs.Get("BetterEvaluationScreen") then
  t[#t+1] = Def.Sound{
		IsAction = true;
		File=GAMESTATE:GetCurrentSong():GetMusicPath();
		OnCommand=function(self)
			local audio = self:get()
			audio:volume(0.05)
			self:play()
		end;
		OffCommand=function(self)
			self:stop()
		end;
  };
end
return t