return Def.ActorFrame{
	InitCommand=function(self)
		self:y(SCREEN_TOP+42)
	end;
	LoadActor("arrow")..{
	InitCommand=function(self)
		self:x(SCREEN_CENTER_X):diffuse(color("#FF0707"))
	end;
	},
	LoadActor("arrow")..{
	InitCommand=function(self)
		self:rotationz(180):x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y+150):diffuse(color("#60AEF6"))
	end;
	},
}