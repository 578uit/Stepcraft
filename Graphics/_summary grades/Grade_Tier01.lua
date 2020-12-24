local pss = ...

local t = Def.ActorFrame{

	--top left
	LoadActor("star.lua", pss)..{
		OnCommand=cmd(x,-46;y,-46;zoom,0.5;pulse;effectmagnitude,1,0.9,0;wag;effectmagnitude,0,0,2);
	};

	--top right
	LoadActor("star.lua", pss)..{
		OnCommand=cmd(x,46;y,-46;zoom,0.5;effectoffset,0.2;pulse;effectmagnitude,0.9,1,0;wag;effectmagnitude,0,0,2);
	};

	-- bottom left
	LoadActor("star.lua", pss)..{
		OnCommand=cmd(x,-46;y,46;zoom,0.5;effectoffset,0.4;pulse;effectmagnitude,0.9,1,0;wag;effectmagnitude,0,0,2);
	};

	--  bottom right
	LoadActor("star.lua", pss)..{
		OnCommand=cmd(x,46;y,46;zoom,0.5;effectoffset,0.6;pulse;effectmagnitude,1,0.9,0;wag;effectmagnitude,0,0,2);
	};
	LoadActor("expulosiv.lua")..{
	},
}

return t;
