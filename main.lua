--Variables--
Time = 0
Entities = 0
Pickups = 0
Mobs = 0
Projectiles = 0
MobsInChunk = 0

function Initialize(Plugin)
	Plugin:SetName("ClearLagg")
	Plugin:SetVersion(0)
	
	cPluginManager.BindCommand( "/lagg",          "clearlagg.clear",      HandleLaggClearCommand,   "- Remove entities and unload chunks." )

	cPluginManager.AddHook(cPluginManager.HOOK_TICK, OnTick)
	cPluginManager.AddHook(cPluginManager.HOOK_SPAWNING_MONSTER, OnSpawningMonster)

	LOG("Initialized " .. Plugin:GetName() .. " v." .. Plugin:GetVersion())
	
	return true
end


