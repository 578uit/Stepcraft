return Def.ActorFrame{

	-- Coming soon
	
	--[[LoadFont("_minecraft 14px")..{
		Text="READY!";
		InitCommand=cmd(x,SCREEN_LEFT+208;y,SCREEN_BOTTOM-150;skewx,-0.16;diffuse,color("#FF0707");zoom,1);
		ExitSelectedP1Command=cmd(stoptweening;zoom,0;bounceend,.2;zoom,1);
		ExitUnselectedP1Command=cmd(stoptweening;bouncebegin,.2;zoom,0);
		OffCommand=cmd(stoptweening;bouncebegin,.1;zoom,0);
	};
	LoadFont("_minecraft 14px")..{
		Text="READY!";
		InitCommand=cmd(x,SCREEN_RIGHT-208;y,SCREEN_BOTTOM-150;skewx,0.16;diffuse,color("#60AEF6");zoom,1);
		ExitSelectedP2Command=cmd(stoptweening;zoom,0;bounceend,.2;zoom,1);
		ExitUnselectedP2Command=cmd(stoptweening;bouncebegin,.2;zoom,0);
		OffCommand=cmd(stoptweening;bouncebegin,.1;zoom,0);
	};]]--
}