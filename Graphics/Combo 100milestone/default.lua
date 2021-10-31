return Def.ActorFrame{
	InitCommand=function(self) self:visible(false) end,
	HundredMilestoneCommand=function(self) self:finishtweening():visible(true):sleep(0.6):queuecommand("Hide") end,
	ThousandMilestoneCommand=function(self) self:finishtweening():queuecommand("HundredMilestone") end,
	HideCommand=function(self) self:visible(false) end,

	LoadActor("explosion.png")..{
		InitCommand=function(self) self:diffusealpha(0):blend("BlendMode_Add") end,
		HundredMilestoneCommand=function(self) self:finishtweening():rotationz(0):zoom(2):diffusealpha(0.5):linear(0.5):rotationz(90):zoom(1):diffusealpha(0) end,
	},

	LoadActor("explosion.png")..{
		InitCommand=function(self) self:diffusealpha(0):blend("BlendMode_Add") end,
		HundredMilestoneCommand=function(self) self:finishtweening():rotationz(0):zoom(2):diffusealpha(0.5):linear(0.5):rotationz(-90):zoom(1):diffusealpha(0) end,
	},

	LoadActor("firework.png"))..{
		InitCommand=function(self) self:diffusealpha(0):blend("BlendMode_Add") end,
		HundredMilestoneCommand=function(self) self:finishtweening():rotationz(10):zoom(0.25):diffusealpha(0.6):decelerate(0.5):rotationz(0):zoom(2):diffusealpha(0) end,
	},
}