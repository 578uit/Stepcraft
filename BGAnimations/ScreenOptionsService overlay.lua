return Def.ActorFrame{
	BeginCommand=function(self)
		ThemePrefs.Save()
	end,
	Def.ActorFrame{
		Def.BitmapText{
			Font="_minecraft 14px",
			Text="Service Options",
			InitCommand=function(self) self:xy(SCREEN_LEFT+40,SCREEN_TOP+38) self:skewx(-0.16) self:horizalign(0) end,
			OnCommand=function(self)
				self:zoomx(0):zoomy(6):sleep(0.3):bounceend(.3):zoom(1.4)
			end;
			OffCommand=function(self)
				self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0)
			end;
		},
	},
}
		
