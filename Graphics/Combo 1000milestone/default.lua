return Def.ActorFrame{
	InitCommand=function(self) self:visible(false) end,
	ThousandMilestoneCommand=function(self) self:finishtweening():visible(true):sleep(0.7):queuecommand("Hide") end,
	HideCommand=function(self) self:visible(false) end,

	LoadActor("../Combo 100milestone"),

	LoadActor(THEME:GetPathG("firework.png"))..{
		InitCommand=cmd(diffusealpha,0; blend,"BlendMode_Add"),
		ThousandMilestoneCommand=cmd(finishtweening; zoom,0.25; diffusealpha,0.7; x,0; linear,0.7; zoom,3; diffusealpha,0)
	},
}