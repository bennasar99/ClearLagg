function HandleLaggClearCommand(Split, Player)
    if Split[2] == nil then
        Player:SendMessage("Usage: /lagg [clear/check/killmobs/info/unloadchunks]")
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
    elseif Split[2] == "info" then
        Root = cRoot:Get()
        ramusage = cRoot:GetPhysicalRAMUsage() / 1024
        swapusage = cRoot:GetVirtualRAMUsage() / 1204
        totalusage = ramusage + swapusage
        Player:SendMessage("Physical RAM use: "..ramusage.." mb")
        Player:SendMessage("Virtual RAM use: "..swapusage.." mb")
        Player:SendMessage("Total RAM use: "..totalusage.." mb")
        Player:SendMessage("Current loaded chunks: "..Root:GetTotalChunkCount())
        return true
    elseif Split[2] == "unloadchunks" then
        World = Player:GetWorld()
        Root = cRoot:Get()
        playername = Player:GetName()
        ramusage = cRoot:GetPhysicalRAMUsage() / 1024
        swapusage = cRoot:GetVirtualRAMUsage() / 1204
        totalusage = ramusage + swapusage
        local Out1 = "Num loaded chunks before: " .. cRoot:Get():GetTotalChunkCount()
        local Out2 = "Ram usage before: " .. totalusage
        Root:SaveAllChunks()
        local UnloadChunks = function(World)
            World:QueueUnloadUnusedChunks()
        end
        local QuequeLoopWorlds = function(World)
            cRoot:Get():ForEachWorld(UnloadChunks)
        end
        local TellPlayer = function(Player)
            afterramusage = cRoot:GetPhysicalRAMUsage() / 1024
            afterswapusage = cRoot:GetVirtualRAMUsage() / 1024
            aftertotalusage = afterramusage + afterswapusage
            Out3 = "Num loaded chunks after: " .. cRoot:Get():GetTotalChunkCount()
            Out4 = "Ram usage after: " .. aftertotalusage
            Player:SendMessage(Out1)
            Player:SendMessage(Out2)
            Player:SendMessage(Out3)
            Player:SendMessage(Out4)
        end
        local LoopTellPlayer = function(Player)
            World:FindAndDoWithPlayer(playername, TellPlayer)
        end
        World:ScheduleTask(100, QuequeLoopWorlds)
        World:ScheduleTask(200, LoopTellPlayer)
        Player:SendMessage("Unloading... Please wait a moment")
        return true
    end
end
        
