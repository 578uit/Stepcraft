local swoosh, velocity

local life = 0.5

local Update = function(self)
	velocity = -GAMESTATE:GetSongBPS()/2
	if GAMESTATE:GetSongFreeze() then velocity = 0 end
	if swoosh then swoosh:texcoordvelocity(velocity,0) end
end

local meter = Def.ActorFrame{
	Condition=GAMESTATE:IsHumanPlayer(PLAYER_1);
	
	InitCommand=function(self) 
		self:SetUpdateFunction(Update)
	end,

	Def.Sprite{
		Texture=THEME:GetPathG("","_health graphics/frame"),
	},
	Def.Sprite{
		Texture=THEME:GetPathG("","_health graphics/mask"),
		OnCommand=function(self) 
			self:MaskSource() 
		end,
	},
	Def.Sprite{
		Texture=THEME:GetPathG("","_health graphics/filling"),
		OnCommand=function(self) 
			if GAMESTATE:IsHumanPlayer(PLAYER_1) then
				life = SCREENMAN:GetTopScreen():GetChild("LifeP1"):GetLife()
			end
			self:diffuse(1,1,1,1):MaskDest():zoomy(1.2):zoomx(1.02):x(0.5)
			self:cropright(1 - life)
		end,
		LifeChangedMessageCommand=function(self,params)
			if GAMESTATE:IsHumanPlayer(PLAYER_1) then
				life = SCREENMAN:GetTopScreen():GetChild("LifeP1"):GetLife()
			end
			self:finishtweening()
			self:linear(0.3)
			self:cropright( 1 - life )
		end,
	},
	Def.Sprite{
		Texture=THEME:GetPathG("","_health graphics/filling"),
		OnCommand=function(self) 
			if GAMESTATE:IsHumanPlayer(PLAYER_1) then
				life = SCREENMAN:GetTopScreen():GetChild("LifeP1"):GetLife()
			end
			self:diffuse(PlayerColor(PLAYER_1)):MaskDest():zoomy(1.2):zoomx(1.02):x(0.5)
			self:cropright(1 - life)
		end,

		-- when the engine broadcasts that the player's LifeMeter value has changed
		-- change the width of this MeterFill Quad to accommodate
		LifeChangedMessageCommand=function(self,params)
			if GAMESTATE:IsHumanPlayer(PLAYER_1) then
				life = SCREENMAN:GetTopScreen():GetChild("LifeP1"):GetLife()
			end
			self:finishtweening()
			self:cropright( 1 - life )
		end,
	},
	Def.Sprite{
		Texture=THEME:GetPathG("","_health graphics/rainbow 1x10"),
		OnCommand=function(self) 
			self:diffusealpha(0)
			self:SetAllStateDelays(0.25)
			self:effectclock('bgm')
		end,

		-- check whether the player's LifeMeter is "Hot"
		-- in LifeMeterBar.cpp, the engine says a LifeMeter is Hot if the current
		-- LifePercentage is greater than or equal to the HOT_VALUE, which is
		-- defined in Metrics.ini under [LifeMeterBar] like HotValue=1.0
		HealthStateChangedMessageCommand=function(self,params)
			if params.PlayerNumber == PLAYER_1 then
				if params.HealthState == 'HealthState_Hot' then
					self:diffusealpha(1)
				else
					-- ~~man's~~ lifebar's not hot
					self:diffusealpha(0)
				end
			end
		end,
	},
	Def.Sprite{
		Texture=THEME:GetPathG("","_health graphics/flash"),
		OnCommand=function(self)
			self:diffuseramp()
			self:effectcolor2(1,1,1,1)
			self:effectcolor1(1,1,1,0)
			self:effectclock('bgm')
		end,
		LifeChangedMessageCommand=function(self,params)
			if GAMESTATE:IsHumanPlayer(PLAYER_1) then
				life = SCREENMAN:GetTopScreen():GetChild("LifeP1"):GetLife()
			end
			self:finishtweening()
			self:cropright( 1 - life )
		end,
	},
}

return meter;