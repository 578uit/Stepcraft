return Def.Quad {
	InitCommand=function(self) self:FullScreen():diffuse(Color.Black):diffusealpha(0) end,
	StartTransitioningCommand=function(self) self:sleep(0.1):linear(0.4):diffusealpha(1) end,
}