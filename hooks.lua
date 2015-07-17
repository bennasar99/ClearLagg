function OnTick(TimeDelta)
	TimeUntilRemove = TimeToRemove * 20
	ToRemove = TimeUntilRemove - 1200
	if (Time == TimeUntilRemove) then
		Time = 0
		local ForEachEntity = function(Entity)
			if Entity:IsPickup() and RemovePickups == true then
				Entity:Destroy()
				Entities = Entities + 1
			end
			if Entity:IsMob() and RemoveMobs == true then
				Entity:Destroy()
				Entities = Entities + 1
			end
			if Entity:IsProjectile() and RemoveProjectiles == true then
				Entity:Destroy()
				Entities = Entities + 1
			end
		end
		local ForEachWorld = function(World)
			World:ForEachEntity(ForEachEntity)
		end
		cRoot:Get():ForEachWorld(ForEachWorld)
		cRoot:Get():BroadcastChatSuccess("Removed "..Entities.." entities")
		Entities = 0
	elseif (Time == ToRemove) then
		cRoot:Get():BroadcastChatInfo("Ground items will be removed in 1 minute!")
		Time = Time + 1
	else
		Time = Time + 1
	end
end

function OnSpawningMonster(World, Monster)
	family = Monster:GetMobFamily()
	local ForEachEntityInChunk = function(Entity)
		if Entity:IsMob() then
			MobsInChunk = MobsInChunk + 1
		end
	end
	local ForEachEntity = function(Entity)
		if Entity:IsMob() then
			Monster = tolua.cast(Entity,"cMonster")
			if Monster:GetMobFamily() == family then
				Mobs = Mobs + 1
			end
		end
	end
	World:ForEachEntityInChunk(Monster:GetChunkX(), Monster:GetChunkZ(), ForEachEntityInChunk)
	World:ForEachEntity(ForEachEntity)
	if MobsInChunk >= MaxMobsInChunk then
		MobsInChunk = 0
		Mobs = 0
		return true
	elseif family == 0 and Mobs >= Monsters then
		MobsInChunk = 0
		Mobs = 0
		return true
	elseif family == 1 and Mobs >= Passive then
		MobsInChunk = 0
		Mobs = 0
		return true
	elseif family == 2 and Mobs >= Ambient then
		MobsInChunk = 0
		Mobs = 0
		return true
	elseif family == 3 and Mobs >= Water then
		MobsInChunk = 0
		Mobs = 0
		return true
	end
end
