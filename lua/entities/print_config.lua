concommand.Add( "printer_a", function( ply, cmd, args )
if(SERVER)then
if(ply:IsAdmin())then
	file.Write( "Printer_A.txt", args[1] )
	print("Printer A => ".. args[1] .. "$")
end	
end
end )

concommand.Add( "printer_b", function( ply, cmd, args )
if(SERVER)then
if(ply:IsAdmin())then
	file.Write( "Printer_B.txt", args[1] )
	print("Printer B => ".. args[1] .. "$")
end
end
end )

concommand.Add( "printer_c", function( ply, cmd, args )
if(SERVER)then
if(ply:IsAdmin())then
	file.Write( "Printer_C.txt", args[1] )
	print("Printer C => ".. args[1] .. "$")
end
end
end )

concommand.Add( "printers", function( ply, cmd, args )
if(SERVER)then

	local a = file.Read( "Printer_A.txt", "DATA" )
	local b = file.Read( "Printer_B.txt", "DATA" )
	local c = file.Read( "Printer_C.txt", "DATA" )
	if(a == nil)then
	a = 30
	end
	if(b == nil)then
	b = 40
	end
	if(c == nil)then
	c = 60
	end
	print("Printer A => ".. a .. "$")
	print("Printer B => ".. b .. "$")
	print("Printer C => ".. c .. "$")
	
end
end )