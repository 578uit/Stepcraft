local sBannerPath = THEME:GetPathG("Common", "fallback jacket");
local sJacketPath = THEME:GetPathG("Common", "fallback jacket");
local bAllowJackets = true
local song;
local group;
local getOn = 0;
local getOff = 0;

centerObjectProxy = nil;

--main backing
local t = Def.ActorFrame {


Def.Quad {
	InitCommand=cmd(setsize,300,96;diffuse,color("#00000090"));
};
	LoadFont("_minecraft 14px") .. {
		InitCommand=cmd(x,-70;y,30;finishtweening;draworder,100;zoom,0.8);
		OnCommand=function(self)
			self:settext("Number of Songs:")
		end;
	};
	LoadFont("_minecraft 14px") .. {
		InitCommand=cmd(x,80;y,-30;finishtweening;draworder,100;zoom,0.8);
		OnCommand=function(self)
			self:settext("Pack selected")
		end;
	};
};

--if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
--	t[#t+1] = LoadActor("diff.lua",PLAYER_1)..{
--		InitCommand=cmd(xy,-61,-85);
--	}
--end;

--if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
--	t[#t+1] = LoadActor("diff.lua",PLAYER_2)..{
--		InitCommand=cmd(xy,61,-85);
--	}
--end;

return t;
