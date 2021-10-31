local evalsong = ThemePrefs.Get("BetterEvaluationScreen")

local file = "dog"

if not evalsong then file = "dog" else 
	if GAMESTATE:IsCourseMode() then return end
    local song = GAMESTATE:GetCurrentSong()

    if song then
        file = song:GetMusicPath()
    end
end

return file