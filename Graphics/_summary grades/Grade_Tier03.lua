local pss = ...

return Def.ActorFrame{
	LoadActor("star.lua", pss)..{
		OnCommand=cmd(x,-39;y,40;zoom,0.6;pulse;effectmagnitude,1,0.9,0;wag;effectmagnitude,0,0,2);
	},
	LoadActor("star.lua", pss)..{
		OnCommand=cmd(x,39;y,-40;zoom,0.6;effectoffset,0.2;pulse;effectmagnitude,0.9,1,0;wag;effectmagnitude,0,0,2);
	},
	LoadActor("expulosiv.lua")..{
	},
}
