local SongNumberInCourse = 0

return Def.ActorFrame{
	Def.Sprite{
		CurrentSongChangedMessageCommand=function(self)
			if GAMESTATE:IsCourseMode() then
				SongNumberInCourse = SongNumberInCourse + 1
				if SongNumberInCourse <= 5 then
					self:Load(THEME:GetPathG("_gameplay","course song "..SongNumberInCourse))
				else
					self:Load(THEME:GetPathG("_blank"))
				end
			end
		end;
	};
};