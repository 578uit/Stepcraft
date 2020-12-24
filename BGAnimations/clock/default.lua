local t = Def.ActorFrame {
	Def.ActorFrame{
		OnCommand=function(self)
			screen = SCREENMAN:GetTopScreen()
			if screen ~= "ScreenOptionsServiceChild" then
				menutimer = screen:GetChild("Timer"):GetSeconds()
				duration = menutimer/32
			end
		end;
	};
	Def.Sprite{
		Name= "xtl_actor_go",
		OnCommand=function(self)
			self:playcommand("SetMe")
			self:x(SCREEN_RIGHT-20)
			self:y(SCREEN_TOP+20)
		end;
		SetMeCommand= function(self)
			self:SetAllStateDelays(duration)
			self:stoptweening()
			if not PREFSMAN:GetPreference("MenuTimer") then
				self:diffusealpha(0)
			end
			self:sleep(0.01)
			self:queuecommand("SetMe")
		end,
		Texture= "clock 1x33.png",
	},
	Def.Sprite{
		Name= "xtl_actor_fo",
		OnCommand= function(self)
			if PREFSMAN:GetPreference("MenuTimer") then
				self:diffusealpha(0)
			end
			self:x(SCREEN_RIGHT-20)
			self:y(SCREEN_TOP+20)
		end,
		Texture= "clock still.png",
	},

}

return t