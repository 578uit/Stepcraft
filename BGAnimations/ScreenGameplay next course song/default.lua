local t = Def.ActorFrame{};

if not GAMESTATE:IsCourseMode() then return t; end;

t[#t+1] = Def.Sprite{
	InitCommand=function(self) self:Center() end,
	BeforeLoadingNextCourseSongMessageCommand=function(self) self:LoadFromSongBackground(SCREENMAN:GetTopScreen():GetNextCourseSong()) end;
	ChangeCourseSongInMessageCommand=function(self) self:scale_or_crop_background() end,
	StartCommand=function(self) self:diffusealpha(0):decelerate(0.5):diffusealpha(1) end,
	FinishCommand=function(self)
		self:linear(0.5):glow(Color.Alpha(Color("White"),0.5)):decelerate(0.4):glow(Color("Invisible")):diffusealpha(0)
	end,
}

t[#t+1] = Def.BitmapText{
	Font="_minecraft 14px";
	Text="Taking a quick break?";
	InitCommand=function(self)
		self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y):zoom(1.2):decelerate(0.4):diffusealpha(0)
	end,
}

return t;