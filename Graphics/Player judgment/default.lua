local player = Var "Player"
local pn = ToEnumShortString(player)
local mods = SL[pn].ActiveModifiers
local kids, JudgmentSet

local available_judgments = GetJudgmentGraphics()

local file_to_load = (FindInTable(mods.JudgmentGraphic, available_judgments) ~= nil and mods.JudgmentGraphic or available_judgments[1]) or "None"

if file_to_load == "None" then
	return Def.Actor{ InitCommand=function(self) self:visible(false) end }
end

local OffBar = Def.ActorFrame{ 
	InitCommand=function(s) 
		if SL[pn].ActiveModifiers.Protiming == "Only Offset Bars" or SL[pn].ActiveModifiers.Protiming == "Offset Bars + MS Count" then
			s:visible(true) 
		else
			s:visible(false)
		end
	end,
	Def.Quad{ Name="Background", OnCommand=function(s) s:zoomto(150,1):fadeleft(1):faderight(1):visible(false) end },
	Def.Quad{ Name="Center", OnCommand=function(s) s:zoomto(2,15) end }
}
for i=1,30 do OffBar[#OffBar+1] = Def.Quad{ InitCommand=function(s) s:zoomto(2,15):diffusealpha(0) end } end
local curoffset = 1

local function MakeAverage( t )
	local sum = 0;
	for i=1,#t do
		sum = sum + t[i];
	end
	return sum / #t
end

local tTotalJudgments = {};

local TNSFrames = {
	TapNoteScore_W1 = 0;
	TapNoteScore_W2 = 1;
	TapNoteScore_W3 = 2;
	TapNoteScore_W4 = 3;
	TapNoteScore_W5 = 4;
	TapNoteScore_Miss = 5;
};

local RotTween = {
	-- Even, Odd
	TapNoteScore_W1 = {0,0},
	TapNoteScore_W2 = {0,0},
	TapNoteScore_W3 = {-3,3},	
	TapNoteScore_W4 = {-5,5},
	TapNoteScore_W5 = {-10,10},
	TapNoteScore_Miss = {-30,30},
};

local ProtimingCmds = {
	TapNoteScore_W1 = THEME:GetMetric( "Protiming", "ProtimingW1Command" );
	TapNoteScore_W2 = THEME:GetMetric( "Protiming", "ProtimingW2Command" );
	TapNoteScore_W3 = THEME:GetMetric( "Protiming", "ProtimingW3Command" );
	TapNoteScore_W4 = THEME:GetMetric( "Protiming", "ProtimingW4Command" );
	TapNoteScore_W5 = THEME:GetMetric( "Protiming", "ProtimingW5Command" );
	TapNoteScore_Miss = THEME:GetMetric( "Protiming", "ProtimingMissCommand" );
}

local t = Def.ActorFrame {};
t[#t+1] = Def.ActorFrame {	
	Def.Sprite{
		Name="JudgmentWithOffsets",
		InitCommand=function(self)
			self:y(5)
			self:pause():visible(false)

			-- if we are on ScreenEdit, judgment graphic is always "Love"
			-- because ScreenEdit is a mess and not worth bothering with.
			if string.match(tostring(SCREENMAN:GetTopScreen()), "ScreenEdit") then
				self:Load( THEME:GetPathG("", "judgments/Minecraft") )

			else
				self:Load( THEME:GetPathG("", "judgments/" .. file_to_load) )
			end

		end,
		ResetCommand=cmd(finishtweening; stopeffect; visible,false)
	},
	
	InitCommand=function(self)
		kids = self:GetChildren()
		JudgmentSet = kids.JudgmentWithOffsets
	end,

	JudgmentMessageCommand=function(self, param)
	
		local OFB = self:GetChild("OffsetBar")
		
		if param.Player ~= player then return end
		if not param.TapNoteScore then return end
		if param.HoldNoteScore then return end
		
		if param.TapNoteScore == "TapNoteScore_W1" then
			judgment_color = color("#21CCE8")			
		elseif param.TapNoteScore == "TapNoteScore_W2" then
			judgment_color = color("#e29c18")
		elseif param.TapNoteScore == "TapNoteScore_W3" then
			judgment_color = color("#66c955")	
		elseif param.TapNoteScore == "TapNoteScore_W4" then
			judgment_color = color("#b45cff")	
		elseif param.TapNoteScore == "TapNoteScore_W5" then
			judgment_color = color("#c9855e")
		elseif param.TapNoteScore == "TapNoteScore_Miss" then
			judgment_color = color("#ff3030")
		end
		
		-- frame check; actually relevant now.
		local iNumStates = JudgmentSet:GetNumStates()
		local frame = TNSFrames[ param.TapNoteScore ]
		if not frame then return end
		if iNumStates == 12 then
			frame = frame * 2
			if not param.Early then
				frame = frame + 1
			end
		end
		
		local fTapNoteOffset = param.TapNoteOffset;
		if param.HoldNoteScore then
			fTapNoteOffset = 1;
		else
			fTapNoteOffset = param.TapNoteOffset; 
		end
		
		if param.TapNoteScore == 'TapNoteScore_Miss' then
			fTapNoteOffset = 1;
			bUseNegative = true;
		else
-- 			fTapNoteOffset = fTapNoteOffset;
			bUseNegative = false;
		end;
		
		if fTapNoteOffset ~= 1 then
			-- we're safe, you can push the values
			tTotalJudgments[#tTotalJudgments+1] = math.abs(fTapNoteOffset);
--~ 			tTotalJudgments[#tTotalJudgments+1] = bUseNegative and fTapNoteOffset or math.abs( fTapNoteOffset );
		end
		
		self:playcommand("Reset")
		
		-- begin commands
		JudgmentSet:visible( true )
		JudgmentSet:setstate( frame )

		-- this should match the custom JudgmentTween() from SL for 3.95
		JudgmentSet:zoom(.9):bounceend(.2):zoom(.75):sleep(.6):accelerate(.2):zoom(0)

		kids.ProtimingDisplay:settextf("%ims",fTapNoteOffset * 1000);
		ProtimingCmds[param.TapNoteScore](kids.ProtimingDisplay);
		
		OFB:GetChild("Background"):visible(true)
		OFB:GetChild("")[curoffset]:finishtweening()
		:diffuse(judgment_color) 
		:x( math.floor(math.abs(param.TapNoteOffset * 600 ))*(param.Early and -1 or 1) ):sleep(0.2):linear(3):diffusealpha(0)
		curoffset = curoffset < 30 and curoffset + 1 or 1
	end,
	LoadFont("_minecraft 14px") .. {
		Name="ProtimingDisplay";
		Text="";
		InitCommand=function(self)
			if SL[pn].ActiveModifiers.Protiming == "Only MS Count" or SL[pn].ActiveModifiers.Protiming == "Offset Bars + MS Count" then
				self:visible(true)
			else
				self:visible(false)
			end
		end,
		OnCommand=cmd(shadowlength,1;zoom,1;y,-14;textglowmode,"TextGlowMode_Inner");
		ResetCommand=cmd(finishtweening;stopeffect);
	};
	OffBar..{ Name="OffsetBar", OnCommand=function(s) s:y( -32 ) end },
};


return t;
