local t = Def.ActorFrame{
	Def.BPMDisplay{
		Name="BPMDisplay";
		Font="Common Normal";
		InitCommand=function(self) self:halign(1):zoom(1) end,
		SetCommand=function(self) self:SetFromGameState() end;
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end,
		CurrentCourseChangedMessageCommand=function(self) self:playcommand("Set") end,
	};
};

return t;