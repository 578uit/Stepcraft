local t = Def.ActorFrame{
	OnCommand=function(self)
		if IsUsingWideScreen() then
			self:zoom(0.7655)
			self:xy(_screen.cx - 170, 112)
		else
			self:zoom(0.75)
			self:xy(_screen.cx - 166, 112)
		end
	end,
}
return t
