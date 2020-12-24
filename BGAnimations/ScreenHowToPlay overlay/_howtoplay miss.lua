return Def.ActorFrame {
	LoadActor(THEME:GetPathB("_frame","3x3"),"rounded black",380,80);
	Def.Quad {
		Name="Underline";
		InitCommand=cmd(y,-12);
		OnCommand=cmd(diffuse,color("#ffd400");shadowlength,1;zoomtowidth,192;fadeleft,0.25;faderight,0.25);
	};
	LoadFont("_minecraft 14px") .. {
		Text="MISSING NOTES?";
		InitCommand=cmd(y,-26);
		OnCommand=cmd(skewx,-0.125;diffuse,color("#ffd400");shadowlength,2;shadowcolor,BoostColor(color("#ffd40077"),0.25))
	};
	LoadFont("_minecraft 14px") .. {
		Text="It makes your health drain and will give you a game over when your health ran out!";
		InitCommand=cmd(y,18;wrapwidthpixels,480;vertspacing,0;shadowlength,1);
		OnCommand=cmd(zoom,0.75);
	};
};
