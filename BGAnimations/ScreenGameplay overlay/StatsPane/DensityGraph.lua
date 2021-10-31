local player, width = unpack(...)

local pn = ToEnumShortString(player)
-- height is how tall, in pixels, the density graph will be
local height = 101

local lastmaxstep = 1

local GraphIsMoving = false

local LifeBaseSampleRate = 0.25
local LifeLineThickness = 2
local LifeMeter = nil
local life_verts = {}
local offset = 0

local IsUltraWide = (GetScreenAspectRatio() > 21/9)
local NoteFieldIsCentered = (GetNotefieldX(player) == _screen.cx)

-- variables that will be used and re-used in the loop while calculating the AMV's vertices
local JOffset, CurrentSecond, TimingWindow, x, y, c, r, g, b
-- ---------------------------------------------
-- if players have disabled W4 or W4+W5, there will be a smaller pool
-- of judgments that could have possibly been earned
local worst_window = PREFSMAN:GetPreference("TimingWindowSecondsW5")
local windows = SL.Global.ActiveModifiers.TimingWindows
for i=5,1 do
	if windows[i] then
		worst_window = PREFSMAN:GetPreference("TimingWindowSecondsW"..i)
		break
	end
end

-- ---------------------------------------------
local colors = {
color("#21CCE8"),	-- blue
color("#e29c18"),	-- gold
color("#66c955"),	-- green
color("#5b2b8e"),	-- purple
color("#c9855e"),	-- peach?
color("#ff0000")	-- red
}

-- -----------------------------------------------------------------------
local BothUsingStepStats = (#GAMESTATE:GetHumanPlayers()==2
and SL.P1.ActiveModifiers.DataVisualizations == "Step Statistics"
and SL.P2.ActiveModifiers.DataVisualizations == "Step Statistics")
-- -----------------------------------------------------------------------

-- max_seconds is how many seconds of a stepchart we want visualized on-screen at once.
-- For very long songs (longer than, say, 10 minutes) the density graph becomes too
-- horizontally compressed (squeezed in, so to speak) and it's dificult get any useful
-- information out of it, visually.  And there are a lot of Very Long Songs™.
--
-- So, we hardcode it to 4 minutes here. If the song is longer than 4 minutes, the density
-- graph will scroll with the song.  If the song is shorter than 4 minutes, we'll scale
-- the width of the graph to take up the full width available in the StepStatistics sidebar.
local max_seconds = 3 * 60

-- width and position of the density graph
local pos_x = -width / 2

local scaled_width = width
local UpdateRate, first_second, last_second

local af = Def.ActorFrame{
	InitCommand=function(self)
		self:xy( pos_x, 55 ):queuecommand("Update")
	end,
	OnCommand=function(self)
		LifeMeter = SCREENMAN:GetTopScreen():GetChild("Life"..pn)
	end,
	UpdateCommand=function(self)
		self:sleep(UpdateRate):queuecommand("Update")
	end
}

-- gray background Quad
local bg = Def.Quad{
	InitCommand=function(self)
		self:zoomto(width, height)
			:align(0,0)
			:diffuse(color("#1E282F"))
	end
}

-- FIXME: add inline comments explaining the intent/purpose of this code
local SlopeAngle = function(p1, p2)
	return math.atan2(p2[1] - p1[1], p2[2] - p1[2])
end

local histogram_amv = Scrolling_NPS_Histogram(player, width, height)..{
	OnCommand=function(self)
		-- offset the graph's x-position by half the thickness of the LifeLine
		self:xy( LifeLineThickness/2, height )
	end,
	PeakNPSUpdatedMessageCommand=function(self) self:queuecommand("Size") end,
	SizeCommand=function(self)
		if BothUsingStepStats then
			local my_peak = GAMESTATE:Env()[pn.."PeakNPS"]
			local their_peak = GAMESTATE:Env()[ToEnumShortString(OtherPlayer[player]).."PeakNPS"]

			if my_peak < their_peak then
				self:zoomtoheight(my_peak/their_peak)
			end
		end
	end
}

