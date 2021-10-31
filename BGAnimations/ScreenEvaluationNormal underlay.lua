local newBPS, oldBPS
local swoosh, move

function play_sample_music(self)
    if GAMESTATE:IsCourseMode() then return end
    local song = GAMESTATE:GetCurrentSong()

    if song then
        local songpath = song:GetMusicPath()
        local sample_start = 0
        local sample_len = song:GetLastSecond()

        if songpath and sample_start and sample_len then
          SOUND:PlayMusicPart(songpath, sample_start,sample_len, 1, 1.5, false, true, true)
        else
            SOUND:PlayMusicPart("", 0, 0)
        end
    end
end


local Update = function(self)

	newBPS = GAMESTATE:GetSongBPS()
	move = (newBPS*-1)/32

	if GAMESTATE:GetSongFreeze() then move = 0 end
	if swoosh1 then swoosh1:texcoordvelocity(move,0) end
	if swoosh2 then swoosh2:texcoordvelocity(move,0) end

	oldBPS = newBPS
end

local t = Def.ActorFrame{
	InitCommand=function(self) self:SetUpdateFunction(Update) 
	end,
	LoadActor("arrow")..{
	InitCommand=function(self)
		self:x(SCREEN_CENTER_X):y(SCREEN_TOP+40):diffuse(color("#FF0707"))
		self:customtexturerect(0,0,1,1)
		swoosh1 = self
	end;
	},
	LoadActor("arrow")..{
	InitCommand=function(self)
		self:rotationz(180):x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y+194):diffuse(color("#60AEF6"))
		self:customtexturerect(0,0,1,1)
		swoosh2 = self
	end;
	},
	--[[LoadFont("Common Normal") .. {
		Text=GAMESTATE:GetSongBeat(),
		InitCommand = function(self)
			local BPM = GAMESTATE:GetSongBPS() * 60
			self:pulse()
			self:effectmagnitude(0.9,1,0)
			self:effectperiod(1)
			self:effectclock("beat")
		end;
		UpdateCommand = function(self)
			 self:settext(math.round(GAMESTATE:GetSongBeat()))
			 self:sleep(0.02)
			 self:queuecommand("Update")
		end;
	    OnCommand = function(self)
	        self:x(SCREEN_CENTER_X):y(SCREEN_TOP+64):zoom(1):queuecommand("Update")
		end;
	},]]
	--[[Def.Actor{
		OnCommand=cmd(queuecommand,"ChangeScreen"),
		ChangeScreenCommand=function(self)
			SCREENMAN:AddNewScreenToTop("ScreenDetectBPM")
		end;
		EvaluationOffMessageCommand=function(self)
			SCREENMAN:StartTransitioningScreen("SM_GoToNextScreen")
		end;
	},]]
}
if ThemePrefs.Get("BetterEvaluationScreen") then
  t[#t+1] = Def.Sound{
		File=GAMESTATE:GetCurrentSong():GetMusicPath();
		OnCommand=function(self)
			local audio = self:get()
			audio:volume(0.05)
			self:play()
		end;
		OffCommand=function(self)
			self:stop()
		end;
  }
end
return t