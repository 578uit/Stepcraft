function DifficultyName( name, pn )
	local ToGet = {
	["Steps"] = GAMESTATE:GetCurrentSteps(pn),
	["Trail"] = GAMESTATE:GetCurrentTrail(pn),
	}

	if ToGet[name] then
		local Shorten = ToEnumShortString( ToGet[name]:GetDifficulty() )
		return THEME:GetString("Difficulty", Shorten)
	end
end

function SetFrameDifficulty( pn )
	if GAMESTATE:GetCurrentSteps(pn) then
		local steps = GAMESTATE:GetCurrentSteps(pn):GetDifficulty();
		local DifficultyToSet = 0;
		if steps == "Difficulty_Beginner" then DifficultyToSet = 0; end
		if steps == "Difficulty_Easy" then DifficultyToSet = 1; end
		if steps == "Difficulty_Medium" then DifficultyToSet = 2; end
		if steps == "Difficulty_Hard" then DifficultyToSet = 3; end
		if steps == "Difficulty_Challenge" then DifficultyToSet = 4; end
		if steps == "Difficulty_Edit" then DifficultyToSet = 5; end
		return DifficultyToSet
	else
		return 0
	end
end

-- Get Specific Tap Note Score for Normal Evaluation
function GetPSStageStats( pn ) return STATSMAN:GetCurStageStats():GetPlayerStageStats(pn) end

function CalculatePercentage( pn )
	local CalcPerNames = STATSMAN:GetCurStageStats()

    if GAMESTATE:IsPlayerEnabled(pn) then
        local GPSS = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn);
        local ScoreToCalculate = GPSS:GetActualDancePoints()/GPSS:GetPossibleDancePoints()

        if ScoreToCalculate > 0 then
            return FormatPercentScore( ScoreToCalculate )
        else
            return " 0.00%"
        end
        
    else
        return " "
    end
end

function CalPerNum(pn)
	if GAMESTATE:IsPlayerEnabled(pn) then
        local GPSS = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn);
        local ScoreToCalculate = GPSS:GetActualDancePoints()/GPSS:GetPossibleDancePoints()

        return ScoreToCalculate
	end
	return 0
end