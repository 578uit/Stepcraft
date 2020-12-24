local t = ...

for judgment_filename in ivalues( GetJudgmentGraphics() ) do
	if judgment_filename ~= "None" then
		t[#t+1] = LoadActor( THEME:GetPathG("", "judgments/" .. judgment_filename) )..{
			Name="JudgmentGraphic_"..StripSpriteHints(judgment_filename),
			InitCommand=function(self) self:visible(false):animate(false):setstate(0) end
		}
	else
		t[#t+1] = Def.Actor{ Name="JudgmentGraphic_None", InitCommand=function(self) self:visible(false) end }
	end
end