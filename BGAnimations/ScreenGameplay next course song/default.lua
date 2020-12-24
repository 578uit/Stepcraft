local t = Def.ActorFrame{};

if not GAMESTATE:IsCourseMode() then return t; end;

t[#t+1] = Def.Sprite {
	InitCommand=cmd(Center);
	BeforeLoadingNextCourseSongMessageCommand=function(self) self:LoadFromSongBackground( SCREENMAN:GetTopScreen():GetNextCourseSong() ) end;
	ChangeCourseSongInMessageCommand=cmd(scale_or_crop_background);
	StartCommand=cmd(diffusealpha,0;decelerate,0.5;diffusealpha,1);
	FinishCommand=cmd(linear,0.5;glow,Color.Alpha(Color("White"),0.5);decelerate,0.4;glow,Color("Invisible");diffusealpha,0);
};

t[#t+1] = Def.BitmapText {
	Font="_minecraft 14px";
	Text="Taking a quick break?";
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoom,1.2;decelerate,0.4;diffusealpha,0),
};

return t;