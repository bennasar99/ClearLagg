ClearLagg
=========

ClearLagg clone for MCServer

**Features**
- Clear all entities (configurable time)
- Limit mobs

**Commands/Permisions**
/lagg   clearlagg.lagg

/lagg clear (clears all entities)

/lagg check (counts entities)

/lagg killmobs (kills all mobs)

**Settings(settings.lua)**
--GENERAL--

TimeToRemove = 300       - Time until clearing all entities (in seconds, default 5 minutes)

RemovePickups = true     - If true, pickups will be cleared

RemoveProjectiles = true - If true, projectiles will be cleared

RemoveMobs = false       - If true, all mobs will be removed

--MOBLIMITER--
MaxMobsInChunk = 6       - Max mobs in the same chunk

Monsters = 100           - Max monsters in world

Passive = 50             - Max passive mobs in world

Ambient = 15             - Max ambient mobs in world

Water = 15               - Max water mobs in world

