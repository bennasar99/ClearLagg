ClearLagg
=========

Reduce lag on your Cuberite server by automatically removing entities and unloading chunks.

### Features

- Clear all entities (configurable time)

- Limit mobs

- Unload unused chunks

### Commands

| Command | Permission | Description |
| ------- | ---------- | ----------- |
|/lagg | clearlagg.lagg | Use the /lagg command.|
|/lagg clear | clearlagg.lagg | Clears all entities on the server.|
|/lagg check | clearlagg.lagg | Shows the amount of entities on the server.|
|/lagg killmobs | clearlagg.lagg | Kills all mobs on the server.|
|/lagg info | clearlagg.lagg | Shows information about the server.|
|/lagg unloadchunks | clearlagg.lagg | Unloads unused chunks.|

### Settings (settings.lua)

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
