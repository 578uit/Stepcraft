function SMOnlineScreen()
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		if not IsSMOnlineLoggedIn(pn) then
			return "ScreenSMOnlineLogin"
		end
	end
	return "ScreenNetRoom"
end

function SelectMusicOrCourse()
	if IsNetSMOnline() then
		return "ScreenNetSelectMusic"
	elseif GAMESTATE:IsCourseMode() then
		return "ScreenSelectCourse"
	else
		return "ScreenSelectMusic"
	end
end

if not Branch then Branch = {} end

Branch.SSMCancel = function()

	if GAMESTATE:GetCurrentStageIndex() > 0 then
		return Branch.AllowScreenEvalSummary()
	end

	return Branch.TitleMenu()
end

Branch.AllowScreenEvalSummary = function()
	return "ScreenEvaluationSummary"
end

Branch.AfterSelectStyle = function()
	if IsNetConnected() then
		ReportStyle()
		GAMESTATE:ApplyGameCommand("playmode,regular")
	end
	if IsNetSMOnline() then
		return SMOnlineScreen()
	end
	if IsNetConnected() then
		return "ScreenNetRoom"
	end
	return "ScreenSelectMusic"

	--return CHARMAN:GetAllCharacters() ~= nil and "ScreenSelectCharacter" or "ScreenGameInformation"
end

Branch.EvaluationScreen= function()
	if IsNetSMOnline() then
		return "ScreenNetEvaluation"
	else
		-- todo: account for courses etc?
		return "ScreenEvaluationNormal"
	end
end