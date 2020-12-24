local p = ...

local t = Def.ActorFrame{}

t[#t+1] = LoadActor("base frame")..{
	InitCommand=cmd(diffuse, PlayerColor(p) ),
};
t[#t+1] = Def.ActorFrame{
	InitCommand=function(self)
		self:y(40)
	end,	
	LoadActor("ScatterPlot.lua", p),
}

return t
