local stageRemap = {
	Stage_1st	= 1, Stage_2nd	= 2, Stage_3rd	= 3,
	Stage_4th	= 4, Stage_5th	= 5, Stage_6th	= 6
}
local curStage = GAMESTATE:GetCurrentStage()
local songsPerPlay = PREFSMAN:GetPreference("SongsPerPlay")
if stageRemap[curStage] == songsPerPlay then
	curStage = 'Stage_Final'
end
if GAMESTATE:IsEventMode() then curStage = 'Stage_Event' end

curStage = ToEnumShortString(curStage)
local SongNumberInCourse = 0

local t = Def.ActorFrame{
	InitCommand=function(self)
		-- reset beginner stage
	end;
	Def.Sound{
		File="whoosh",
		OnCommand=function(self)
			self:play()
		end;
	},
	Def.Quad {
		InitCommand=function(self) self:Center():scaletoclipped(SCREEN_WIDTH+1,SCREEN_HEIGHT) end,
		OnCommand=function(self) self:diffuse(color("#000000")):diffusebottomedge(color("#000000")):diffusealpha(1) end,
	},
	Def.ActorFrame{
		Name="StageText";
		Def.ActorFrame{
			Name="Main";
			Condition=not GAMESTATE:IsCourseMode();
			LoadActor(THEME:GetPathG("_gameplay","stage "..curStage))..{
				OnCommand=function(self) self:x(SCREEN_CENTER_X):y(SCREEN_BOTTOM+120):bounceend(0.5):Center():sleep(2) end,
			};
		};
		Def.ActorFrame{
			Name="Main";
			Condition=GAMESTATE:IsCourseMode();
			LoadActor(THEME:GetPathG("_gameplay","course song 1"))..{
				OnCommand=function(self) self:x(SCREEN_CENTER_X):y(SCREEN_BOTTOM+120):bounceend(0.5):Center():sleep(2) end,
			};
		};
		
	};
};

return t;