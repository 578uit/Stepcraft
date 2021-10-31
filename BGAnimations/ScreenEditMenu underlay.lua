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
	Def.Quad{
		Name= "xtl_actor_c",
		InitCommand=function(self) self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y):zoomto(_screen.w/1.2,_screen.h/1.5):diffuse(color("#000000")):diffusealpha(0.55) end,
	},
	Def.Quad{
		Name= "xtl_actor_d",
		InitCommand=function(self) self:x(SCREEN_CENTER_X-360):y(SCREEN_CENTER_Y):zoomto(_screen.w/160,_screen.h/1.5):diffuse(color("#FFFFFF")):diffusealpha(1) end,
	},
	Def.Quad{
		Name= "xtl_actor_e",
		InitCommand=function(self) self:x(SCREEN_CENTER_X+360):y(SCREEN_CENTER_Y):zoomto(_screen.w/160,_screen.h/1.5):diffuse(color("#FFFFFF")):diffusealpha(1) end,
	},
	Def.Quad{
		Name= "xtl_actor_f",
		InitCommand=function(self) self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y+158):zoomto(_screen.w/1.179,_screen.h/96):diffuse(color("#FFFFFF")):diffusealpha(1) end,
	},
	Def.Quad{
		Name= "xtl_actor_f",
		InitCommand=function(self) self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y-158):zoomto(_screen.w/1.179,_screen.h/96):diffuse(color("#FFFFFF")):diffusealpha(1) end,
	},
}

return t
