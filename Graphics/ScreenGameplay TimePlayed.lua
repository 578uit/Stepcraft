return Def.ActorFrame{
	LoadFont("_minecraft 14px")..{
		InitCommand=function(self) self:y(SCREEN_TOP+16):x(SCREEN_CENTER_X-30):zoom(0.8):shadowlength(0):playcommand("Update") end,
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Update") end,
		UpdateCommand=function(self)
			local timeintimer = self:GetSecsIntoEffect()
			self:effectclock('music')
			if timeintimer >= 0 then
				self:settext(SecondsToMMSS(timeintimer))
			else
				self:settext("00:00")
			end
			self:sleep(1)
			self:queuecommand('Update')
		end
	},
	LoadFont("_minecraft 14px")..{
		InitCommand=function(self) self:y(SCREEN_TOP+16):x(SCREEN_CENTER_X+30):zoom(0.8):shadowlength(0):playcommand("Update") end,
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Update") end,
		UpdateCommand=function(self)
			local totaltimer = GAMESTATE:GetCurrentSong():MusicLengthSeconds()
			self:settext(SecondsToMMSS(totaltimer))
		end
	},
}