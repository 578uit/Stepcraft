local t = Def.ActorFrame{}

if ThemePrefs.Get("Challenge") ~= "Off" then
	t[#t+1] = LoadActor(ThemePrefs.Get("Challenge"));
end

t[#t+1] = LoadActor("BPMDisplay");

t[#t+1] = LoadActor("songtitle");

t[#t+1] = LoadActor("songmeter");

t[#t+1] = LoadActor(THEME:GetPathG("", "pause_menu"))

t[#t+1] = Def.ActorFrame{
	OnCommand=function(self)
		if SCREENMAN:GetTopScreen():GetChild("LifebarCustomP1") then
			if SL.Global.GameMode == "Creative" then
				SCREENMAN:GetTopScreen():GetChild("LifebarCustomP1"):visible(false)
			else
				SCREENMAN:GetTopScreen():GetChild("LifebarCustomP1"):visible(true)
			end
		end
	end;
};
t[#t+1] = Def.ActorFrame{
	OnCommand=function(self)
		if SCREENMAN:GetTopScreen():GetChild("LifebarCustomP2") then
			if SL.Global.GameMode == "Creative" then
				SCREENMAN:GetTopScreen():GetChild("LifebarCustomP2"):visible(false)
			else
				SCREENMAN:GetTopScreen():GetChild("LifebarCustomP2"):visible(true)
			end
		end
	end;
};

for player in ivalues( GAMESTATE:GetHumanPlayers() ) do

	local pn = ToEnumShortString(player)

	-- Use this opportunity to create an empty table for this player's gameplay stats for this stage.
	-- We'll store all kinds of data in this table that would normally only exist in ScreenGameplay so that
	-- it can persist into ScreenEvaluation to eventually be processed, visualized, and complained about.
	-- For example, per-column judgments, judgment offset data, highscore data, and so on.
	--
	-- Sadly, this Stages.Stats[stage_index] data structure is not documented anywhere. :(
	SL[pn].Stages.Stats[SL.Global.Stages.PlayedThisGame+1] = {}

	t[#t+1] = LoadActor("./TrackTimeSpentInGameplay.lua", player)
	t[#t+1] = LoadActor("./JudgmentOffsetTracking.lua", player)

	-- FIXME: refactor PerColumnJudgmentTracking to not be inside this loop
	--        the Lua input callback logic shouldn't be duplicated for each player
	t[#t+1] = LoadActor("./PerColumnJudgmentTracking.lua", player)
end;

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	t[#t+1] = LoadActor("fullcombo", pn) .. {
	};
end;

local function UpdateTime(self)
	local c = self:GetChildren();
	for pn in ivalues(PlayerNumber) do
		local vStats = STATSMAN:GetCurStageStats():GetPlayerStageStats( pn );
		local vTime;
		local obj = self:GetChild( string.format("RemainingTime" .. PlayerNumberToString(pn) ) );
		if vStats and obj then
			vTime = vStats:GetLifeRemainingSeconds()
			obj:settext( SecondsToMMSSMsMs( vTime ) );
		end;
	end;
end
if GAMESTATE:GetCurrentCourse() then
	if GAMESTATE:GetCurrentCourse():GetCourseType() == "CourseType_Survival" then
		-- RemainingTime
		for pn in ivalues(PlayerNumber) do
			local MetricsName = "RemainingTime" .. PlayerNumberToString(pn);
			t[#t+1] = LoadActor( THEME:GetPathG( Var "LoadingScreen", "RemainingTime"), pn ) .. {
				InitCommand=function(self) 
					self:player(pn); 
					self:name(MetricsName); 
					ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen"); 
				end;
			};
		end
		for pn in ivalues(PlayerNumber) do
			local MetricsName = "DeltaSeconds" .. PlayerNumberToString(pn);
			t[#t+1] = LoadActor( THEME:GetPathG( Var "LoadingScreen", "DeltaSeconds"), pn ) .. {
				InitCommand=function(self) 
					self:player(pn); 
					self:name(MetricsName); 
					ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen"); 
				end;
			};
		end
	end;
end;
t.InitCommand=cmd(SetUpdateFunction,UpdateTime);

return t