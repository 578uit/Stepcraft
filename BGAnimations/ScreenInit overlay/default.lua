local t = Def.ActorFrame{
	LoadActor("_white.png")..{
		InitCommand=function(self) self:FullScreen() end,
	},
	LoadActor("mojang.png")..{
		InitCommand=function(self) self:diffusealpha(0):x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y) end,
		OnCommand=function(self)
			self:sleep(1):linear(0.5):diffusealpha(1)
		end,
	},
}

return t
		
	