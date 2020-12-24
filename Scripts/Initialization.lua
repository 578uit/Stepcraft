-- Initialization for Simply Love theme by quietly-turning
-- This allows me to do many customizations that suit with players' preferences :))

local PlayerDefaults = {
	__index = {
		initialize = function(self)
			self.ActiveModifiers = {
				JudgmentGraphic = "Minecraft 2x6.png",
				ComboFont = "Minecraft",
				HoldJudgment = "Minecraft 1x2.png",
				Protiming = "Off",
			}
			self.Streams = {
				SongDir = nil,
				StepsType = nil,
				Difficulty = nil,
				Measures = nil,
			}
			self.HighScores = {
				EnteringName = false,
				Name = ""
			}
			self.Stages = {
				Stats = {}
			}
			self.PlayerOptionsString = nil
		end
	}
}

local GlobalDefaults = {
	__index = {

		-- since the initialize() function is called every game cycle, the idea
		-- is to define variables we want to reset every game cycle inside
		initialize = function(self)
			self.ActiveModifiers = {
				TimingWindows = {true, true, true, true, true},
			}
			self.Stages = {
				PlayedThisGame = 0,
				Remaining = PREFSMAN:GetPreference("SongsPerPlay"),
				Stats = {}
			}
			self.TimeAtSessionStart = nil
			self.GameplayReloadCheck = false
			self.GameMode = "Survival"
		end,
	}
}

-- "SL" is a general-purpose table that can be accessed from anywhere
-- within the theme and stores info that needs to be passed between screens
SL = {
	P1 = setmetatable( {}, PlayerDefaults),
	P2 = setmetatable( {}, PlayerDefaults),
	Global = setmetatable( {}, GlobalDefaults),
	Preferences = {
		Creative = {
			TimingWindowAdd=0.0015,
			RegenComboAfterMiss=0,
			MaxRegenComboAfterMiss=0,
			MinTNSToHideNotes="TapNoteScore_W3",
			HarshHotLifePenalty=true,

			PercentageScoring=true,
			AllowW1="AllowW1_Everywhere",
			SubSortByNumSteps=true,

			TimingWindowSecondsW1=0.021500,
			TimingWindowSecondsW2=0.043000,
			TimingWindowSecondsW3=0.102000,
			TimingWindowSecondsW4=0.102000,
			TimingWindowSecondsW5=0.102000,
			TimingWindowSecondsHold=0.320000,
			TimingWindowSecondsMine=0.070000,
			TimingWindowSecondsRoll=0.350000,
		},
		Survival = {
			TimingWindowAdd=0.0015,
			RegenComboAfterMiss=5,
			MaxRegenComboAfterMiss=10,
			MinTNSToHideNotes="TapNoteScore_W3",
			HarshHotLifePenalty=true,

			PercentageScoring=true,
			AllowW1="AllowW1_Everywhere",
			SubSortByNumSteps=true,

			TimingWindowSecondsW1=0.021500,
			TimingWindowSecondsW2=0.043000,
			TimingWindowSecondsW3=0.102000,
			TimingWindowSecondsW4=0.135000,
			TimingWindowSecondsW5=0.180000,
			TimingWindowSecondsHold=0.320000,
			TimingWindowSecondsMine=0.070000,
			TimingWindowSecondsRoll=0.350000,
		},
	},
	Metrics = {
		Creative = {
			PercentScoreWeightW1=3,
			PercentScoreWeightW2=2,
			PercentScoreWeightW3=1,
			PercentScoreWeightW4=0,
			PercentScoreWeightW5=0,
			PercentScoreWeightMiss=0,
			PercentScoreWeightLetGo=0,
			PercentScoreWeightHeld=3,
			PercentScoreWeightHitMine=-1,

			GradeWeightW1=3,
			GradeWeightW2=2,
			GradeWeightW3=1,
			GradeWeightW4=0,
			GradeWeightW5=0,
			GradeWeightMiss=0,
			GradeWeightLetGo=0,
			GradeWeightHeld=3,
			GradeWeightHitMine=-1,

			LifePercentChangeW1=0,
			LifePercentChangeW2=0,
			LifePercentChangeW3=0,
			LifePercentChangeW4=0,
			LifePercentChangeW5=0,
			LifePercentChangeMiss=0,
			LifePercentChangeLetGo=0,
			LifePercentChangeHeld=0,
			LifePercentChangeHitMine=0,
		},
		Survival = {
			PercentScoreWeightW1=5,
			PercentScoreWeightW2=4,
			PercentScoreWeightW3=2,
			PercentScoreWeightW4=0,
			PercentScoreWeightW5=-6,
			PercentScoreWeightMiss=-12,
			PercentScoreWeightLetGo=0,
			PercentScoreWeightHeld=5,
			PercentScoreWeightHitMine=-6,

			GradeWeightW1=5,
			GradeWeightW2=4,
			GradeWeightW3=2,
			GradeWeightW4=0,
			GradeWeightW5=-6,
			GradeWeightMiss=-12,
			GradeWeightLetGo=0,
			GradeWeightHeld=5,
			GradeWeightHitMine=-6,

			LifePercentChangeW1=0.008,
			LifePercentChangeW2=0.008,
			LifePercentChangeW3=0.004,
			LifePercentChangeW4=0.000,
			LifePercentChangeW5=-0.050,
			LifePercentChangeMiss=-0.100,
			LifePercentChangeLetGo=IsGame("pump") and 0.000 or -0.080,
			LifePercentChangeHeld=IsGame("pump") and 0.000 or 0.008,
			LifePercentChangeHitMine=-0.050,
		},
	},
}

function InitializeSimplyLove()
	SL.P1:initialize()
	SL.P2:initialize()
	SL.Global:initialize()
end

InitializeSimplyLove()