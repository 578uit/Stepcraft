local GradePercentages = {
	-- quad star
	1.00,
	-- triple star
	0.99,
	-- double star
	0.98,
	-- single star
	0.96,
	-- S+
	0.94,
	-- S
	0.92,
	-- S-
	0.89,
	-- A+
	0.86,
	-- A
	0.83,
	-- A-
	0.80,
	-- B+
	0.76,
	-- B
	0.72,
	-- B-
	0.68,
	-- C+
	0.64,
	-- C
	0.60,
	-- C-
	0.55,
};

PlayerTier = {
	["PlayerNumber_P1"] = "Grade_Tier17",
	["PlayerNumber_P2"] = "Grade_Tier17",
};

for player in ivalues(PlayerNumber) do
	local PSS = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
	for index, Perc in ipairs(GradePercentages) do
		-- If the player fails, give them a big F.
		if PSS:GetFailed( player ) then
			PlayerTier[player] = "Grade_Failed"
			break
		end
		if (CalPerNum( player ) >= Perc) then
			PlayerTier[player] = "Grade_Tier"..index
			break
		end
	end
end

local t = Def.ActorFrame{
	-- store some attributes of this playthrough of this song in the global SL table
	-- for later retrieval on ScreenEvaluationSummary
	LoadActor("./GlobalStorage.lua"),
}

local function side(pn)
	local s = 1
	if pn == PLAYER_1 then return s end
	return s*(-1)
end

local function Gradeside(pn)
	local s = -230
	if pn == PLAYER_2 then s = 56 end
	return s
end

local function pnum(pn)
	if pn == PLAYER_2 then return 2 end
	return 1
end

for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
	local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
	if pss:GetMachineHighScoreIndex() == 0 or pss:GetPersonalHighScoreIndex() == 0 then
		t[#t+1] = LoadFont("_minecraft 14px")..{
			OnCommand=function(self)
				self:settext("NEW HIGHSCORE!")
				self:xy(SCREEN_CENTER_X+(-185*side(pn)),SCREEN_CENTER_Y-124):zoom(1):diffusealpha(0)
				self:sleep(3):decelerate(0.3):diffusealpha(1)
			end,
			OffCommand=function(self) self:decelerate(0.3):diffusealpha(0) end,
		}
	end
end
-- Grade and Frame Info
for player in ivalues(PlayerNumber) do
	t[#t+1] = Def.ActorFrame{
		Condition=GAMESTATE:IsPlayerEnabled(player);
		LoadActor( THEME:GetPathG("","ScreenEvaluation grade frame"), player )..{
			InitCommand=function(self)
				self:xy(SCREEN_CENTER_X+(-145*side(player)),SCREEN_CENTER_Y+54)
			end,
			OnCommand=function(self)
				self:addx( (-SCREEN_WIDTH/2)*side(player) )
				:sleep(3):decelerate(0.3)
				:addx( (SCREEN_WIDTH/2)*side(player) )
			end;
			OffCommand=function(self)
				self:accelerate(0.3):addx( (-SCREEN_WIDTH/2)*side(player) )
			end;
		},
	}
	t[#t+1] = Def.ActorFrame{
		Condition=GAMESTATE:IsPlayerEnabled(player);
		BeginCommand=function(self)
			self:xy(SCREEN_CENTER_X+(-145*side(player)),SCREEN_CENTER_Y-60)
			:zoom(1):addx( (-SCREEN_WIDTH)*side(player) ):decelerate(0.5)
			:addx( SCREEN_WIDTH*side(player) ):sleep(2.2):decelerate(0.5):zoom(0.4)
			self:xy(SCREEN_CENTER_X+Gradeside(player),SCREEN_CENTER_Y-38);
		end;
		OffCommand=function(self)
			self:accelerate(0.3):addx(-SCREEN_WIDTH/2*side(player))
		end;
		LoadActor( THEME:GetPathG("", "_grades/"..PlayerTier[player]..".lua" ));
	}	
end

for player in ivalues(GAMESTATE:GetHumanPlayers()) do
	t[#t+1] = Def.ActorFrame{
		Name=ToEnumShortString(player).."_AF_Upper",
		LoadActor("Storage.lua", player),
	}	
	t[#t+1] = Def.ActorFrame{
		Name=ToEnumShortString(player).."_AF_Lower",
		InitCommand=function(self)
			self:xy(player == PLAYER_1 and SCREEN_CENTER_X-145 or SCREEN_CENTER_X+145,SCREEN_CENTER_Y-4)
		end,
		OnCommand=function(self)
			self:addx(player == PLAYER_1 and (-SCREEN_WIDTH/2)*1 or (-SCREEN_WIDTH/2)*-1)
			:sleep(3):decelerate(0.3)
			:addx(player == PLAYER_1 and (SCREEN_WIDTH/2)*1 or (SCREEN_WIDTH/2)*-1)
		end,
		OffCommand=function(self)
			self:accelerate(0.3):addx(player == PLAYER_1 and (-SCREEN_WIDTH/2)*1 or (-SCREEN_WIDTH/2)*-1)
		end,	
	}
end

t[#t+1] = LoadActor( THEME:GetPathB("ScreenEvaluation","common") )

t[#t+1] = Def.ActorFrame{
	-- The biggest challenge here was to compesate the positions because of SM5's TextureFiltering.
	-- It is different from 3.95/OpenITG's filters, which differ a lot with the original positions.
	-- IN ADDITION of the different x and y handling anyways.
	-- 																			Jose_Varela
	OffCommand=function(self)
		SL.Global.Stages.PlayedThisGame = SL.Global.Stages.PlayedThisGame + 1
	end,
	Def.BitmapText{
		Font="Common Normal",
		Text="Evaluation",
		InitCommand=function(self) self:xy(SCREEN_LEFT+40,SCREEN_TOP+38) self:skewx(-0.16) self:horizalign(0) end,
		OnCommand=function(self)
			self:zoomx(0):zoomy(6):sleep(0.3):bounceend(.3):zoom(1.4)
		end,
		OffCommand=function(self)
			self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0)
		end,
	},
	Def.BitmapText{
		Font="_minecraft 14px",
		Text="Select Music",
		InitCommand=function(self)
			self:zoom(0.8):shadowlength(0.6):maxwidth(_screen.w/1.1 - 10):xy(_screen.cx, 49)
		end,
		OnCommand=function(self)
			self:setsize(418/2,164/2):ztest(1):y(SCREEN_TOP-150):sleep(3):decelerate(0.3):y(SCREEN_CENTER_Y-174)
			local song = GAMESTATE:GetCurrentSong()
			songtext = song:GetDisplayArtist() .. " - " .. song:GetDisplayFullTitle()
			self:settext(songtext)
		end,
		OffCommand=function(self)
			self:accelerate(0.3):addy(-SCREEN_CENTER_X)
		end,
	},
	-- Banner frame
	Def.Banner{
		InitCommand=function(self) self:xy(SCREEN_CENTER_X-1,SCREEN_CENTER_Y-126)
			if GAMESTATE:IsCourseMode() then
				self:LoadFromCourse( GAMESTATE:GetCurrentCourse() )
			else
				self:LoadFromSong( GAMESTATE:GetCurrentSong() )
			end
		end,
		OnCommand=function(self)
			self:setsize(418/2,164/2):ztest(1):y(SCREEN_TOP-100):sleep(3):decelerate(0.3):y(SCREEN_CENTER_Y-124)
		end,
		OffCommand=function(self)
			self:accelerate(0.3):addy(-SCREEN_CENTER_X)
		end,
	},
	LoadActor("../clock"),
}

return t;