-- PeakNPS text
local text = LoadFont("Common Normal")..{
	InitCommand=function(self)
		self:zoom(0.9)
		self:halign(1)
		self:vertalign(bottom)
		self:x(200):y(-5)
	end,
	PeakNPSUpdatedMessageCommand=function(self)
		local my_peak = GAMESTATE:Env()[pn.."PeakNPS"]
		if my_peak == nil then
			self:settext("")
			return
		end	
		self:settext( ("%s: %g"):format("Peak NPS", round(my_peak) ))
	end,
}
local graph_and_lifeline = Def.ActorFrame{

	CurrentSongChangedMessageCommand=function(self)
		local song = GAMESTATE:GetCurrentSong()
		first_second = math.min(song:GetTimingData():GetElapsedTimeFromBeat(0), 0)
		last_second = song:GetLastSecond()
		-- reset scaled_width now to be only as wide as the notefield
		scaled_width = width
		TimingData = song:GetTimingData()

		-- if the song is longer than max_seconds, scale up the width of the graph
		local duration = last_second - first_second
		if duration > max_seconds then
			local ratio = duration / max_seconds
			scaled_width = width * ratio
		end

		histogram_amv:LoadCurrentSong(scaled_width)

		UpdateRate = LifeBaseSampleRate

		-- FIXME: add inline comments explaining what a 'simple' BPM is -quietly
		-- FIXME: add inline comments explaining what "quantize the timing [...] to avoid jaggies" means
		--            because I have no idea what it means -quietly

		-- if the song has a 'simple' BPM, then quantize the timing
		-- to the nearest multiple of 8ths to avoid jaggies
		if not TimingData:HasBPMChanges() then
			local bpm = TimingData:GetBPMs()[1]
			if bpm >= 60 and bpm <= 300 then
				-- make sure that the BPM makes sense
				local Interval8th = (60 / bpm) / 2
				UpdateRate = Interval8th * math.ceil(UpdateRate / Interval8th)
			end
		end

		-- reset x-offset between songs in CourseMode
		self:x(0)
		offset = 0
	end,

	UpdateCommand=function(self)
		-- if it's not a long graph, there's no need to scroll it at all
		if scaled_width <= width then return end

		local current_second = GAMESTATE:GetCurMusicSeconds()

		-- if the end of the song is close, no need to keep scrolling
		if current_second > last_second - (max_seconds*0.75) then return end

		-- use 1/4 of whatever max_seconds is as the cutoff to start scrolling the graph
		local seconds_past_one_fourth = (current_second-first_second) - (max_seconds*0.25)

		if seconds_past_one_fourth > 0 then
			offset = scale(seconds_past_one_fourth, 0, last_second-first_second, 0, scaled_width)
			self:x(-offset)
			histogram_amv:SetScrollOffset(offset)
		end
	end,

	-- density graph
	histogram_amv,
	-- scatter plot
	Def.ActorMultiVertex{
		Name="JudgmentPlot_AMV",
        OnCommand=function(s) s:MaskDest():SetDrawState{Mode="DrawMode_Quads"} end,
        JudgmentMessageCommand=function(self, params)
			local judgment_offset = params.TapNoteScore == "TapNoteScore_Miss" and "Miss" or params.TapNoteOffset
			local SongTotal = GAMESTATE:GetCurrentSong():MusicLengthSeconds()
			local CurrentSecond = GAMESTATE:GetCurMusicSeconds()
			JOffset = judgment_offset
			if JOffset ~= "Miss" then
				CurrentSecond = CurrentSecond - JOffset
			else
				CurrentSecond = CurrentSecond - worst_window
			end

			-- pad the right end because the time measured seems to lag a little...
			x = scale(CurrentSecond, first_second, last_second, 0, scaled_width)

			if JOffset ~= "Miss" then
				-- DetermineTimingWindow() is defined in ./Scripts/SL-Helpers.lua
				TimingWindow = DetermineTimingWindow(JOffset)
				y = scale(JOffset, worst_window, -worst_window, 0, height)

				-- get the appropriate color from the global SL table
				c = colors[TimingWindow]
				-- get the red, green, and blue values from that color
				r = c[1]
				g = c[2]
				b = c[3]

				-- insert four datapoints into the verts tables, effectively generating a single quadrilateral
				-- top left,  top right,  bottom right,  bottom left
				table.insert( step_verts, {{x,y,0}, {r,g,b,0.666}} )
				table.insert( step_verts, {{x+1.5,y,0}, {r,g,b,0.666}} )
				table.insert( step_verts, {{x+1.5,y+1.5,0}, {r,g,b,0.666}} )
				table.insert( step_verts, {{x,y+1.5,0}, {r,g,b,0.666}} )
			else
				-- else, a miss should be a quadrilateral that is the height of the entire graph and red
				table.insert( step_verts, {{x, 0, 0}, color("#ff000077")} )
				table.insert( step_verts, {{x+1, 0, 0}, color("#ff000077")} )
				table.insert( step_verts, {{x+1, height, 0}, color("#ff000077")} )
				table.insert( step_verts, {{x, height, 0}, color("#ff000077")} )
			end	
			if #step_verts > 3 and step_verts[1][1][1] < offset then
				table.remove(step_verts, 1)
				table.remove(step_verts, 2)
				table.remove(step_verts, 3)
				table.remove(step_verts, 4)
			end
			self:SetNumVertices(#step_verts):SetVertices(step_verts)
		end,
		UpdateCommand=function(self)
			if #step_verts > 3 and step_verts[1][1][1] < offset then
				table.remove(step_verts, 1)
				table.remove(step_verts, 2)
				table.remove(step_verts, 3)
				table.remove(step_verts, 4)
			end
			self:SetNumVertices(#step_verts):SetVertices(step_verts)
		end,
        CurrentSongChangedMessageCommand=function(s)
            step_verts = {}
            s:SetNumVertices(0):SetVertices( step_verts )
        end
    },
	-- lifeline
	Def.ActorMultiVertex{
		Name="LifeLine_AMV",
		InitCommand=function(self)
			self:SetDrawState({Mode="DrawMode_LineStrip"})
				:SetLineWidth( LifeLineThickness )
				:align(0, 0)
		end,
		UpdateCommand=function(self)
			if GAMESTATE:GetCurMusicSeconds() > 0 then
				local seconds = GAMESTATE:GetCurMusicSeconds()
				if seconds > last_second then return end

				local x = scale( seconds, first_second, last_second, 0, scaled_width )
				local y = scale( LifeMeter:GetLife(), 1, 0, 0, height )
				-- if the slopes of the newest line segment is similar
				-- to the previous segment, just extend the old one.
				local condense = false
				if (#life_verts >= 2) then
					local slope_original = SlopeAngle(life_verts[#life_verts-1][1], life_verts[#life_verts][1])
					local slope_new = SlopeAngle(life_verts[#life_verts][1], {x,y})

					-- 0.18 rad = ~10 deg
					condense = math.abs(slope_new - slope_original) < 0.18 and slope_original > 0 and slope_new > 0
				end

				if condense then
					life_verts[#life_verts][1] = {x, y, 0}
				else
					life_verts[#life_verts+1] = {{x, y, 0}, { y/101 ,1 - (y/101), 0 , 1}}
				end

				while #life_verts > 0 and life_verts[1][1][1] < offset do
					if #life_verts > 1 and life_verts[2][1][1] >= offset then
						life_verts[1] = interpolate_vert(life_verts[1], life_verts[2], offset)
						break
					else
						table.remove(life_verts, 1)
					end
				end

				self:SetNumVertices(#life_verts):SetVertices(life_verts)
			end
		end,
		CurrentSongChangedMessageCommand=function(self)
			life_verts = {}
			self:SetNumVertices(#life_verts):SetVertices(life_verts)
		end
	},
}

af[#af+1] = text
-- af[#af+1] = bg
af[#af+1] = graph_and_lifeline

return af
