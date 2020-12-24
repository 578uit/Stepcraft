local t = Def.ActorFrame{};

if ThemePrefs.Get("ShowSongBG") then
t[#t+1] = Def.ActorFrame{
	Def.Sprite{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y;setsize,SCREEN_WIDTH,SCREEN_HEIGHT;diffusealpha,0.5;);
		OnCommand=cmd(finishtweening;playcommand,"Set");
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
			local mw = SCREENMAN:GetTopScreen():GetChild("MusicWheel")
			if song then
				if song:HasBackground() then
					if song:HasBGChanges() then
						local bg = song:GetSongDir();
						local bgvideo = {}
						local listing = FILEMAN:GetDirListing(bg, false, true)
						if not listing then return nil end
							for _, file in pairs(listing) do
							if ActorUtil.GetFileType(file) == 'FileType_Movie' and not string.match(file, " banner movie") then
								table.insert(bgvideo,file)
							end
						end;
						if song:HasBGChanges() and #bgvideo ~= 0 then
							self:Load(bgvideo[1])
							self:setsize(SCREEN_WIDTH,SCREEN_HEIGHT)
							self:diffusealpha(1)
						else
							self:LoadFromSongBackground(GAMESTATE:GetCurrentSong());
							self:setsize(SCREEN_WIDTH,SCREEN_HEIGHT)
							self:diffusealpha(1)
						end;
					else
						self:LoadFromSongBackground(GAMESTATE:GetCurrentSong());
						self:setsize(SCREEN_WIDTH,SCREEN_HEIGHT)
						self:diffusealpha(1)
					end;
				else
					if song:HasBGChanges() then
						local bg = song:GetSongDir();
						local bgvideo = {}
						local listing = FILEMAN:GetDirListing(bg, false, true)
						if not listing then return nil end
							for _, file in pairs(listing) do
							if ActorUtil.GetFileType(file) == 'FileType_Movie' and not string.match(file, " banner movie") then
								table.insert(bgvideo,file)
							end
						end;
						if song:HasBGChanges() and #bgvideo ~= 0 then
							self:Load(bgvideo[1])
							self:setsize(SCREEN_WIDTH,SCREEN_HEIGHT)
							self:diffusealpha(1)
						else
							self:Load(THEME:GetPathG("","Common fallback background"));
							self:setsize(SCREEN_WIDTH,SCREEN_HEIGHT)
							self:diffusealpha(0)
						end;
					else
						self:Load(THEME:GetPathG("","Common fallback background"));
						self:setsize(SCREEN_WIDTH,SCREEN_HEIGHT)
						self:diffusealpha(0)
					end;
				end;
			elseif mw:GetSelectedType('WheelItemDataType_Section') then
				self:Load(THEME:GetPathG("","Common fallback background"));
				self:setsize(SCREEN_WIDTH,SCREEN_HEIGHT)
				self:diffusealpha(0)
			else
				self:Load(THEME:GetPathG("","Common fallback background"));
				self:setsize(SCREEN_WIDTH,SCREEN_HEIGHT)
				self:diffusealpha(0)
			end;
		end;
    CurrentSongChangedMessageCommand=cmd(stoptweening;queuecommand,"Set");
	};
	Def.Quad {
		InitCommand=cmd(Center;scaletoclipped,SCREEN_WIDTH+1,SCREEN_HEIGHT);
		OnCommand=cmd(diffuse,color("#000000");diffusebottomedge,color("#000000");diffusealpha,ThemePrefs.Get("SongBGBrightness"));
	};
}
end

return t;
