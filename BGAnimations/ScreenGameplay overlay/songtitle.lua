return Def.ActorFrame{
	LoadFont("Common Normal")..{
		Name="SongTitle",
		InitCommand=cmd(zoom,0.8; shadowlength,0.6; maxwidth, _screen.w/1.25 - 10; xy, _screen.cx, 49 ),
		OffCommand=cmd(decelerate,0.8;diffusealpha,0);
		CurrentSongChangedMessageCommand=cmd(playcommand, "Update"),
		UpdateCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			songtext = song:GetDisplayArtist() .. " - " .. song:GetDisplayFullTitle()
			self:settext(songtext)
		end
	}
}