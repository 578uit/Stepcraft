local t = Def.ActorFrame{
	InitCommand=function(self)
		self:x(_screen.cx - WideScale(30,40))
	end
}

local rows_with_proxies = { "NoteSkin", "JudgmentGraphic", "ComboFont", "HoldJudgment" }

for player in ivalues( GAMESTATE:GetHumanPlayers() ) do
	local pn = ToEnumShortString(player)

	t[#t+1] = Def.ActorProxy{
		Name="OptionRowProxy" ..pn,
		OnCommand=function(self)
			local optrow = self:GetParent():GetParent():GetParent()

			if FindInTable(optrow:GetName(), rows_with_proxies) then
				-- if this OptionRow needs an ActorProxy for preview purposes, set the necessary parameters
				self:x(player==PLAYER_1 and WideScale(20, 0) or WideScale(220, 240)):zoom(0.4)
					:diffusealpha(0):sleep(0.2):diffusealpha(1)
			else
				-- if this OptionRow doesn't need an ActorProxy, don't draw it and save processor cycles
				self:hibernate(math.huge)
			end
		end,
		-- NoteSkinChanged is broadcast by the SaveSelections() function for the NoteSkin OptionRow definition
		-- in ./Scripts/SL-PlayerOptions.lua
		NoteSkinChangedMessageCommand=function(self, params)
			local optrow = self:GetParent():GetParent():GetParent()

			if optrow and optrow:GetName() == "NoteSkin" and player == params.Player then
				-- attempt to find the hidden NoteSkin actor added by ./BGAnimations/ScreenPlayerOptions overlay.lua
				local noteskin_actor = SCREENMAN:GetTopScreen():GetChild("Overlay"):GetChild("NoteSkin_"..params.NoteSkin)
				-- ensure that that NoteSkin actor exists before attempting to set it as the target of this ActorProxy
				if noteskin_actor then self:SetTarget( noteskin_actor ) end
			end
		end,
		JudgmentGraphicChangedMessageCommand=function(self, params)
			local optrow = self:GetParent():GetParent():GetParent()

			if optrow and optrow:GetName() == "JudgmentGraphic" and player == params.Player then
				local judgment_sprite = SCREENMAN:GetTopScreen():GetChild("Overlay"):GetChild("JudgmentGraphic_"..params.JudgmentGraphic)
				if judgment_sprite then self:SetTarget( judgment_sprite ) end
			end
		end,
		ComboFontChangedMessageCommand=function(self, params)
			local optrow = self:GetParent():GetParent():GetParent()

			if optrow and optrow:GetName() == "ComboFont" and player == params.Player then
				local combofont_bmt = SCREENMAN:GetTopScreen():GetChild("Overlay"):GetChild(pn.."_ComboFont_"..params.ComboFont)
				if combofont_bmt then self:SetTarget( combofont_bmt ) end
			end
		end,
		HoldJudgmentChangedMessageCommand=function(self, params)
			if player ~= params.Player then return end

			local optrow = self:GetParent():GetParent():GetParent()

			if optrow and optrow:GetName() == "HoldJudgment" then
				local hj_sprite = SCREENMAN:GetTopScreen():GetChild("Overlay"):GetChild("HoldJudgment_"..params.HoldJudgment)
				if hj_sprite then self:SetTarget( hj_sprite ) end
			end
		end
	}
end

return t