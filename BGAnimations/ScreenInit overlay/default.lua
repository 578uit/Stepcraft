local t = Def.ActorFrame{
	LoadActor("_white.png")..{
		InitCommand=cmd(FullScreen),
	},
	LoadActor("mojang.png")..{
		InitCommand=cmd(diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y),
		OnCommand=function(self)
			self:sleep(1):linear(0.5):diffusealpha(1)
		end,
	},
}

return t
		
	