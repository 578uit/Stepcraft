-- SM Chart Parser used in Simply Love <3
local Steps
local Song

GetSMData = function(steps)

	-- steps:GetFilename() returns the filename of the sm or ssc file, including path, as it is stored in SM's cache
	local filename = steps:GetFilename()
	if not filename then return end

	-- get the file extension like "sm" or "SM" or "ssc" or "SSC" or "sSc" or etc.
	-- convert to lowercase
	local filetype = filename:match("[^.]+$"):lower()
	-- if file doesn't match "ssc" or "sm", it was (hopefully) something else (.dwi, .bms, etc.)
	-- that isn't supported by SL-ChartParser
	if not (filetype=="ssc" or filetype=="sm") then return end

	-- create a generic RageFile that we'll use to read the contents
	-- of the desired .ssc or .sm file
	local f = RageFileUtil.CreateRageFile()
	local contents

	-- the second argument here (the 1) signals
	-- that we are opening the file in read-only mode
	if f:Open(filename, 1) then
		contents = f:Read()
	end

	-- destroy the generic RageFile now that we have the contents
	f:destroy()
	return contents, filetype
end

local BPMsAndOffset = function(SimfileString, Filetype)
	
	local BPMs = nil
	local Offset = nil

	if Filetype == "ssc" then
		-- SSC File
		-- Find needed variables
		for bpm in SimfileString:gmatch("#BPMS:[^;]*") do
			BPMs = "#BPMS:"
			BPMs = bpm:match("#BPMS:([^;]*)\n?$")
			BPMs = BPMs .. ";"
			break
		end
		for offset in SimfileString:gmatch("#OFFSET:[^;]*") do
			Offset = offset:match("#OFFSET:[^;]*")
			Offset = Offset .. ";"
			break
		end
	elseif Filetype == "sm" then
		-- SM FILE
		-- Find needed variables
		for bpm in SimfileString:gmatch("#BPMS:[^;]*") do
			BPMs = "#BPMS:"
			BPMs = bpm:match("([^;]*)\n?$")
			BPMs = BPMs .. ";"
			break
		end
		for offset in SimfileString:gmatch("#OFFSET:[^;]*") do
			Offset = offset:match("#OFFSET:[^;]*")
			Offset = Offset .. ";"
			break
		end
	end

	if BPMs ~= "" and Offset ~= "" then
		local path = THEME:GetCurrentThemeDirectory().."Sounds/ScreenEvaluationNormal music.sm"
		local file= RageFileUtil.CreateRageFile()
		if not file:Open(path, 2) then
			Warn("Could not open '" .. path .. "' to write current playing info.")
		else
			file:Write("#TITLE:ScreenEvaluationNormal music;\n")
			file:Write(BPMs .. "\n")
			file:Write(Offset .. "\n")
			file:Write("#STOP:;")
			file:Close()
			file:destroy()
		end
	end;
end

local t = Def.ActorFrame{
	OnCommand=function(self)
		if not GAMESTATE:IsCourseMode() then
			-- grab only 1 player steps
			if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
				Steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
			elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) then
				Steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
			end
		end
		local Data, FileType = GetSMData(Steps)
		BPMsAndOffset(Data, FileType)
	end,
	CurrentStepsP1ChangedMessageCommand=function(self)
		if not GAMESTATE:IsCourseMode() then
			if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
				Steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
			end
		end
		local Data, FileType = GetSMData(Steps)
		BPMsAndOffset(Data, FileType)
	end,
	CurrentStepsP2ChangedMessageCommand=function(self)
		if not GAMESTATE:IsCourseMode() then
			if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
				Steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
			end
		end
		local Data, FileType = GetSMData(Steps)
		BPMsAndOffset(Data, FileType)
	end,
}

return t