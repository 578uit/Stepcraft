--Unused Elements

--[[return Def.ActorFrame{
		Def.Sprite {
			OnCommand=function(self)
				self:Load(THEME:GetPathG("", "_fallback bg/" .. ThemePrefs.Get("FallbackBG") .. ".png")
				if GAMESTATE:GetCurrentSong() then
					local song = GAMESTATE:GetCurrentSong();
					if song:HasBackground() or song:HasPreviewVid() then
						self:visible(false)
					else
						self:visible(true)
					end	
				self:scale_or_crop_background()
			end;
		};
}]]
