return Def.ActorFrame{
	OnCommand=function(self) self:zoom(0.85):wag():effectmagnitude(0,0,2) end,
	LoadActor("graphics/b-plus.png")..{
		OnCommand=function(self)
			self:diffusealpha(0):zoom(0):sleep(0.2):decelerate(0.2):zoom(1.5):diffusealpha(1):accelerate(0.2):zoom(1)
				:decelerate(0.1):zoom(0.9):diffusealpha(0.8):accelerate(0.1):zoom(1):diffusealpha(1)
		end,
	},
	LoadActor("expulosiv.lua")..{
	},
}
