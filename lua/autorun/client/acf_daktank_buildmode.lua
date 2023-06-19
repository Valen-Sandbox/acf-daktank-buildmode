net.Receive( "ACF_BuildmodeNotif", function()
    local isACF, dmgType = net.ReadBool(), ""
    if isACF then
        dmgType = "ACF"
    else
        dmgType = "DakTank"
    end

    surface.PlaySound( "buttons/button10.wav" )
    notification.AddLegacy( "You are in buildmode and cannot deal " .. dmgType .. " damage!", NOTIFY_ERROR, 2 )
end )