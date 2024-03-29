function SongMeterDisplayX(pn)
	return pn == PLAYER_1 and SCREEN_LEFT+16 or SCREEN_RIGHT-16
end

function SongMeterDisplayY(pn)
	return Center1Player() and SCREEN_TOP+50 or SCREEN_CENTER_Y
end

function SongMeterDisplayCommand(pn)
	if Center1Player() then
		return cmd(draworder,50;zoom,0;y,SCREEN_TOP-24;sleep,1.5;decelerate,0.5;zoom,1;y,SCREEN_TOP+50)
	else
		local xAdd = (pn == PLAYER_1) and -24 or 24
		return cmd(draworder,5;rotationz,-90;zoom,0;addx,xAdd;sleep,1.5;decelerate,0.5;zoom,1;addx,xAdd*-1)
	end
end

function SSMSongLocText( actor )
   Trace( "SSMSongLocText" )
   local song = GAMESTATE:GetCurrentSong();
   local text = ""
   if song then
	local fulldir = song:GetSongDir();
	local short = string.sub(fulldir, 8, -2);
	local shorter = string.sub(short,1,5);
	if shorter == "n The" then
		short = "Memory Card"..string.sub(fulldir, 22, -2);
	end
	text = short
   end
   if actor then
	actor:settext( text )
	end
end
