local gc = Var("GameCommand")
local string_expl = THEME:GetString(Var "LoadingScreen", "Explanation" .. gc:GetName());
local t = Def.ActorFrame {}
t[#t+1] = Def.ActorFrame {
	OnCommand=cmd(diffusealpha,0;linear,0.4;diffusealpha,1),
	OffCommand=cmd(decelerate,0.6;diffusealpha,0),
	
	LoadActor( gc:GetName() ) .. {
		InitCommand=cmd(zoom,0.4;addy,-60),
		GainFocusCommand=cmd(diffusealpha,1.0),
		LoseFocusCommand=cmd(diffusealpha,0)
	},
	LoadFont("_minecraft 14px")..{
		Text=string.upper(gc:GetText()),
		InitCommand=cmd(horizalign,center;addy,100;zoom,2),
		GainFocusCommand=cmd(diffusealpha,1),
		LoseFocusCommand=cmd(diffusealpha,0)
	},
	LoadActor("left.png")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-750;addy,100;zoom,2),
		OffCommand=cmd(accelerate,0.5;addx,-200),
	},
	LoadActor("right.png")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-100;addy,100;zoom,2),
		OffCommand=cmd(accelerate,0.5;addx,200),
	},
	LoadFont("_minecraft 14px")..{
		Text=string_expl,
		InitCommand=cmd(horizalign,center;addy,190;zoom,1),
		GainFocusCommand=cmd(diffusealpha,1),
		LoseFocusCommand=cmd(diffusealpha,0)
	},
}
return t
