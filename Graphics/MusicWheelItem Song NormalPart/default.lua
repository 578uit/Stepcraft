local sBannerPath = THEME:GetPathG("Common", "fallback jacket");
local sJacketPath = THEME:GetPathG("Common", "fallback jacket");
local bAllowJackets = true
local song;
local group;
local getOn = 0;
local getOff = 0;

centerObjectProxy = nil;

--main backing
local t = Def.ActorFrame {


	Def.Quad{
		InitCommand=function(self) self:setsize(300,96):diffuse(color("#00000090")) end,
	},
--banner
	Def.Sprite {
		Name="Banner";
		InitCommand=function(self) self:scaletoclipped(72,72):x(-100) end,
		--[[BannerCommand=cmd(scaletoclipped,128,128);
		JacketCommand=cmd(scaletoclipped,128,128);]]
		SetMessageCommand=function(self,params)
			local Song = params.Song;
			local Course = params.Course;
			if Song then
				if params.HasFocus then
					centerObjectProxy = self;
				end;
				if ( Song:GetJacketPath() ~=  nil ) and ( bAllowJackets ) then
					self:Load( Song:GetJacketPath() );
					--self:playcommand("Jacket");
				elseif ( Song:GetBackgroundPath() ~= nil ) and ( bAllowJackets ) then
					self:Load( Song:GetBackgroundPath() );
					--self:playcommand("Jacket");
				elseif ( Song:GetBannerPath() ~= nil ) then
					self:Load( Song:GetBannerPath() );
					--self:playcommand("Banner");
				else
				  self:Load( bAllowJackets and sBannerPath or sJacketPath );
				  --self:playcommand( bAllowJackets and "Jacket" or "Banner" );
				end;
			elseif Course then
				if ( Course:GetBackgroundPath() ~= nil ) and ( bAllowJackets ) then
					self:Load( Course:GetBackgroundPath() );
					--self:playcommand("Jacket");
				elseif ( Course:GetBannerPath() ~= nil ) then
					self:Load( Course:GetBannerPath() );
					--self:playcommand("Banner");
				else
					self:Load( sJacketPath );
					--self:playcommand( bAllowJackets and "Jacket" or "Banner" );
				end
			else
				self:Load( bAllowJackets and sJacketPath or sBannerPath );
				--self:playcommand( bAllowJackets and "Jacket" or "Banner" );
			end;
		end;
	};
--new song
	LoadFont("_minecraft 14px") .. {
		InitCommand=function(self) self:x(-100):y(-30):finishtweening():draworder(100):zoom(0.8) end,
		OnCommand=function(self)
			local Colors = {
				"#FF3C23",
				"#FF003C",
				"#C1006F",
				"#8200A1",
				"#413AD0",
				"#0073FF",
				"#00ADC0",
				"#5CE087",
				"#AEFA44",
				"#FFFF00",
				"#FFBE00",
				"#FF7D00"
			},
			self:settext("New Song!")
			self:diffuse(color(Colors[math.random(1, #Colors)]))
		end;
		SetCommand=function(self,param)
			if param.Song then
				if PROFILEMAN:IsSongNew(param.Song) then
					self:visible(true);
				else
					self:visible(false);
				end
			else
				self:visible(false);
			end
		end;
	};
};

--if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
--	t[#t+1] = LoadActor("diff.lua",PLAYER_1)..{
--		InitCommand=cmd(xy,-61,-85);
--	}
--end;

--if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
--	t[#t+1] = LoadActor("diff.lua",PLAYER_2)..{
--		InitCommand=cmd(xy,61,-85);
--	}
--end;

return t;
