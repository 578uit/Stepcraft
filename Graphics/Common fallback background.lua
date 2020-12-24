return Def.ActorFrame{
		LoadActor(THEME:GetPathG("", "_fallback bg/" .. ThemePrefs.Get("FallbackBG")))..{
			OnCommand=function(self)
				self:scale_or_crop_background()
			end;
		};
}
