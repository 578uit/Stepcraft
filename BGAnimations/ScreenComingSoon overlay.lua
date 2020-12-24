return Def.ActorFrame{
	LoadFont("_minecraft 14px")..{
		Text="Please come back later",
		InitCommand=cmd(zoom,1.8;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+20;diffuse,color("#FF0000");diffusealpha,1),
	}
	LoadFont("_minecraft 14px")..{
		Text="This mode is not available right now",
		InitCommand=cmd(zoom,1.8;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-20;diffuse,color("#FF0000");diffusealpha,1),
	}
}