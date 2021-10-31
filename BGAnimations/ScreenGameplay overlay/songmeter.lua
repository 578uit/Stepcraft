return Def.ActorFrame{
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X):y(SCREEN_TOP):addy(-100):sleep(0.5):zoomy(0.5):queuecommand("TweenOn")
	end;
	OffCommand=function(s)
		s:sleep(1):queuecommand("TweenOff")
	end;
	ShowGameplayTopFrameMessageCommand=function(self)
		self:playcommand("TweenOn")
	end;
	HideGameplayTopFrameMessageCommand=function(self)
		self:playcommand("TweenOff")
	end;
	TweenOnCommand=function(s)
		s:decelerate(0.8):addy(130)
	end;
	TweenOffCommand=function(s)
		s:accelerate(0.8):addy(-130)
	end;
	Def.Sprite{ 
		Texture="meter frame" 
	},
	Def.SongMeterDisplay{
        InitCommand=function(self)
        	self:SetStreamWidth(SCREEN_WIDTH/2.1)
        end;  
        Stream=LoadActor("meter stream")..{
        	InitCommand=function(self)
        		self:diffusealpha(1)
        	end
        };
    },
}
