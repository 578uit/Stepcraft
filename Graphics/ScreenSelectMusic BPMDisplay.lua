local t = Def.ActorFrame{
	Def.BPMDisplay{
		Name="BPMDisplay";
		Font="Common Normal";
		InitCommand=cmd(halign,1;zoom,1);
		SetCommand=function(self) self:SetFromGameState(); end;
		CurrentSongChangedMessageCommand=cmd(playcommand,'Set');
		CurrentCourseChangedMessageCommand=cmd(playcommand,'Set');
	};
};

return t;