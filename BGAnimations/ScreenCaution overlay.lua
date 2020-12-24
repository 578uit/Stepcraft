return Def.ActorFrame{
	LoadFont("_minecraft 14px")..{
		Text="Extreme motions can be dangerous!",
		InitCommand=cmd(zoom,1.8;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color("#FF0000");diffusealpha,0),
		OnCommand=cmd(sleep,1;linear,0.5;diffusealpha,1;glow,color("FFFFFF");glowramp),
	}
}