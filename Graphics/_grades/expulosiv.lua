return Def.ActorFrame{
	LoadActor("../_grades/graphics/Arrows_minisplode.png")..{
		OnCommand=cmd(rotationz,10;zoom,.5;diffusealpha,1;linear,0.4;rotationz,0;zoom,3;diffusealpha,0),
	}
}
