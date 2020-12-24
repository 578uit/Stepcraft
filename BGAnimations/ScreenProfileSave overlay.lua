return Def.ActorFrame{
	Def.Quad {
	InitCommand=cmd(FullScreen; diffuse, Color.Black);
	StartTransitioningCommand=cmd(diffusealpha,1);
	OffCommand=cmd(linear,0.4;diffusealpha,0);
	};
	Def.Sprite{
    Name= "xtl_actor_go",
    Frames= {
      {Frame= 0, Delay= 0.325},
      {Frame= 1, Delay= 0.125},
      {Frame= 2, Delay= 0.125},
      {Frame= 3, Delay= 0.125},
      {Frame= 4, Delay= 0.125},
      {Frame= 5, Delay= 0.125},
      {Frame= 6, Delay= 0.125},
      {Frame= 7, Delay= 0.325},
  },
    OnCommand= cmd(sleep,0.02;queuecommand,"SetMe"),
    SetMeCommand= function(self)
		self:x(SCREEN_CENTER_X)
		self:y(SCREEN_CENTER_Y-10)
		end,
	OffCommand=cmd(linear,0.4;diffusealpha,0);
    Texture= "diamond 4x2.png",
  },
	LoadFont("_minecraft 14px")..{
		Text="Saving Data...",
		InitCommand=cmd(zoom,0.8;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+15;diffuse,color("#FFFFFF");diffusealpha,1),
		OffCommand=cmd(linear,0.4;diffusealpha,0);
	},
	Def.Actor {
	BeginCommand=function(self)
		if SCREENMAN:GetTopScreen():HaveProfileToSave() then self:sleep(2); end;
		self:queuecommand("Load");
	end;
	LoadCommand=function() SCREENMAN:GetTopScreen():Continue(); end;
	}
}