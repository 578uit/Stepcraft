local evalsong = ThemePrefs.Get("BetterEvaluationScreen")

local file = "dog"

if not evalsong then file = "dog" else file = "_silent" end

return THEME:GetPathS("", file)