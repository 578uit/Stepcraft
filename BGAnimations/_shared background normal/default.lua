if MonthOfYear()==11 then file = "snow" else file = "minecraft" end

local t = Def.ActorFrame{
	LoadActor(file)..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoom,1.2),
	},
}
return t