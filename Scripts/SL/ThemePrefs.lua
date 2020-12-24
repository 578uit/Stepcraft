local function OptionNameString(str)
	return THEME:GetString('OptionNames',str)
end

local SL_CustomPrefs =
{
	
	ComboUnderField =
	{
		Default = true,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	ShowSongBG =
	{
		Default = true,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	BGBlock =
	{
		Default = "dirt",
		Choices = {
			THEME:GetString("ThemePrefs", "dirt"),
			THEME:GetString("ThemePrefs", "diamond"),
			THEME:GetString("ThemePrefs", "planks"),
			THEME:GetString("ThemePrefs", "tnt"),
			THEME:GetString("ThemePrefs", "cheese"),
			THEME:GetString("ThemePrefs", "piston"),
			THEME:GetString("ThemePrefs", "emerald"),
			"Gold Block", "Iron Block", "Redstone Block",
		},
		Values  = { "dirt", "diamond", "planks", "tnt", "cheese", "piston", "emerald", "gold", "iron", "redstone" },
	},
	SongBGBrightness =
	{
		Default = 0.5,
		Choices = {"100%", "90%", "80%", "70%", "60%", "50%", "40%", "30%", "20%", "10%",},
		Values  = {0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9,},
	},
	ComboFireworkColor =
	{
		Default = "Aqua",
		Choices = {"Aqua", "Red", "Yellow", "Green", "Blue", "Purple", "Pink", "Black", "White",},
		Values  = {"#00F9FF", "#FF0000", "#FDFF00", "#22FF00", "#0045FF", "#9600FF", "#FF97F5", "#000000", "#FFFFFF",},
	},
	FallbackBG =
	{
		Default = "Minecraft",
		Choices = {"Minecraft", "Fighting", "CyberiaStyle", "GrooveNights", "ITG2", "ITG3", "Lambda", "waiei2"},
		Values  = {"Minecraft", "Fighting", "CyberiaStyle", "GrooveNights", "ITG2", "ITG3", "Lambda", "waiei2"},
	},
	BetterEvaluationScreen =
	{
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	Challenge =
	{
		Default = "Off",
		Choices = {"Off", "Freeze"},
		Values = {"Off", "Freeze"}
	},
};
ThemePrefs.InitAll(SL_CustomPrefs)

-- For more information on how this works, read:
-- ./StepMania 5/Docs/ThemerDocs/ThemePrefs.txt
-- ./StepMania 5/Docs/ThemerDocs/ThemePrefsRows.txt

local file = IniFile.ReadFile("Save/ThemePrefs.ini")

-- If a [Simply Love] section is found in ./Save/ThemePrefs.ini
if file["Stepcraft"] then
	-- loop through key/value pairs retrieved and do some basic validation
	for k,v in pairs( file["Stepcraft"] ) do
		if SL_CustomPrefs[k] then
			-- if we reach here, the setting exists in both the master definition as well as the user's ThemePrefs.ini
			-- so perform some rudimentary validation; check for both type mismatch and presence in SL_CustomPrefs
			if type( v ) ~= type( SL_CustomPrefs[k].Default )
			or not FindInTable(v, (SL_CustomPrefs[k].Values or SL_CustomPrefs[k].Choices))
			then
				-- overwrite the user's erroneous setting with the default value
				ThemePrefs.Set(k, SL_CustomPrefs[k].Default)
			end

		-- It's possible a setting exists in the ThemePrefs.ini file, but does
		-- not exist in SL_CustomPrefs, where we define the ThemePrefs for this theme.
		-- If that happens, use the ThemePrefs utility to set that key to a value of nil.
		-- keys with nil values won't be written to disk during Save(), so the problematic
		-- setting will effectively be removed.
		else
			ThemePrefs.Set(k, nil)
		end
	end
end

-- call Save() now; this will create a [Simply Love] section
-- in ./Save/ThemePrefs.ini if one was not found
ThemePrefs.Save()