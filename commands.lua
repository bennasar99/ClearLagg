function HandleLaggClearCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: /lagg <clear|check|killmobs|info|unloadchunks>")
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
		Player:SendMessageSuccess("Counted "..Pickups.." pickups, "..Mobs.." mobs, and "..Projectiles.." projectiles")
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
		Player:SendMessageSuccess("Killed "..Mobs.." mobs")
		Mobs = 0
		return true
	elseif Split[2] == "info" then
		Root = cRoot:Get()
		ramusage = cRoot:GetPhysicalRAMUsage() / 1024
		swapusage = cRoot:GetVirtualRAMUsage() / 1204
		totalusage = ramusage + swapusage
		Player:SendMessageInfo("Physical RAM use: "..ramusage.." MB")
		Player:SendMessageInfo("Virtual RAM use: "..swapusage.." MB")
		Player:SendMessageInfo("Total RAM use: "..totalusage.." MB")
		Player:SendMessageInfo("Current loaded chunks: "..Root:GetTotalChunkCount())
		return true
	elseif Split[2] == "unloadchunks" then
		World = Player:GetWorld()
		Root = cRoot:Get()
		playername = Player:GetName()
		ramusage = cRoot:GetPhysicalRAMUsage() / 1024
		swapusage = cRoot:GetVirtualRAMUsage() / 1204
		totalusage = ramusage + swapusage
		local Out1 = "Num loaded chunks before: " .. cRoot:Get():GetTotalChunkCount()
		local Out2 = "RAM usage before: " .. totalusage
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
			Out4 = "RAM usage after: " .. aftertotalusage
			Player:SendMessageInfo(Out1)
			Player:SendMessageInfo(Out2)
			Player:SendMessageInfo(Out3)
			Player:SendMessageInfo(Out4)
		end
		local LoopTellPlayer = function(Player)
			World:FindAndDoWithPlayer(playername, TellPlayer)
		end
		World:ScheduleTask(100, QuequeLoopWorlds)
		World:ScheduleTask(200, LoopTellPlayer)
		Player:SendMessageInfo("Unloading... Please wait a moment")
		return true
	end
end
