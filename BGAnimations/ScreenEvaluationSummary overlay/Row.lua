local position_on_screen = ...

local SongOrCourse, StageNum

local banner_directory = THEME:GetPathG("","Common fallback banner")

-- -----------------------------------------------------------------------
-- this ActorFrame contains elements shared by both players
-- like the background Quad, song banner, and song title

local t = Def.ActorFrame{
	DrawPageCommand=function(self, params)
		self:finishtweening():sleep(position_on_screen*0.05):linear(0.15):diffusealpha(0)

		StageNum = ((params.Page-1)*4) + position_on_screen
		local stage = SL.Global.Stages.Stats[StageNum]
		SongOrCourse = stage ~= nil and stage.song or nil

		self:playcommand("DrawStage", {StageNum=StageNum})
	end,
	DrawStageCommand=function(self)
		if SongOrCourse == nil then
			self:visible(false)
		else
			self:finishtweening():queuecommand("Show"):visible(true)
		end
	end
}

-- black quad
t[#t+1] = Def.Quad{
	Name="BackgroundQuad",
	InitCommand=function(self) self:zoomto( _screen.w-40, 94):diffuse(0,0,0,0.5):y(-6) end
}

--fallback banner
t[#t+1] = LoadActor(banner_directory)..{
	Name="FallbackBanner",
	InitCommand=function(self) self:y(-6):zoom(0.333) end,
	DrawStageCommand=function(self) self:visible(SongOrCourse ~= nil and not SongOrCourse:HasBanner()) end
}

-- the banner, if there is one
t[#t+1] = Def.Banner{
	Name="Banner",
	InitCommand=function(self) self:y(-6) end,
	DrawStageCommand=function(self)
		if SongOrCourse then
			if GAMESTATE:IsCourseMode() then
				self:LoadFromCourse(SongOrCourse)
			else
				self:LoadFromSong(SongOrCourse)
			end
			self:setsize(418,164):zoom(0.333)
		end
	end
}

-- the title of the song
t[#t+1] = LoadFont("Common normal")..{
	Name="SongTitle",
	InitCommand=function(self) self:zoom(0.8):y(-43):maxwidth(350) end,
	DrawStageCommand=function(self)
		if SongOrCourse then self:settext(SongOrCourse:GetDisplayFullTitle()) end
	end
}

-- the BPM(s) of the song
-- FIXME: the current layout of ScreenEvaluationSummary doesn't accommodate split BPMs
--        so this is currently hardcoded to use the MasterPlayer's BPM values
t[#t+1] = LoadFont("Common normal")..{
		InitCommand=cmd(zoom,0.6; y,30; maxwidth, 350),
		OnCommand=function(self)
			if song then
				local text = ""
				local BPMs = song:GetDisplayBpms()		
				
				if BPMs then
					if BPMs[1] == BPMs[2] then
						text = text .. round(BPMs[1]) .. " BPM"
					else
						text = text .. round(BPMs[1]) .. " - " .. round(BPMs[2]) .. " BPM"
					end
				end
				
				self:settext(text)
			end
		end
}

-- -----------------------------------------------------------------------
-- Loop through the PlayerNumber enum provided by the engine.
-- This is basically a hardcoded { "PlayerNumber_P1", "PlayerNumber_P2" }
-- and that is what we want here.
--
-- We shouldn't use something like GAMESTATE:GetHumanPlayers() because players
-- can late-join (and maybe late-unjoin someday soon) and GetHumanPlayers()
-- would return whichever players were currently joined at the time of ScreenEvalSummary.

for player in ivalues(PlayerNumber) do
	-- PlayerStageStats.lua handles player-specific things
	-- like stepchart difficulty, stepartist, letter grade, and judgment breakdown
	t[#t+1] = LoadActor("./PlayerStageStats.lua", player)
end

return t
