local t = Def.ActorFrame{};

-- todo: add event mode indicators and such
if GAMESTATE:IsEventMode() then
	t[#t+1] = LoadFont("Common Normal")..{
		Text="Press &START;";
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM-72):zoom(1.2):diffuse(Color.White):shadowlength(1) end,
	};
else
	t[#t+1] = LoadFont("Common Normal")..{
		Text="Press &START;";
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM-72):zoom(1.2):diffuse(Color.White):shadowlength(1) end,
	};
end;

return t;