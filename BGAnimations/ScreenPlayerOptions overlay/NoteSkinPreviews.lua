local t = ...

-- Add noteskin actors to the primary AF and hide them immediately.
-- We'll refer to these later via ActorProxy in ./Graphics/OptionRow Frame.lua
for noteskin in ivalues( CustomOptionRow("NoteSkin").Choices ) do
	t[#t+1] = GetNoteSkinActor(noteskin)
end