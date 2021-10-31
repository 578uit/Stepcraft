return Def.ActorFrame{
	LoadFont("Common Normal")..{
		Name="SongTitle",
		InitCommand=function(self)	
			self:zoom(0.8):shadowlength(0.6):maxwidth(_screen.w/1.25 - 10):xy(_screen.cx, 49)
		end,
		OffCommand=function(self)
			self:decelerate(0.8):diffusealpha(0)
		end,
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Update") end,
		UpdateCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			songtext = song:GetDisplayArtist() .. " - " .. song:GetDisplayFullTitle()
			self:settext(songtext)
		end
	}
}