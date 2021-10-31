return Def.ActorFrame{
	Def.Quad {
		InitCommand=function(self) self:FullScreen():diffuse(Color.Black) end,
		StartTransitioningCommand=function(self) self:diffusealpha(1) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end,
	};
	Def.Sprite{
		Frames= {
		  {Frame= 0, Delay= 0.25},
		  {Frame= 1, Delay= 0.25},
		  {Frame= 0, Delay= 0.25},
		  {Frame= 2, Delay= 0.25},
		},
		OnCommand=function(self)
			self:x(SCREEN_CENTER_X)
			self:y(SCREEN_CENTER_Y-10)
		end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end,
		Texture= "face 3x1.png",
	},
	LoadFont("_minecraft 14px")..{
		Text="Loading Profile...",
		InitCommand=function(self) self:zoom(0.8):x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y+15):diffuse(color("#FFFFFF")):diffusealpha(1) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end,
	},
	Def.Actor{
		BeginCommand=function(self)
			if SCREENMAN:GetTopScreen():HaveProfileToLoad() then self:sleep(2); end;
			self:queuecommand("Load");
		end;
		LoadCommand=function() SCREENMAN:GetTopScreen():Continue() end;
	}
}