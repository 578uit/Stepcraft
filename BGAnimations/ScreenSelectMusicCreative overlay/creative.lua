return Def.ActorFrame{
	Def.ActorFrame{
		OnCommand=function(self)
			self:xy(SCREEN_LEFT+35,SCREEN_TOP+38)
		end,
		Def.BitmapText{
			Font="_minecraft 14px",
			Text="Select Music",
			InitCommand=function(self) self:x(self:GetWidth()/1.2) self:skewx(-0.16) end,
			OnCommand=function(self)
				self:zoomx(0):zoomy(6):sleep(0.3):bounceend(.3):zoom(1.4)
			end,
			OffCommand=function(self)
				self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0)
			end,
		},	
		Def.BitmapText{
			Font="_minecraft 14px",
			Text="",
			InitCommand=function(self) self:x(self:GetWidth()/1.8) self:y(20) self:skewx(-0.16) end,
			OnCommand=function(self)
				self:zoomx(0):zoomy(6):sleep(0.3):bounceend(.3):zoom(0.9)
			end,
			OffCommand=function(self)
				self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0)
			end,
		},
	},
}
