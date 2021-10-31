local gc = Var("GameCommand")
local string_expl = THEME:GetString(Var "LoadingScreen", "Explanation" .. gc:GetName());
local t = Def.ActorFrame {}
t[#t+1] = Def.ActorFrame {
	OnCommand=function(self) self:diffusealpha(0):linear(0.4):diffusealpha(1) end,
	OffCommand=function(self) self:decelerate(0.6):diffusealpha(0) end,
	
	LoadActor(gc:GetName()) .. {
		InitCommand=function(self) self:zoom(0.4):addy(-60) end,
		GainFocusCommand=function(self) self:diffusealpha(1.0) end,
		LoseFocusCommand=function(self) self:diffusealpha(0) end,
	},
	LoadFont("_minecraft 14px")..{
		Text=string.upper(gc:GetText()),
		InitCommand=function(self) self:horizalign(center):addy(100):zoom(2) end,
		GainFocusCommand=function(self) self:diffusealpha(1) end,
		LoseFocusCommand=function(self) self:diffusealpha(0) end,
	},
	LoadActor("left.png")..{
		InitCommand=function(self)	self:x(SCREEN_CENTER_X-750):addy(100):zoom(2) end,
		OffCommand=function(self) self:accelerate(0.5):addx(-200) end,
	},
	LoadActor("right.png")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-100):addy(100):zoom(2) end,
		OffCommand=function(self) self:accelerate(0.5):addx(200) end,
	},
	LoadFont("_minecraft 14px")..{
		Text=string_expl,
		InitCommand=function(self) self:horizalign(center):addy(190):zoom(1) end,
		GainFocusCommand=function(self) self:diffusealpha(1) end,
		LoseFocusCommand=function(self) self:diffusealpha(0) end,
	},
}
return t
