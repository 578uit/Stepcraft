return Def.ActorFrame{
	-- single
	Def.ActorFrame{
		Name="DeadSingle";
		BeginCommand=function(self)
			self:visible( GAMESTATE:GetCurrentStyle():GetStyleType() ~= "StyleType_OnePlayerTwoSides" and GAMESTATE:GetCurrentStyle():GetStyleType() ~= "StyleType_TwoPlayersSharedSides" )
		end;
		HealthStateChangedMessageCommand=function(self, param)
			if param.HealthState == "HealthState_Dead" then
				local dead = self:GetChild("Dead"..ToEnumShortString(param.PlayerNumber))
				dead:playcommand("Show")
			end;
			if param.HealthState == "HealthState_Danger" then
				local live = self:GetChild("Dead"..ToEnumShortString(param.PlayerNumber))
				live:playcommand("Hide")
			end;
		end;
		Def.Quad{
			Name="DeadP1";
			InitCommand=function(self)
				if Center1Player() then
					self:diffuse(color("0,0,0,0.5")):stretchto(SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM):diffusealpha(0):player(PLAYER_1)
				else
					self:diffuse(color("0,0,0,0.5")):faderight(.3):stretchto(SCREEN_LEFT,SCREEN_TOP,SCREEN_CENTER_X,SCREEN_BOTTOM):diffusealpha(0):player(PLAYER_1)
				end;
			end;
			ShowCommand=function(self)
				self:diffusealpha(0.7)
			end;
			HideCommand=function(self)
				self:diffusealpha(0)
			end;
		};
		Def.Quad{
			Name="DeadP2";
			InitCommand=function(self)
				if Center1Player() then
					self:diffuse(color("0,0,0,0.5")):stretchto(SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM):diffusealpha(0):player(PLAYER_2)
				else
					self:diffuse(color("0,0,0,0.5")):fadeleft(.3):stretchto(SCREEN_CENTER_X,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM):diffusealpha(0):player(PLAYER_2)
				end;
			end;
			ShowCommand=function(self)
				self:diffusealpha(0.7)
			end;
			HideCommand=function(self)
				self:diffusealpha(0)
			end;
		};
	};

	-- double
	Def.ActorFrame{
		Name="DeadDouble";
		BeginCommand=function(self)
			local style = GAMESTATE:GetCurrentStyle()
			local styleType = style:GetStyleType()
			self:visible( styleType == "StyleType_OnePlayerTwoSides" or styleType == "StyleType_TwoPlayersSharedSides" )
		end;
		HealthStateChangedMessageCommand=function(self, param)
			if param.HealthState == "HealthState_Dead" then
				self:RunCommandsOnChildren(function(self) self:playcommand("Show") end)
			end
			if param.HealthState == "HealthState_Danger" then
				self:RunCommandsOnChildren(function(self) self:playcommand("Hide") end)
			end
		end;
		Def.Quad{
			InitCommand=function(self)
				self:diffuse(color("0,0,0,0.5")):FullScreen():diffusealpha(0)
			end;
			ShowCommand=function(self)
				self:diffusealpha(0.7)
			end;
			HideCommand=function(self)
				self:diffusealpha(0)
			end;
		};
	};
};