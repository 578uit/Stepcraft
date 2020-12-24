return Def.ActorFrame{
	Def.Quad {
	InitCommand=cmd(FullScreen; diffuse, Color.Black);
	StartTransitioningCommand=cmd(diffusealpha,1);
	OffCommand=cmd(linear,0.4;diffusealpha,0);
	};
	Def.Sprite{
    Name= "xtl_actor_go",
    Frames= {
      {Frame= 0, Delay= 0.25},
      {Frame= 1, Delay= 0.25},
      {Frame= 0, Delay= 0.25},
      {Frame= 2, Delay= 0.25},
  },
    OnCommand= cmd(sleep,0.02;queuecommand,"SetMe"),
    SetMeCommand= function(self)
		self:x(SCREEN_CENTER_X)
		self:y(SCREEN_CENTER_Y-10)
		end,
	OffCommand=cmd(linear,0.4;diffusealpha,0);
    Texture= "face 3x1.png",
  },
	LoadFont("_minecraft 14px")..{
		Text="Loading Profile...",
		InitCommand=cmd(zoom,0.8;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+15;diffuse,color("#FFFFFF");diffusealpha,1),
		OffCommand=cmd(linear,0.4;diffusealpha,0);
	},
	Def.Actor {
	BeginCommand=function(self)
		if SCREENMAN:GetTopScreen():HaveProfileToLoad() then self:sleep(2); end;
		self:queuecommand("Load");
	end;
	LoadCommand=function() SCREENMAN:GetTopScreen():Continue(); end;
	}
}