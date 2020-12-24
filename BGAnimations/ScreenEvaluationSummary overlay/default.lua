local newBPS, oldBPS
local swoosh, move
local song = GAMESTATE:GetCurrentSong()
	
local Update = function(self)

	newBPS = GAMESTATE:GetSongBPS()
	move = (newBPS*-1)/32

	if GAMESTATE:GetSongFreeze() then move = 0 end
	if swoosh1 then swoosh1:texcoordvelocity(move,0) end
	if swoosh2 then swoosh2:texcoordvelocity(move,0) end

	oldBPS = newBPS
end

local numStages = SL.Global.Stages.PlayedThisGame

local page = 1
local pages = math.ceil(numStages/4)
local next_page

-- start by assuming that the player has dedicated MenuButtons
local buttons = {
	-- previous page
	Left=-1,
	Up=-1,
	DownLeft=-1,
	-- next page
	Right=1,
	Down=1,
	DownRight=1
}


local page_text = "Page"

-- -----------------------------------------------------------------------

local t = Def.ActorFrame{
	InitCommand=function(self) self:SetUpdateFunction(Update) end,
	CodeMessageCommand=function(self, param)

		if pages > 1 and buttons[param.Name] ~= nil then
			next_page = page + buttons[param.Name]

			if next_page > 0 and next_page < pages+1 then
				page = next_page
				self:finishtweening():queuecommand("Hide")
			end
		end
	end,
	LoadActor("../arrow")..{
	InitCommand=function(self)
		self:x(SCREEN_CENTER_X):y(SCREEN_TOP+40):diffuse(color("#FF0707"))
		self:customtexturerect(0,0,1,1)
		swoosh1 = self
	end;
	},
	LoadActor("../arrow")..{
	InitCommand=function(self)
		self:rotationz(180):x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y+194):diffuse(color("#60AEF6"))
		self:customtexturerect(0,0,1,1)
		swoosh2 = self
	end;
	},
}

-- centered text like "Page 2/5" where
-- 2 is the current page the player is viewing, and
-- 5 is the total number of pages
t[#t+1] = LoadFont("_minecraft 14px")..{
	Name="PageNumber",
	Text=("%s %i/%i"):format(page_text, page, pages),
	InitCommand=function(self) self:xy(SCREEN_LEFT+40,SCREEN_TOP+38) self:skewx(-0.16) self:horizalign(0) end,
	OnCommand=function(self) self:zoomx(0):zoomy(6):sleep(0.3):bounceend(.3):zoom(1.4) end,
	OffCommand=function(self) self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0) end,
	HideCommand=function(self) self:sleep(0.5):settext( ("%s %i/%i"):format(page_text, page, pages) ) end
}

t[#t+1] = LoadActor("../clock")
t[#t+1] = LoadActor("./LetterGrades.lua")

-- -----------------------------------------------------------------------
-- 4 rows
-- i will increment so that we progress down the screen from top to bottom
-- first song of the round at the top, more recently played song at the bottom

for i=1,4 do

	t[#t+1] = LoadActor("Row.lua", i)..{
		Name="StageStats_"..i,
		InitCommand=function(self) self:diffusealpha(0):zoom(0.85) end,
		OnCommand=function(self)
			self:xy(_screen.cx, ((_screen.h/5.25) * i + 13))
				:queuecommand("Hide")
		end,
		ShowCommand=function(self)
			self:finishtweening():sleep(i*0.05):linear(0.15):diffusealpha(1)
		end,
		HideCommand=function(self)
			self:playcommand("DrawPage", {Page=page})
		end,
	}

end

-- -----------------------------------------------------------------------

return t