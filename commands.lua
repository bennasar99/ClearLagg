function HandleLaggClearCommand(Split, Player)
    if Split[2] == nil then
        Player:SendMessage("Usage: /lagg [clear/check/killmobs]")
        return true
    elseif Split[2] == "clear" then
        Time = TimeUntilRemove - 1
        return true
    elseif Split[2] == "check" then
       local ForEachEntity = function(Entity)
            if Entity:IsPickup() then
                Pickups = Pickups + 1
            elseif Entity:IsMob() then
                Mobs = Mobs + 1
            elseif Entity:IsProjectile() then
                Projectiles = Projectiles + 1
            end
        end
        local ForEachWorld = function(World)
            World:ForEachEntity(ForEachEntity)
        end
        cRoot:Get():ForEachWorld(ForEachWorld)
        Player:SendMessage("Counted "..Pickups.." pickups, "..Mobs.." mobs, and "..Projectiles.." projectiles")
        Pickups = 0
        Mobs = 0
        Projectiles = 0
        return true
    elseif Split[2] == "killmobs" then
       local ForEachEntity = function(Entity)
            if Entity:IsMob() then
                Entity:Destroy()
                Mobs = Mobs + 1
            end
        end
        local ForEachWorld = function(World)
            World:ForEachEntity(ForEachEntity)
        end
        cRoot:Get():ForEachWorld(ForEachWorld)
        Player:SendMessage("Killed "..Mobs.." mobs")
        Mobs = 0
        return true
    end
end
        
