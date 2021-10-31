local t = Def.ActorFrame {
	Def.Quad {
		InitCommand=function(self) self:setsize(300,96):diffuse(color("#00000090")) end,
	},
	LoadFont("_minecraft 14px") .. {
		InitCommand=function(self) self:x(-70):y(30):finishtweening():draworder(100):zoom(0.8) end,
		OnCommand=function(self)
			self:settext("Number of Songs:")
		end;
	},
	LoadFont("_minecraft 14px") .. {
		InitCommand=function(self) self:x(80):y(-30):finishtweening():draworder(100):zoom(0.8) end,
		OnCommand=function(self)
			self:settext("Pack selected")
		end;
	},
};

return t;
