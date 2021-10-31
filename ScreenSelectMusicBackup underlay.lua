local t = Def.ActorFrame{}

if ThemePrefs.Get("ShowSongBG") then
	t[#t+1] = Def.ActorFrame {
		Def.Sprite {
			Condition=not GAMESTATE:IsCourseMode();
			CurrentSongChangedMessageCommand=function(self)
				self:finishtweening():playcommand("Set")
			end;
			SetCommand=function(self)
				if GAMESTATE:GetCurrentSong() then
					local song = GAMESTATE:GetCurrentSong();
					if song:HasBackground() then
						self:visible(true)
						if song:HasPreviewVid() then
							self:LoadBackground(song:GetPreviewVidPath());
						else
							self:LoadBackground(song:GetBackgroundPath());
						end
					elseif not song:HasBackground() then
						self:visible(true)
						if song:HasPreviewVid() then
							self:LoadBackground(song:GetPreviewVidPath());
						else
							self:visible(false)
						end
					end
					
					self:scale_or_crop_background()
				else
					self:visible(false);
				end
			end;
			OffCommand=cmd(decelerate,0.5;diffusealpha,0);
		};
		Def.Quad {
			InitCommand=cmd(Center;scaletoclipped,SCREEN_WIDTH+1,SCREEN_HEIGHT);
			OnCommand=cmd(diffuse,color("#000000");diffusebottomedge,color("#000000");diffusealpha,ThemePrefs.Get("SongBGBrightness"));
		};
	};
	
end;

t[#t+1] = Def.Quad {
	InitCommand=cmd(Center;scaletoclipped,SCREEN_WIDTH-555,SCREEN_HEIGHT;x,SCREEN_CENTER_X-213);
	OnCommand=cmd(diffuse,color("#000000");diffusealpha,0.7);
};


return t