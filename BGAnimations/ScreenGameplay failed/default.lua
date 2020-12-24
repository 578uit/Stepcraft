return Def.ActorFrame {
	Def.Sound{
		File="bleh",
		StartTransitioningCommand=function(self)
			self:play()
		end;
	},
	Def.Quad{
		InitCommand=cmd(sleep,0),
		OnCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;diffuse, Color.Black;diffusealpha,1;fadeleft,0.3;faderight,0.3;cropleft,1.3;cropright,-0.3;linear,1;cropleft,-0.3),
	},
	LoadFont("_minecraft 14px")..{
		Text="YOU DIED!",
		InitCommand=cmd(zoom,0.8;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+15;diffuse,color("#FFFFFF");diffusealpha,0;linear,0.5;diffusealpha,1),
		OffCommand=cmd(sleep,2;linear,0.4;diffusealpha,0);
	},
	LoadActor("dead")..{
		InitCommand=cmd(zoom,0.8;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-20;diffusealpha,0;linear,0.5;diffusealpha,1),
		OffCommand=cmd(sleep,2;linear,0.4;diffusealpha,0);
	},
}