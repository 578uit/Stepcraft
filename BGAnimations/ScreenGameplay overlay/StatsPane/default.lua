local pn = GAMESTATE:GetMasterPlayerNumber()

return Def.ActorFrame{
	InitCommand=function(self)
		self:x(pn == PLAYER_1 and SCREEN_CENTER_X+150 or SCREEN_CENTER_X-150)
		self:y(SCREEN_CENTER_Y)
	end;
	Def.ActorFrame{
		BeginCommand=function(self) self:visible(GAMESTATE:IsHumanPlayer(pn)) end,
		OnCommand=function(self)
			self:diffusealpha(0):linear(0.2):diffusealpha(1)
		end,
		LoadActor("_box")..{
			OnCommand=function(self) self:zoom(0.65) end,
		},
		Def.Sprite{
			Name="Jacket",
			InitCommand=function(self) self:scaletoclipped(100,100):x(-105):y(-75) end,
			OnCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				if song then
					if (song:GetJacketPath() ~=  nil) then
						self:Load(song:GetJacketPath())
					elseif (song:GetBackgroundPath() ~= nil) then
						self:Load(song:GetBackgroundPath())
					elseif (song:GetBannerPath() ~= nil) then
						self:Load(song:GetBannerPath())
					else
						self:Load(THEME:GetPathG("Common", "fallback jacket"));
					end
				end
			end,
		},
		-- Histogram, Life Graph and Scatter Plot
		LoadActor("./DensityGraph.lua", {pn, 200})..{
			InitCommand=function(self) self:x(-45):y(-126) end,
		},
		-- Meter
		Def.Sprite{
			Texture="_fill",
			InitCommand=function(self) self:diffuse(color("#21CCE8")):zoom(0.65):x(-88):y(12):cropright(1) end,
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
					self:playcommand("Update")
				end
			end;
			UpdateCommand=function(self)
				local steps = GAMESTATE:GetCurrentSteps(pn)
				if steps then
					local TotalSteps = steps:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local w1Notes = pss:GetTapNoteScores('TapNoteScore_W1')
					self:cropright(1-w1Notes/TotalSteps)
				end
			end;
		},
		Def.Sprite{
			Texture="_fill",
			InitCommand=function(self) self:diffuse(color("#e29c18")):zoom(0.65):x(-88):y(52):cropright(1) end,
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
					self:playcommand("Update")
				end
			end;
			UpdateCommand=function(self)
				local steps = GAMESTATE:GetCurrentSteps(pn)
				if steps then
					local TotalSteps = steps:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
					self:cropright(1-w2Notes/TotalSteps)
				end
			end;
		},
		Def.Sprite{
			Texture="_fill",
			InitCommand=function(self) self:diffuse(color("#66c955")):zoom(0.65):x(-88):y(93):cropright(1) end,
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
					self:playcommand("Update")
				end
			end;
			UpdateCommand=function(self)
				local steps = GAMESTATE:GetCurrentSteps(pn)
				if steps then
					local TotalSteps = steps:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local w3Notes = pss:GetTapNoteScores('TapNoteScore_W3')
					self:cropright(1-w3Notes/TotalSteps)
				end
			end;
		},
		Def.Sprite{
			Texture="_fill",
			InitCommand=function(self) self:diffuse(color("#5b2b8e")):zoom(0.65):x(88):y(12):cropright(1) end,
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
					self:playcommand("Update")
				end
			end;
			UpdateCommand=function(self)
				local steps = GAMESTATE:GetCurrentSteps(pn)
				if steps then
					local TotalSteps = steps:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local w4Notes = pss:GetTapNoteScores('TapNoteScore_W4')
					self:cropright(1-w4Notes/TotalSteps)
				end
			end;
		},
		Def.Sprite{
			Texture="_fill",
			InitCommand=function(self) self:diffuse(color("#c9855e")):zoom(0.65):x(88):y(52):cropright(1) end,
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
					self:playcommand("Update")
				end
			end;
			UpdateCommand=function(self)
				local steps = GAMESTATE:GetCurrentSteps(pn)
				if steps then
					local TotalSteps = steps:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local w5Notes = pss:GetTapNoteScores('TapNoteScore_W5')
					self:cropright(1-w5Notes/TotalSteps)
				end
			end;
		},
		Def.Sprite{
			Texture="_fill",
			InitCommand=function(self) self:diffuse(color("#ff0000")):zoom(0.65):x(88):y(93):cropright(1) end,
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
					self:playcommand("Update")
				end
			end;
			UpdateCommand=function(self)
				local steps = GAMESTATE:GetCurrentSteps(pn)
				if steps then
					local TotalSteps = steps:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local MissNotes = pss:GetTapNoteScores('TapNoteScore_Miss')
					self:cropright(1-MissNotes/TotalSteps)
				end
			end;
		},
		-- Judgment Label
		Def.BitmapText{
			Font="Common Normal",
			Text="Fantastic",
			InitCommand=function(self) self:x(-90):y(10):diffusealpha(0):linear(0.2):diffusealpha(1):sleep(3):linear(0.2):diffusealpha(0) end,
		},
		Def.BitmapText{
			Font="Common Normal",
			Text="Excellent",
			InitCommand=function(self) self:x(-90):y(50):diffusealpha(0):linear(0.2):diffusealpha(1):sleep(3):linear(0.2):diffusealpha(0) end,
		},
		Def.BitmapText{
			Font="Common Normal",
			Text="Great",
			InitCommand=function(self) self:x(-90):y(90):diffusealpha(0):linear(0.2):diffusealpha(1):sleep(3):linear(0.2):diffusealpha(0) end,
		},
		Def.BitmapText{
			Font="Common Normal",
			Text="Decent",
			InitCommand=function(self) self:x(90):y(10):diffusealpha(0):linear(0.2):diffusealpha(1):sleep(3):linear(0.2):diffusealpha(0) end,
		},
		Def.BitmapText{
			Font="Common Normal",
			Text="Way Off",
			InitCommand=function(self) self:x(90):y(50):diffusealpha(0):linear(0.2):diffusealpha(1):sleep(3):linear(0.2):diffusealpha(0) end,
		},
		Def.BitmapText{
			Font="Common Normal",
			Text="Miss",
			InitCommand=function(self) self:x(90):y(90):diffusealpha(0):linear(0.2):diffusealpha(1):sleep(3):linear(0.2):diffusealpha(0) end,
		},
		-- Judgment Number
		Def.BitmapText{
			Font="Common Normal",
			Text="0",
			InitCommand=function(self) self:diffuse(color("#21CCE8")):x(-150):y(10):halign(0):diffusealpha(0):sleep(3.2):linear(0.2):diffusealpha(1) end,
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
					self:playcommand("Update")
				end
			end;
			UpdateCommand=function(self)
				local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
				local w1Notes = pss:GetTapNoteScores('TapNoteScore_W1')
				self:settext(w1Notes)
			end;
		},
		Def.BitmapText{
			Font="Common Normal",
			Text="0",
			InitCommand=function(self) self:diffuse(color("#e29c18")):x(-150):y(50):halign(0):diffusealpha(0):sleep(3.2):linear(0.2):diffusealpha(1) end,
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
					self:playcommand("Update")
				end
			end;
			UpdateCommand=function(self)
				local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
				local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
				self:settext(w2Notes)
			end;
		},
		Def.BitmapText{
			Font="Common Normal",
			Text="0",
			InitCommand=function(self) self:diffuse(color("#66c955")):x(-150):y(90):halign(0):diffusealpha(0):sleep(3.2):linear(0.2):diffusealpha(1) end,
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
					self:playcommand("Update")
				end
			end;
			UpdateCommand=function(self)
				local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
				local w3Notes = pss:GetTapNoteScores('TapNoteScore_W3')
				self:settext(w3Notes)
			end;
		},
		Def.BitmapText{
			Font="Common Normal",
			Text="0",
			InitCommand=function(self) self:diffuse(color("#5b2b8e")):x(30):y(10):halign(0):diffusealpha(0):sleep(3.2):linear(0.2):diffusealpha(1) end,
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
					self:playcommand("Update")
				end
			end;
			UpdateCommand=function(self)
				local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
				local w4Notes = pss:GetTapNoteScores('TapNoteScore_W4')
				self:settext(w4Notes)
			end;
		},
		Def.BitmapText{
			Font="Common Normal",
			Text="0",
			InitCommand=function(self) self:diffuse(color("#c9855e")):x(30):y(50):halign(0):diffusealpha(0):sleep(3.2):linear(0.2):diffusealpha(1) end,
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
					self:playcommand("Update")
				end
			end;
			UpdateCommand=function(self)
				local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
				local w5Notes = pss:GetTapNoteScores('TapNoteScore_W5')
				self:settext(w5Notes)
			end;
		},
		Def.BitmapText{
			Font="Common Normal",
			Text="0",
			InitCommand=function(self) self:diffuse(color("#ff0000")):x(30):y(90):halign(0):diffusealpha(0):sleep(3.2):linear(0.2):diffusealpha(1) end,
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
					self:playcommand("Update")
				end
			end;
			UpdateCommand=function(self)
				local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
				local MissNotes = pss:GetTapNoteScores('TapNoteScore_Miss')
				self:settext(MissNotes)
			end;
		},
	}
}