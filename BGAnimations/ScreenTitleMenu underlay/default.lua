local SongStats = SONGMAN:GetNumSongs() .. " songs in "
SongStats = SongStats .. SONGMAN:GetNumSongGroups() .. " groups, "
SongStats = SongStats .. #SONGMAN:GetAllCourses(PREFSMAN:GetPreference("AutogenGroupCourses")) .. " courses"

local sm_version = ProductID()

local t = Def.ActorFrame{
	InitCommand=function(self)
		PROFILEMAN:SetStatsPrefix("")
		SL.Global.GameMode = "Survival"
		SetGameModePreferences()
		InitializeSimplyLove()
		THEME:ReloadMetrics()
	end,
	LoadActor("logo.png")..{
		InitCommand=function(self) self:zoom(1.5):x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y-80) end,
	},
	
	LoadFont("_minecraft 14px")..{
		Text=sm_version .. "     Version b1.7.0",
		InitCommand=function(self) self:zoom(1):x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y-160) end,
	},
	
	LoadFont("_minecraft 14px")..{
		Text=SongStats,
		InitCommand=function(self) self:zoom(1):x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y-140) end,
	},
}


return t