local index = Var("GameCommand"):GetIndex()

local t = Def.ActorFrame{}

-- this code will draw a block behind the text like Minecraft!
t[#t+1] = LoadActor("../Graphics/block.png")..{
	Name="Gud"..index,
	Text=THEME:GetString( 'ScreenTitleMenu', Var("GameCommand"):GetText() ),

	InitCommand=function(self) self:zoom(1.4) end,
	OnCommand=function(self) self:diffusealpha(0):sleep(tonumber(index) * 0.075):linear(0.2):diffusealpha(1) end,
	OffCommand=function(self) self:sleep(tonumber(index) * 0.075):linear(0.18):diffusealpha(0) end,

	GainFocusCommand=function(self) self:stoptweening():zoom(1.6):accelerate(0.15):diffuse(color("#26A6F4")) end,
	LoseFocusCommand=function(self) self:stoptweening():zoom(1.6):accelerate(0.2):diffuse(color("#888888")) end,

}
-- this code will show the text
t[#t+1] = LoadFont("_minecraft 14px")..{
	Name="Choice"..index,
	Text=THEME:GetString( 'ScreenTitleMenu', Var("GameCommand"):GetText() ),

	InitCommand=function(self) self:zoom(1.4) end,
	OnCommand=function(self) self:diffusealpha(0):sleep(tonumber(index) * 0.075):linear(0.2):diffusealpha(1) end,
	OffCommand=function(self) self:sleep(tonumber(index) * 0.075):linear(0.18):diffusealpha(0) end,

	GainFocusCommand=function(self) self:stoptweening():zoom(1.5):accelerate(0.15):diffuse(PlayerColor(PLAYER_1)):glow(color("1,1,1,0.5")):decelerate(0.05):glow(color("1,1,1,0.0")) end,
	LoseFocusCommand=function(self) self:stoptweening():zoom(1.5):accelerate(0.2):diffuse(color("#888888")):glow(color("1,1,1,0.0")) end,

}



return t