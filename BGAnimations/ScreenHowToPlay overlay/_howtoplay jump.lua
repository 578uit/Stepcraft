return Def.ActorFrame {
	LoadActor(THEME:GetPathB("_frame","3x3"),"rounded black",380,80);
	Def.Quad {
		Name="Underline";
		InitCommand=cmd(y,-12);
		OnCommand=cmd(diffuse,color("#ffd400");shadowlength,1;zoomtowidth,192;fadeleft,0.25;faderight,0.25);
	};
	LoadFont("_minecraft 14px") .. {
		Text="JUMP";
		InitCommand=cmd(y,-26);
		OnCommand=cmd(skewx,-0.125;diffuse,color("#ffd400");shadowlength,2;shadowcolor,BoostColor(color("#ffd40077"),0.25))
	};
	LoadFont("_minecraft 14px") .. {
		Text="Hit 2 arrows at the same time when they reached the receptor!";
		InitCommand=cmd(y,18;wrapwidthpixels,480;vertspacing,0;shadowlength,1);
		OnCommand=cmd(zoom,0.875);
	};
};
