return Def.ActorFrame{
	LoadActor("../Combo 100milestone/firework.png")..{
		OnCommand=function(self) self:blend("BlendMode_Add"):rotationz(10):zoom(0):diffusealpha(1):sleep(0.2):linear(0.7):rotationz(-10):zoom(2):diffusealpha(0) end,
	}
}
