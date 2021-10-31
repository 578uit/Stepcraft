local t = Def.ActorFrame{
	Def.Sprite{
		Texture="pumpkinblur",
		InitCommand=function(self) self:FullScreen():Center() end,	
	},
	Def.BitmapText{
		Font="_minecraft 14px",
		Text="Your vision is limited to a pumpkin view. Good luck!",
		InitCommand=function(self) self:Center() end,
		OnCommand=function(self)
			self:diffusealpha(0)
			self:zoom(0.9)
			self:linear(0.3)
			self:diffusealpha(1)
			self:sleep(4)
			self:linear(0.3)
			self:diffusealpha(0)
		end,		
	},
}

return t