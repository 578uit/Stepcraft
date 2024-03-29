local c;
local player = Var "Player";
local ShowComboAt = THEME:GetMetric("Combo", "ShowComboAt");
local Pulse = THEME:GetMetric("Combo", "PulseCommand");
local PulseLabel = THEME:GetMetric("Combo", "PulseLabelCommand");

local FullComboGreats = THEME:GetMetric("Combo", "FullComboGreatsCommand");
local FullComboPerfects = THEME:GetMetric("Combo", "FullComboPerfectsCommand");
local FullComboMarvelouses = THEME:GetMetric("Combo", "FullComboMarvelousesCommand");

local NumberMinZoom = THEME:GetMetric("Combo", "NumberMinZoom");
local NumberMaxZoom = THEME:GetMetric("Combo", "NumberMaxZoom");
local NumberMaxZoomAt = THEME:GetMetric("Combo", "NumberMaxZoomAt");

local LabelMinZoom = THEME:GetMetric("Combo", "LabelMinZoom");
local LabelMaxZoom = THEME:GetMetric("Combo", "LabelMaxZoom");

local comboType = SL[ToEnumShortString(player)].ActiveModifiers.ComboFont or "Minecraft";
local path = THEME:GetPathG("","combofonts");

local files = FILEMAN:GetDirListing(path .. "/");
local cfont_exists = false;
for i,filename in ipairs(files) do
	if string.match(filename, " %dx%d") then
		local name = filename:gsub(" %dx%d", ""):gsub(" %(doubleres%)", ""):gsub(".png", "")
		if comboType == name then
			cfont_exists = true
			break
		end
	else
		table.remove(files,i)
	end
end

local t = Def.ActorFrame {
	InitCommand=function(self)
		self:vertalign(bottom)
	end;
	-- load the combo milestones actors into the Player combo; they will
	-- listen for the appropriate Milestone command from the engine
    LoadActor("explosion.png")..{
		InitCommand=function(self)
			self:diffusealpha(0):blend("BlendMode_Add")
		end;
		HundredMilestoneCommand=function(self)
			self:rotationz(0):zoom(2.6):diffusealpha(0.5):linear(0.5):rotationz(90):zoom(2):diffusealpha(0)
		end;
	},

	LoadActor("firework.png")..{
		InitCommand=function(self) self:diffusealpha(0) end,
		HundredMilestoneCommand=function(self)
			self:finishtweening():diffuse(color(ThemePrefs.Get("ComboFireworkColor"))):rotationz(10):zoom(0.05):diffusealpha(1)
				:decelerate(1.5):rotationz(120):zoom(1.5):diffusealpha(0)
		end,
	},

	-- 1000 Combo milestone
	LoadActor("explosion.png")..{
		InitCommand=function(self)
			self:diffusealpha(0):blend("BlendMode_Add")
		end;
		ThousandMilestoneCommand=function(self)
			self:rotationz(0):zoom(2.6):diffusealpha(0.5):linear(0.5):rotationz(90):zoom(2):diffusealpha(0)
		end;
	},

	LoadActor("firework.png")..{
		InitCommand=function(self) self:diffusealpha(0) end,
		ThousandMilestoneCommand=function(self)
			self:finishtweening():diffuse(color(ThemePrefs.Get("ComboFireworkColor"))):zoom(0.05):diffusealpha(1):x(0)
				:linear(1.5):zoom(2.7):rotationz(-180):diffusealpha(0)
		end,
	},
	LoadActor("firework.png")..{
		InitCommand=function(self) self:diffusealpha(0) end,
		ThousandMilestoneCommand=function(self)
			self:finishtweening():diffuse(color(ThemePrefs.Get("ComboFireworkColor"))):rotationz(10):zoom(0.05):diffusealpha(1)
				:decelerate(1.5):rotationz(120):zoom(1.5):diffusealpha(0)
		end,
	},
	LoadFont( "_combofonts/" .. comboType .. "/" .. comboType ) .. {
		Name="Number";
		OnCommand = THEME:GetMetric("Combo", "NumberOnCommand");
		BeginCommand=function(self)
			self:y(35)
		end;
	};
	LoadFont( "_minecraft 14px" ) .. {
		Name="Label";
		Text="Combo";
		OnCommand = THEME:GetMetric("Combo", "LabelOnCommand");
		BeginCommand=function(self)
			self:y(35)
		end;
	};
	LoadFont( "_minecraft 14px" ) .. {
		Name="Misses";
		Text="Misses";
		OnCommand = THEME:GetMetric("Combo", "LabelOnCommand");
		BeginCommand=function(self)
			self:y(35)
		end;
	};



	
	InitCommand = function(self)
		c = self:GetChildren();
		c.Number:visible(false);
		c.Label:visible(false);
		c.Misses:visible(false);
	end;
	-- Milestones:
	-- 25,50,100,250,600 Multiples;
--[[ 		if (iCombo % 100) == 0 then
			c.OneHundredMilestone:playcommand("Milestone");
		elseif (iCombo % 250) == 0 then
			-- It should really be 1000 but thats slightly unattainable, since
			-- combo doesnt save over now.
			c.OneThousandMilestone:playcommand("Milestone");
		else
			return
		end; --]]
	ComboCommand=function(self, param)
		local iCombo = param.Misses or param.Combo;
		if not iCombo or iCombo < ShowComboAt then
			c.Number:visible(false);
			c.Number:y(35);
			c.Label:visible(false);
			c.Label:y(35);
			c.Misses:y(35);
			c.Number:x(-5);
			c.Label:x(-5);
			c.Misses:x(-5);
			return;
		end

		c.Label:visible(false);

		param.Zoom = scale( iCombo, 0, NumberMaxZoomAt, NumberMinZoom, NumberMaxZoom );
		param.Zoom = clamp( param.Zoom, NumberMinZoom, NumberMaxZoom );
		
		param.LabelZoom = scale( iCombo, 0, NumberMaxZoomAt, LabelMinZoom, LabelMaxZoom );
		param.LabelZoom = clamp( param.LabelZoom, LabelMinZoom, LabelMaxZoom );
		
		c.Number:visible(true);
		c.Label:visible(true);
		c.Number:settext( string.format("%01d", iCombo) );
		-- FullCombo Rewards
		if param.FullComboW1 then
			c.Number:diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#94EBFE")):effectperiod(0.5);
			c.Label:diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#94EBFE")):effectperiod(0.5);
		elseif param.FullComboW2 then
			c.Number:diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#FDD599")):effectperiod(0.5);
			c.Label:diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#FDD599")):effectperiod(0.5);
		elseif param.FullComboW3 then
			c.Number:diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#22FF00")):effectperiod(0.5);
			c.Label:diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#22FF00")):effectperiod(0.5);
		elseif param.Combo then
			c.Number:diffuse(Color("White"));
			c.Number:stopeffect();
			c.Label:stopeffect();
			c.Misses:visible(false);
			c.Label:diffuse(Color("White"));
		else
			c.Number:diffuse(color("#ff0000"));
			c.Label:visible(false);
			c.Number:stopeffect();
			c.Label:stopeffect();
			c.Misses:visible(true);
			c.Misses:diffuse(color("#ff0000"));
		end

		c.Number:finishtweening();
		c.Label:finishtweening();
		-- Pulse
		Pulse( c.Number, param );
		PulseLabel( c.Label, param );
		PulseLabel( c.Misses, param );
		-- Milestone Logic
	end;
};

return t;
