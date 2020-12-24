return Def.ActorFrame {
	-- messages
	Def.ActorFrame{
		OnCommand=function(self)
			self:xy(SCREEN_LEFT+35,SCREEN_TOP+38)
		end;

		Def.BitmapText{
		Font="_minecraft 14px",
		Text="How To Play",
		InitCommand=function(self) self:x(self:GetWidth()/1.2) self:skewx(-0.16) end,
		OnCommand=function(self)
			self:zoomx(0):zoomy(6):sleep(0.3):bounceend(.3):zoom(1.4)
		end;
		OffCommand=function(self)
			self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0)
		end;
		},

	};
	LoadActor("_howtoplay feet") .. {
			InitCommand=cmd(shadowlength,1;strokecolor,Color.Outline);
			OnCommand=cmd(z,20;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;addx,-SCREEN_WIDTH;sleep,2.4;decelerate,0.3;addx,SCREEN_WIDTH;sleep,2;linear,0.3;zoomy,0);
	};
	Def.ActorFrame {
		InitCommand=cmd(x,SCREEN_CENTER_X+120;y,SCREEN_CENTER_Y+40);
		
		LoadActor("_howtoplay tap")..{
			InitCommand=cmd(diffusealpha,0);
			ShowCommand=cmd(linear,0;diffusealpha,1;sleep,2;linear,0;diffusealpha,0);
			OnCommand=cmd(sleep,6;queuecommand,"Show");
		};
		LoadActor("_howtoplay tap")..{
			InitCommand=cmd(diffusealpha,0);
			ShowCommand=cmd(linear,0;diffusealpha,1;sleep,2;linear,0;diffusealpha,0);
			OnCommand=cmd(sleep,9.7;queuecommand,"Show");
		};
		LoadActor("_howtoplay tap")..{
			InitCommand=cmd(diffusealpha,0);
			ShowCommand=cmd(linear,0;diffusealpha,1;sleep,2;linear,0;diffusealpha,0);
			OnCommand=cmd(sleep,12.7;queuecommand,"Show");
		};
		LoadActor("_howtoplay tap")..{
			InitCommand=cmd(diffusealpha,0);
			ShowCommand=cmd(linear,0;diffusealpha,1;sleep,2;linear,0;diffusealpha,0);
			OnCommand=cmd(sleep,15.7;queuecommand,"Show");
		};
		LoadActor("_howtoplay jump")..{
			InitCommand=cmd(diffusealpha,0);
			ShowCommand=cmd(linear,0;diffusealpha,1;sleep,2;linear,0;diffusealpha,0);
			OnCommand=cmd(sleep,18.7;queuecommand,"Show");
		};
		LoadActor("_howtoplay miss")..{
			InitCommand=cmd(diffusealpha,0);
			ShowCommand=cmd(linear,0;diffusealpha,1;sleep,2;linear,0;diffusealpha,0);
			OnCommand=cmd(sleep,22.7;queuecommand,"Show");
		};
	};
};
