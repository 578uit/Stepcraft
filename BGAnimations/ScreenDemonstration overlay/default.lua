local t = Def.ActorFrame{
	Def.Quad{
		Name="TopFrame";
		InitCommand=cmd(CenterX;y,SCREEN_TOP;valign,0;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT*0.15;diffuse,color("0,0,0,1");fadebottom,0.5);
	};

	Def.Quad{
		Name="BotFrame";
		InitCommand=cmd(CenterX;y,SCREEN_BOTTOM;valign,1;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT*0.15;diffuse,color("0,0,0,1");fadetop,0.5);
	};

	Def.ActorFrame{
		Name="MiddleSection";
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y*1.35);
		Def.Quad{
			Name="Frame";
			InitCommand=cmd(zoomto,SCREEN_WIDTH,0;diffuse,color("0.1,0.1,0.1,0.75");fadebottom,0.25;fadetop,0.25;);
			OnCommand=cmd(smooth,0.75;zoomtoheight,64;);
		};
		LoadFont("Common normal")..{
			Text="Demonstration";
			InitCommand=cmd(diffusealpha,0;strokecolor,color("0,0,0,0.5"));
			OnCommand=cmd(smooth,0.75;diffusealpha,1;diffuseshift;effectcolor1,HSV(38,0.45,0.95));
		};
	};
};

return t;