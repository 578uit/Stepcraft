local t = Def.ActorFrame{
	InitCommand=function(self) Frozen_Alpha = 0 end,
	OnCommand=cmd(sleep,1;queuecommand,"Colder");
	ColderCommand=function(self)
		Frozen_Alpha = Frozen_Alpha + 0.01
		if Frozen_Alpha >= 0.9 then
			Frozen_Alpha = 0.9
		end
		self:sleep(0.1)
		self:queuecommand("Colder")
	end,
	StepMessageCommand=function(self, params)
		if params.PlayerNumber == PLAYER_1 then
			if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
				Frozen_Alpha = Frozen_Alpha - 0.01
			else
				Frozen_Alpha = Frozen_Alpha - 0.02
			end
			if Frozen_Alpha <= 0 then
				Frozen_Alpha = 0
			end
		elseif params.PlayerNumber == PLAYER_2 then
			if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
				Frozen_Alpha = Frozen_Alpha - 0.01
			else
				Frozen_Alpha = Frozen_Alpha - 0.02
			end
			if Frozen_Alpha <= 0 then
				Frozen_Alpha = 0
			end
		end;
	end,
	Def.Sprite{
		Texture="_freezing overlay",
		InitCommand=cmd(FullScreen,Center);	
		OnCommand=cmd(playcommand,"Alpha");
		AlphaCommand=function(self)
			self:diffusealpha(Frozen_Alpha)
			self:sleep(0.02)
			self:queuecommand("Alpha")
		end,		
	},
	Def.BitmapText{
		Font="_minecraft 14px",
		Text="Step to keep yourself warm.",
		InitCommand=cmd(Center);	
		OnCommand=function(self)
			self:diffusealpha(0)
			self:zoom(0.9)
			self:linear(0.3)
			self:diffusealpha(1)
			self:sleep(4)
			self:linear(0.3)
			self:diffusealpha(0)
		end,		
	},
	Def.BitmapText{
		Font="_minecraft 14px",
		Text="You are freezing! Step more!",
		InitCommand=cmd(Center;diffusealpha,0;zoom,0.9);
		OnCommand=cmd(playcommand,"Alert");		
		AlertCommand=function(self)
			if Frozen_Alpha >= 0.8 then			
				self:linear(0.3)
				self:diffusealpha(1)
			else
				self:linear(0.3)
				self:diffusealpha(0)
			end
			self:sleep(0.02)
			self:queuecommand("Alert")
		end,		
	},
}

return t