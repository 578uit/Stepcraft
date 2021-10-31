local index = 0

local InputHandler = function(event)
	if not event.PlayerNumber or not event.button then return false end

	if event.type == "InputEventType_FirstPress" then
		if event.GameButton == "MenuDown" or event.GameButton == "MenuRight" and index < 3 then
			index = index + 1
		elseif event.GameButton == "MenuUp" or event.GameButton == "MenuLeft" and index > 0 then
			index = index - 1
		end
	end
end

local t = Def.ActorFrame{	
	OnCommand=function(self)
		SCREENMAN:GetTopScreen():AddInputCallback(InputHandler) 
	end,
	OffCommand=function(self)
		-- set the GameMode now; we'll use it throughout the theme
		-- to set certain Gameplay settings and determine which screen comes next
		if index == 2 then
			SL.Global.GameMode = "Creative"
		else
			SL.Global.GameMode = "Survival"
		end
		-- now that a GameMode has been selected, set related preferences
		SetGameModePreferences()
		-- and reload the theme's Metrics
		THEME:ReloadMetrics()
	end,
	Def.ActorFrame{
		Def.BitmapText{
			Font="_minecraft 14px",
			Text="Select A Game Mode",
			InitCommand=function(self) self:xy(SCREEN_LEFT+40,SCREEN_TOP+38) self:skewx(-0.16) self:horizalign(0) end,
			OnCommand=function(self)
				self:zoomx(0):zoomy(6):sleep(0.3):bounceend(.3):zoom(1.4)
			end;
		},
	},
}
		
return t