return Def.ActorFrame{
	LoadActor(THEME:GetPathB("", "_shared background classic/" .. ThemePrefs.Get("BGBlock") .. ".png"))..{
		OnCommand=function(self)
			self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y):zoomto(1024,1024):customtexturerect(0,0,16,16)
		end,
	},
	LoadActor("christmas")..{
		InitCommand=function(self)
			if MonthOfYear()==11 then
				self:diffusealpha(1)
			else
				self:diffusealpha(0)
			end
		end,
		OnCommand=function(self)
			self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y):zoomto(2048,2048):customtexturerect(0,0,16,16)
		end,
	},
	Def.Quad{
		InitCommand=function(self)
			self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y):zoomto(_screen.w,_screen.h):diffuse(color("#000000")):diffusealpha(0.55)
		end,
	},
}

		
