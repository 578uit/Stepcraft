return Def.ActorFrame{
	OnCommand=cmd(zoom,0.85;wag;effectmagnitude,0,0,2);
	LoadActor("graphics/b.png")..{
		OnCommand=cmd(diffusealpha,0;zoom,0;sleep,0.2;decelerate,0.2;zoom,1.5;diffusealpha,1;accelerate,0.2;zoom,1;decelerate,0.1;zoom,0.9;diffusealpha,0.8;accelerate,0.1;zoom,1;diffusealpha,1);
	};
	LoadActor("expulosiv.lua")..{
	};
}
