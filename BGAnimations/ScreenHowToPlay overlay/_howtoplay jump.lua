return Def.ActorFrame{
	LoadActor(THEME:GetPathB("_frame","3x3"),"rounded black",380,80);
	Def.Quad{
		Name="Underline";
		InitCommand=function(self) self:y(-12) end,
		OnCommand=function(self)
			self:diffuse(color("#ffd400")):shadowlength(1):zoomtowidth(192):fadeleft(0.25):faderight(0.25)
		end,
	},
	LoadFont("_minecraft 14px") .. {
		Text="JUMP";
		InitCommand=function(self) self:y(-26) end,
		OnCommand=function(self)
			self:skewx(-0.125):diffuse(color("#ffd400")):shadowlength(2):shadowcolor(BoostColor(color("#ffd40077"),0.25))
		end,
	},
	LoadFont("_minecraft 14px") .. {
		Text="Hit 2 arrows at the same time when they reached the receptor!";
		InitCommand=function(self)
			self:y(18):wrapwidthpixels(480):vertspacing(0):shadowlength(1)
		end,
		OnCommand=function(self) self:zoom(0.875) end,
	},
}
