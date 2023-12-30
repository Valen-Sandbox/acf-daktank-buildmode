local IsValid = IsValid

util.AddNetworkString( "ACF_BuildmodeNotif" )

hook.Add( "ACF_PreDamageEntity", "ACF_BuildmodeIntegration", function( entity, _, dmgInfo )
    if not IsValid( entity ) then return end

    local entOwner = entity:CPPIGetOwner()
    local attacker = dmgInfo:GetAttacker()
    if not IsValid( entOwner ) or not IsValid( attacker ) then return end

    local entOwnerBuild = entOwner:GetNWBool( "_Kyle_Buildmode", false )
    local attackerBuild = attacker:GetNWBool( "_Kyle_Buildmode", false )

    if entOwnerBuild then return false end
    if attackerBuild then
        net.Start( "ACF_BuildmodeNotif" )
        net.WriteBool( true )
        net.Send( attacker )

        return false
    end
end )

local function preventExplosions( entity )
    if not IsValid( entity ) then return end

    local entOwner = entity:CPPIGetOwner()
    if not IsValid( entOwner ) then return end

    local entOwnerBuild = entOwner:GetNWBool( "_Kyle_Buildmode", false )
    if entOwnerBuild then return false end
end
hook.Add( "ACF_AmmoExplode", "ACF_BuildmodeIntegration_BuilderAmmo", preventExplosions )
hook.Add( "ACF_FuelExplode", "ACF_BuildmodeIntegration_BuilderFuel", preventExplosions )

hook.Add( "DakTankDamageCheck", "DakTank_BuildmodeIntegration", function( hitEnt, shellOwner, shell )
    if not IsValid( hitEnt ) or not IsValid( shellOwner ) or not IsValid( shell ) then return end

    local entOwner = hitEnt:CPPIGetOwner()
    if not IsValid( entOwner ) then return end

    local entOwnerBuild = entOwner:GetNWBool( "_Kyle_Buildmode", false )
    local attackerBuild = shellOwner:GetNWBool( "_Kyle_Buildmode", false )

    if entOwnerBuild then return false end
    if attackerBuild then
        net.Start( "ACF_BuildmodeNotif" )
        net.WriteBool( false )
        net.Send( attacker )

        return false
    end
end )