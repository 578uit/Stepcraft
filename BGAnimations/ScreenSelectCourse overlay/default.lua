local t = Def.ActorFrame{
	LoadActor("bar.lua")..{
	};
	LoadActor("hardcore.lua")..{
	};
	LoadActor("../clock")..{
	},
	LoadActor( THEME:GetPathG('ScreenSelectMusic','CourseDisplayList') )..{
		OnCommand=function(self)
			self:x(750):y(92):zoomx(1):zoomy(0.94)
		end;
		OffCommand=function(self)
			self:accelerate(0.5):addx(300)
		end;
	};
}
for player in ivalues(PlayerNumber) do
	t[#t+1] = LoadActor( THEME:GetPathG('ScreenSelectMusic','PaneDisplay'), player )..{
		Condition=GAMESTATE:IsHumanPlayer(player);
		OnCommand=function(self)
			self:x(player == PLAYER_1 and SCREEN_CENTER_X+105 or SCREEN_CENTER_X+155)
			:y(player == PLAYER_1 and SCREEN_BOTTOM-185 or SCREEN_BOTTOM-95):zoomy(0):sleep(0.5):linear(0.3):zoomy(1)
		end;
		OffCommand=function(self)
			self:linear(0.3):zoomy(0)
		end;
	};
end
return t

		
