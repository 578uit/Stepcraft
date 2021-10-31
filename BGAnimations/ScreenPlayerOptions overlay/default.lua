local bpm_text_zoom = 0.875
local song_bpms= {}
local bpm_text= "??? - ???"
local Players = GAMESTATE:GetHumanPlayers()
local function format_bpm(bpm)
	return ("%.0f"):format(bpm)
end

if GAMESTATE:GetCurrentSong() then
	song_bpms= GAMESTATE:GetCurrentSong():GetDisplayBpms()
	song_bpms[1]= math.round(song_bpms[1])
	song_bpms[2]= math.round(song_bpms[2])
	if song_bpms[1] == song_bpms[2] then
		bpm_text= format_bpm(song_bpms[1])
	else
		bpm_text= format_bpm(song_bpms[1]) .. " - " .. format_bpm(song_bpms[2])
	end
end
local FindOptionRowIndex = function(ScreenOptions, Name)
	if not ScreenOptions or not ScreenOptions.GetNumRows then return end

	local num_rows = ScreenOptions:GetNumRows()

	-- OptionRows on ScreenOptions are 0-indexed, so start counting from 0
	for i=0,num_rows-1 do
		if ScreenOptions:GetOptionRow(i):GetName() == Name then
			return i
		end
	end
end


local t = Def.ActorFrame{
	InitCommand=function(self)
		self:y(SCREEN_TOP+42)
	end;
}
	
	LoadActor("./ComboFontPreviews.lua", t)
	LoadActor("./NoteSkinPreviews.lua", t)
	LoadActor("./JudgmentGraphicPreviews.lua", t)
	LoadActor("./HoldJudgmentPreviews.lua", t)
	
	t[#t+1] = Def.ActorFrame{
		OnCommand=function(self)
			self:xy(SCREEN_LEFT+35,SCREEN_TOP+38)
		end,
		Def.BitmapText{
			Font="_minecraft 14px",
			Text="Select Modifiers",
			InitCommand=function(self) self:x(self:GetWidth()/1.2) self:addy(-42) self:skewx(-0.16) end,
			OnCommand=function(self)
				self:zoomx(0):zoomy(6):sleep(0.3):bounceend(.3):zoom(1.4)
			end;
			OffCommand=function(self)
				self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0)
			end;
		},		
		Def.BitmapText{
			Font="_minecraft 14px",
			Text="",
			InitCommand=function(self) self:x(self:GetWidth()/1.8) self:y(20) self:skewx(-0.16) end,
			OnCommand=function(self)
				self:zoomx(0):zoomy(6):sleep(0.3):bounceend(.3):zoom(0.9)
			end;
			OffCommand=function(self)
				self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0)
			end;
		},
	}
	-------------- PLAYER 1'S SPEED -------------------
	t[#t+1] = LoadFont("Common Normal") .. {
		Text="100 - 200000";
		Name="BPMRangeNew",
		Condition=GAMESTATE:IsPlayerEnabled(PLAYER_1);
		InitCommand= function(self)
			self:x(SCREEN_LEFT+128):y(SCREEN_BOTTOM-90):maxwidth(140/bpm_text_zoom):shadowlength(1):zoom(bpm_text_zoom)
			local speed, mode= GetSpeedModeAndValueFromPoptions(PLAYER_1)
			self:playcommand("SpeedChoiceChanged", {pn= PLAYER_1, mode= mode, speed= speed})
		end,
		BPMWillNotChangeCommand=function(self)
			self:diffuseshift():effectcolor1(color("#FF0707")):effectcolor2(Color.White):effectclock("beatnooffset")
		end,
		BPMWillChangeCommand=function(self)
			self:diffuseshift():effectcolor1(color("#FF0707")):effectcolor2(Color.White):effectclock("beatnooffset")
		end,
		SpeedChoiceChangedMessageCommand= function(self, param)
			if param.pn ~= PLAYER_1 then return end
			local text= "Speed:"
			local no_change= true
			if param.mode == "x" then
				if not song_bpms[1] then
					text= "??? - ???"
				elseif song_bpms[1] == song_bpms[2] then
					text= format_bpm(song_bpms[1] * param.speed*.01)
				else
					text= format_bpm(song_bpms[1] * param.speed*.01) .. " - " ..
						format_bpm(song_bpms[2] * param.speed*.01)
				end
				no_change= param.speed == 100
			elseif param.mode == "C" then
				text= param.mode .. param.speed
				no_change= param.speed == song_bpms[2] and song_bpms[1] == song_bpms[2]
			else
				no_change= param.speed == song_bpms[2]
				if song_bpms[1] == song_bpms[2] then
					text= param.mode .. param.speed
				else
					local factor= song_bpms[1] / song_bpms[2]
					text= param.mode .. format_bpm(param.speed * factor) .. " - "
						.. param.mode .. param.speed
				end
			end
			self:settext("P1 Speed: " .. text)
			if no_change then
				self:queuecommand("BPMWillNotChange")
			else
				self:queuecommand("BPMWillChange")
			end
		end
	}
	-------------- PLAYER 2'S SPEED -------------------
	t[#t+1] = LoadFont("Common Normal") .. {
		Text="100 - 200000";
		Condition=GAMESTATE:IsPlayerEnabled(PLAYER_2);
		Name="BPMRangeNew",
		InitCommand= function(self)
			self:x(SCREEN_RIGHT-128):y(SCREEN_BOTTOM-90):maxwidth(140/bpm_text_zoom):shadowlength(1):zoom(bpm_text_zoom)
			local speed, mode= GetSpeedModeAndValueFromPoptions(PLAYER_2)
			self:playcommand("SpeedChoiceChanged", {pn= PLAYER_2, mode= mode, speed= speed})
		end,
		BPMWillNotChangeCommand=function(self)
			self:diffuseshift():effectcolor1(color("#60AEF6")):effectcolor2(Color.White):effectclock("beatnooffset")
		end,
		BPMWillChangeCommand=function(self)
			self:diffuseshift():effectcolor1(color("#60AEF6")):effectcolor2(Color.White):effectclock("beatnooffset")
		end,
		SpeedChoiceChangedMessageCommand= function(self, param)
			if param.pn ~= PLAYER_2 then return end
			local text= "Speed:"
			local no_change= true
			if param.mode == "x" then
				if not song_bpms[1] then
					text= "??? - ???"
				elseif song_bpms[1] == song_bpms[2] then
					text= format_bpm(song_bpms[1] * param.speed*.01)
				else
					text= format_bpm(song_bpms[1] * param.speed*.01) .. " - " ..
						format_bpm(song_bpms[2] * param.speed*.01)
				end
				no_change= param.speed == 100
			elseif param.mode == "C" then
				text= param.mode .. param.speed
				no_change= param.speed == song_bpms[2] and song_bpms[1] == song_bpms[2]
			else
				no_change= param.speed == song_bpms[2]
				if song_bpms[1] == song_bpms[2] then
					text= param.mode .. param.speed
				else
					local factor= song_bpms[1] / song_bpms[2]
					text= param.mode .. format_bpm(param.speed * factor) .. " - "
						.. param.mode .. param.speed
				end
			end
			self:settext("P2 Speed: " .. text)
			if no_change then
				self:queuecommand("BPMWillNotChange")
			else
				self:queuecommand("BPMWillChange")
			end
		end
	}

return t