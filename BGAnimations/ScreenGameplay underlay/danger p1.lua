return Def.ActorFrame{
	Def.ActorFrame{
		Name="Danger_Player1";
		Def.ActorFrame{
			Name="Single";
			BeginCommand=function(self)
				local style = GAMESTATE:GetCurrentStyle()
				local styleType = style:GetStyleType()
				local bDoubles = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')
				self:visible(not bDoubles or bDoubles)
			end;
			HealthStateChangedMessageCommand=function(self, param)
				if param.PlayerNumber == PLAYER_1 then
					if param.HealthState == "HealthState_Danger" then
						self:RunCommandsOnChildren(function(self) self:playcommand("ShowP1") end)
					else
						self:RunCommandsOnChildren(function(self) self:playcommand("HideP1") end)
					end
				end
			end;
			Def.Sprite{
				Texture="side flash.png",
				OnCommand=function(self)
					self:Center()
					self:zoom(0.7)
					self:diffusealpha(0)
				end;
				ShowP1Command=function(self)
					if not Center1Player() then
						self:diffusealpha(1):diffuseramp():effectcolor1(color("1,0,0,0.3")):effectcolor2(color("1,0,0,0.8")):effectclock('bgm')
					end
				end;
				HideP1Command=function(self)
					if not Center1Player() then
						self:stopeffect():stoptweening():linear(.5):diffusealpha(0)
					end
				end;
			};
			Def.Sprite{
				Texture="full flash.png",
				OnCommand=function(self)
					self:Center()
					self:zoom(0.7)
					self:diffusealpha(0)
				end;
				ShowP1Command=function(self)
					if Center1Player() then
						self:diffusealpha(1):diffuseramp():effectcolor1(color("1,0,0,0.3")):effectcolor2(color("1,0,0,0.8")):effectclock('bgm')
					end
				end;
				HideP1Command=function(self)
					if Center1Player() then
						self:stopeffect():stoptweening():linear(.5):diffusealpha(0)
					end
				end;
			};
			--LoadFont("_minecraft 14px")..{
				--Text="LOW HEALTH!";
				--InitCommand=function(self)
					--if Center1Player() then
						--self:diffuse(color("#FF0707")):zoom(2):x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y+10):diffusealpha(0)
					--else
						--self:diffuse(color("#FF0707")):zoom(2):x(SCREEN_CENTER_X-SCREEN_WIDTH/4):y(SCREEN_CENTER_Y+10):diffusealpha(0)
					--end;
				--end;
				--ShowP1Command=function(self)
					--self:diffusealpha(1):wag():effectmagnitude(0,0,2.5)
				--end;
				--HideP1Command=function(self)
					--self:stopeffect():stoptweening():linear(.5):diffusealpha(0)
				--end;
			--};
		};
	};

	Def.ActorFrame{
		Name="Danger_Player2";
		Def.ActorFrame{
			Name="Single";
			BeginCommand=function(self)
				local style = GAMESTATE:GetCurrentStyle()
				local styleType = style:GetStyleType()
				local bDoubles = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')
				self:visible(not bDoubles)
			end;
			HealthStateChangedMessageCommand=function(self, param)
				if param.PlayerNumber == PLAYER_2 then
					if param.HealthState == "HealthState_Danger" then
						self:RunCommandsOnChildren(function(self) self:playcommand("ShowP2") end)
					else
						self:RunCommandsOnChildren(function(self) self:playcommand("HideP2") end)
					end
				end
			end;
			Def.Sprite{
				Texture="side flash.png",
				OnCommand=function(self)
					self:Center()
					self:rotationy(180)
					self:zoom(0.7)
					self:diffusealpha(0)
				end;
				ShowP2Command=function(self)
					if not Center1Player() then
						self:diffusealpha(1):diffuseramp():effectcolor1(color("0,0,1,0.3")):effectcolor2(color("0,0,1,0.8")):effectclock('bgm')
					end
				end;
				HideP2Command=function(self)
					if not Center1Player() then
						self:stopeffect():stoptweening():linear(.5):diffusealpha(0)
					end
				end;
			};
			Def.Sprite{
				Texture="full flash.png",
				OnCommand=function(self)
					self:Center()
					self:rotationy(180)
					self:zoom(0.7)
					self:diffusealpha(0)
				end;
				ShowP2Command=function(self)
					if Center1Player() then
						self:diffusealpha(1):diffuseramp():effectcolor1(color("0,0,1,0.3")):effectcolor2(color("0,0,1,0.8")):effectclock('bgm')
					end
				end;
				HideP2Command=function(self)
					if Center1Player() then
						self:stopeffect():stoptweening():linear(.5):diffusealpha(0)
					end
				end;
			};
			--LoadFont("_minecraft 14px")..{
				--Text="LOW HEALTH!";
				--InitCommand=function(self)
					--if Center1Player() then
						--self:diffuse(color("#60AEF6")):zoom(2):x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y+10):diffusealpha(0)
					--else
						--self:diffuse(color("#60AEF6")):zoom(2):x(SCREEN_CENTER_X+SCREEN_WIDTH/4):y(SCREEN_CENTER_Y+10):diffusealpha(0)
					--end;
				--end;
				--ShowP2Command=function(self)
					--self:diffusealpha(1):wag():effectmagnitude(0,0,2.5)
				--end;
				--HideP2Command=function(self)
					--self:stopeffect():stoptweening():linear(.5):diffusealpha(0)
				--end;
			--};
		};
	};
	
}

-- [Layer2]
-- File=../_ScreenGameplay danger text
-- Cond=not GAMESTATE:PlayerUsingBothSides()
-- Command=x,SCREEN_CENTER_X-160;y,SCREEN_CENTER_Y

-- # Doubles only:
-- [Layer3]
-- Type=Quad
-- Cond=GAMESTATE:PlayerUsingBothSides()
-- OnCommand=faderight,.1;fadeleft,.1;stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;diffuseshift;EffectColor1,1,0,0,0.3;EffectColor2,1,0,0,0.8

-- [Layer4]
-- File=../_ScreenGameplay danger text
-- Cond=GAMESTATE:PlayerUsingBothSides()
-- Command=x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y
