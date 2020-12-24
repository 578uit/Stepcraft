local t = Def.ActorFrame{
	InitCommand=function(self)
		PROFILEMAN:SetStatsPrefix("Casual-")
		SL.Global.GameMode = "Creative"
		SetGameModePreferences()
		THEME:ReloadMetrics()
	end,
	LoadActor("bar.lua")..{
	},
	LoadActor("creative.lua")..{
	},
	LoadActor("banner.lua")..{
	},
	LoadActor("../clock")..{
	},
	
	LoadActor( THEME:GetPathG('ScreenSelectMusic','StepsDisplayList') )..{
		OnCommand=function(self)
			self:x(650):y(92):zoomx(1):zoomy(0.94)
		end;
		OffCommand=function(self)
			self:accelerate(0.5):addx(300)
		end;
	},
	LoadActor( THEME:GetPathG('ScreenSelectMusic','ArtistDisplay') )..{
		OnCommand=function(self)
			self:x(SCREEN_CENTER_X-32):y(182):zoomx(1):zoomy(0.94)
		end;
		OffCommand=function(self)
			self:linear(0.2):zoomy(0)
		end;
	},
	Def.BitmapText{
		Font="_minecraft 14px",
		Text="BPM:",
		OnCommand=function(self)
			self:x(SCREEN_CENTER_X-15):y(202):zoomx(1):zoomy(0.94)
		end;
		OffCommand=function(self)
			self:linear(0.2):zoomy(0)
		end;
	},
	Def.BitmapText{
		Font="_minecraft 14px",
		Text="Length:",
		OnCommand=function(self)
			self:x(SCREEN_CENTER_X):y(222):zoomx(1):zoomy(0.94)
		end;
		OffCommand=function(self)
			self:linear(0.2):zoomy(0)
		end;
	},
	Def.BitmapText{
		Font="_minecraft 14px",
		Text="Folder:",
		OnCommand=function(self)
			self:x(SCREEN_CENTER_X):y(242):zoomx(1):zoomy(0.94)
		end;
		OffCommand=function(self)
			self:linear(0.2):zoomy(0)
		end;
	},
	Def.BitmapText{
		Font="_minecraft 14px",
		OnCommand=function(self)
			self:x(SCREEN_CENTER_X+40):y(242):zoomx(1):zoomy(0.94):horizalign('left'):maxwidth(375)
		end;
		CurrentSongChangedMessageCommand= cmd(queuecommand,"Update"),
		Text= "",
		UpdateCommand= SSMSongLocText,
	},
	LoadActor( THEME:GetPathG('ScreenSelectMusic','BPMDisplay') )..{
		OnCommand=function(self)
			self:x(SCREEN_CENTER_X+45):y(202):zoomx(1):zoomy(0.94)
		end;
		OffCommand=function(self)
			self:linear(0.2):zoomy(0)
		end;
	},
	Def.Quad {
	InitCommand=cmd(diffusealpha,0;FullScreen);
	ShowPressStartForOptionsCommand=cmd(linear,0.4;diffuse, Color.Black);
	};
	LoadFont("_minecraft 14px")..{
		InitCommand=cmd(zoom,0.8;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+15;diffuse,color("#FFFFFF");diffusealpha,0),
		ShowPressStartForOptionsCommand=cmd(diffusealpha,0;decelerate,.07;diffusealpha,1;sleep,3;settext,"Press &START; again for options");
		HidePressStartForOptionsCommandCommand=cmd(stoptweening;linear,0.3;cropleft,1.3);
		ShowEnteringOptionsCommand=cmd(stoptweening;zoomy,0;accelerate,.07;zoomy,0.8;sleep,2;settext,"Entering options...");
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
	InitCommand=cmd(diffusealpha,0);
	ShowPressStartForOptionsCommand= cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-10;linear,0.4;diffusealpha,1;sleep,0.02),
    Texture= "diamond 4x2.png",
	},

		-- panedisplay stuff
};
t[#t+1] = StandardDecorationFromFileOptional("SongTime","SongTime") .. {
	SetCommand=function(self)
		local curSelection = nil;
		local length = 0.0;
		if GAMESTATE:IsCourseMode() then
			curSelection = GAMESTATE:GetCurrentCourse();
			self:playcommand("Reset");
			if curSelection then
				local trail = GAMESTATE:GetCurrentTrail(GAMESTATE:GetMasterPlayerNumber());
				if trail then
					length = TrailUtil.GetTotalSeconds(trail);
				else
					length = 0.0;
				end;
			else
				length = 0.0;
			end;
		else
			curSelection = GAMESTATE:GetCurrentSong();
			self:playcommand("Reset");
			if curSelection then
				length = curSelection:MusicLengthSeconds();
				if curSelection:IsLong() then
					self:playcommand("Long");
				elseif curSelection:IsMarathon() then
					self:playcommand("Marathon");
				else
					self:playcommand("Reset");
				end
			else
				length = 0.0;
				self:playcommand("Reset");
			end;
		end;
		self:settext( SecondsToMSS(length) );
	end;
	CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
	CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
	CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");
	OffCommand=function(self)
		self:linear(0.5):zoomy(0)
	end;
	
}

for player in ivalues(PlayerNumber) do
	t[#t+1] = LoadActor( THEME:GetPathG('ScreenSelectMusic','PaneDisplay'), player )..{
		Condition=GAMESTATE:IsHumanPlayer(player);
		OnCommand=function(self)
			self:x(player == PLAYER_1 and SCREEN_CENTER_X+105 or SCREEN_CENTER_X+155)
			:y(player == PLAYER_1 and SCREEN_BOTTOM-185 or SCREEN_BOTTOM-95):zoomy(0):sleep(0.5):linear(0.3):zoomy(1)
		end;
		OffCommand=function(self)
			self:linear(0.3):zoomy(0)
		end;
	};
end

return t
		
