local pss = ...

return Def.ActorFrame{
	Def.ActorFrame{
		OnCommand=function(self) self:x(-39):y(40):zoom(0.6):pulse():effectmagnitude(1,0.9,0):wag():effectmagnitude(0,0,2) end,
		LoadActor("star.lua", pss)..{
			OnCommand=function(self)
				self:diffusealpha(0):zoom(0):sleep(0.2):decelerate(0.2):zoom(1.5):diffusealpha(1):accelerate(0.2):zoom(1)
					:decelerate(0.1):zoom(0.9):diffusealpha(0.8):accelerate(0.1):zoom(1):diffusealpha(1)
			end,
		},
	},
	Def.ActorFrame{
		OnCommand=function(self) self:x(39):y(-40):effectoffset(0.2):zoom(0.6):pulse():effectmagnitude(0.9,1,0):wag():effectmagnitude(0,0,2) end,
		LoadActor("star.lua", pss)..{
			OnCommand=function(self)
				self:diffusealpha(0):zoom(0):sleep(0.4):decelerate(0.2):zoom(1.5):diffusealpha(1):accelerate(0.2):zoom(1)
					:decelerate(0.1):zoom(0.9):diffusealpha(0.8):accelerate(0.1):zoom(1):diffusealpha(1)
			end,
		},
	},
	LoadActor("../Combo 100milestone/firework.png")..{
		OnCommand=function(self) self:x(-39):y(40):blend("BlendMode_Add"):rotationz(10):zoom(0):diffusealpha(1):sleep(0.2):linear(0.7):rotationz(-10):zoom(2):diffusealpha(0) end,
	},
	LoadActor("../Combo 100milestone/firework.png")..{
		OnCommand=function(self) self:x(39):y(-40):blend("BlendMode_Add"):rotationz(10):zoom(0):diffusealpha(1):sleep(0.4):linear(0.7):rotationz(-10):zoom(2):diffusealpha(0) end,
	}
}
