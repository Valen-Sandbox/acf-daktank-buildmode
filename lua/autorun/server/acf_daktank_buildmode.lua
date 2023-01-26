local hook_Add = hook.Add
local IsValid = IsValid

hook_Add( "ACF_PreDamageEntity", "ACF_BuildmodeIntegration", function( entity, dmgResult, dmgInfo )
    if not IsValid( entity ) then return end

    local entOwner = entity:CPPIGetOwner()
    local attacker = dmgInfo:GetAttacker()
    if not IsValid( entOwner and attacker ) then return end

    local entOwnerBuild = entOwner:GetNWBool( "_Kyle_Buildmode", false )
    local attackerBuild = attacker:GetNWBool( "_Kyle_Buildmode", false )
    if entOwnerBuild or attackerBuild then return false end
end )

hook_Add( "DakTankDamageCheck", "DakTank_BuildmodeIntegration", function( hitEnt, shellOwner, shell )
    if not IsValid( hitEnt and shellOwner and shell ) then return end

    local entOwner = hitEnt:CPPIGetOwner()
    if not IsValid( entOwner ) then return end

    local entOwnerBuild = entOwner:GetNWBool( "_Kyle_Buildmode", false )
    local attackerBuild = shellOwner:GetNWBool( "_Kyle_Buildmode", false )
    if entOwnerBuild or attackerBuild then return false end
end )