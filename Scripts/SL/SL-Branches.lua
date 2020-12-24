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