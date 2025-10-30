SERVER_NAME="Dedicated Server"
> Used as the server name
> Allowed values: Any string without semicolon symbol.

GAMEMODE=survival
> Sets the game mode for new players.
> Allowed values: "survival", "creative", or "adventure"

FORCE_GAMEMODE=false
> force-gamemode=false (or force-gamemode is not defined in the server.properties)
> prevents the server from sending to the client gamemode values other
> than the gamemode value saved by the server during world creation
> even if those values are set in server.properties after world creation.
>
> force-gamemode=true forces the server to send to the client gamemode values
> other than the gamemode value saved by the server during world creation
> if those values are set in server.properties after world creation.

DIFFICULTY=easy
> Sets the difficulty of the world.
> Allowed values: "peaceful", "easy", "normal", or "hard"

ALLOW_CHEATS=false
> If true then cheats like commands can be used.
> Allowed values: "true" or "false"

MAX_PLAYERS=10
> The maximum number of players that can play on the server.
> Allowed values: Any positive integer

ONLINE_MODE=true
> If true then all connected players must be authenticated to Xbox Live.
> Clients connecting to remote (non-LAN) servers will always require Xbox Live authentication regardless of this setting.
> If the server accepts connections from the Internet, then it's highly recommended to enable online-mode.
> Allowed values: "true" or "false"

ALLOW_LIST=false
> If true then all connected players must be listed in the separate allowlist.json file.
> Allowed values: "true" or "false"




SERVER_PORT=19132
> Which IPv4 port the server should listen to.
> Allowed values: Integers in the range [1, 65535]

SERVER_PORTV6=19133
> Which IPv6 port the server should listen to.
> Allowed values: Integers in the range [1, 65535]

ENABLE_LAN-VISIBILITY=true
> Listen and respond to clients that are looking for servers on the LAN. This will cause the server
> to bind to the default ports (19132, 19133) even when `server-port` and `server-portv6`
> have non-default values. Consider turning this off if LAN discovery is not desirable, or when
> running multiple servers on the same host may lead to port conflicts.
> Allowed values: "true" or "false"




LEVEL_NAME="Bedrock level"
> Allowed values: Any string without semicolon symbol or symbols illegal for file name: /\n\r\t\f`?*\\<>|\":

LEVEL_SEED=
> Use to randomize the world
> Allowed values: Any string

VIEW_DISTANCE=32
> The maximum allowed view distance in number of chunks.
> Allowed values: Positive integer equal to 5 or greater.

TICK_DISTANCE=4
> The world will be ticked this many chunks away from any player.
> Allowed values: Integers in the range [4, 12]

PLAYER_IDLE_TIMEOUT=30
> After a player has idled for this many minutes they will be kicked. If set to 0 then players can idle indefinitely.
> Allowed values: Any non-negative integer.

MAX_THREADS=8
> Maximum number of threads the server will try to use. If set to 0 or removed then it will use as many as possible.
> Allowed values: Any positive integer.





DEFAULT_PLAYER_PERMISSION_LEVEL=member
> Permission level for new players joining for the first time.
> Allowed values: "visitor", "member", "operator"

TEXTUREPACK_REQUIRED=false
> Force clients to use texture packs in the current world
> Allowed values: "true" or "false"

CONTENT_LOG_FILE_ENABLED=false
> Enables logging content errors to a file
> Allowed values: "true" or "false"

COMPRESSION_TRESHOLD=1
> Determines the smallest size of raw network payload to compress
> Allowed values: 0-65535

COMPRESSION_ALGORITHM=zlib
> Determines the compression algorithm to use for networking
> Allowed values: "zlib", "snappy"

SERVER_AUTHORITATIVE_MOVEMENT_STRICT=false
> Set at true to be more strict toward the Player position and be less permissive in accepting the client info.
> This means clients will receive more position corrections. This will impact Player around moving block if there is high latency

SERVER_AUTHORITATIVE_DISMOUNT_STRICT=false
> Set at true to be more strict toward the Player dismount position.
> This means clients will receive a correction on their dismount position in higher latency situation

SERVER_AUTHORITATIVE_ENTITY_INTERACTIONS_STRICT=false
> Set at true to be more strict toward the Entity interactions.
> This means clients will be more strict towards Entity interactions. This will impact Players interacting with each other in higher latency situations.

PLAYER_POSITION_ACCEPTANCE_THRESHOLD=0.5
> This is the tolerance of discrepancies between the Client and Server Player position. This helps prevent sending corrections too frequently
> for non-cheating players in cases where the server and client have different perceptions about when a motion started. For example damage knockback or being pushed by pistons.
> The higher the number, the more tolerant the server will be before asking for a correction. Values beyond 1.0 have increased chances of allowing cheating.

PLAYER_MOVEMENT_ACTION_DIRECTION_THRESHOLD=0.85
> The amount that the player's attack direction and look direction can differ.
> Allowed values: Any value in the range of [0, 1] where 1 means that the
> direction of the players view and the direction the player is attacking
> must match exactly and a value of 0 means that the two directions can
> differ by up to and including 90 degrees.

SERVER_AUTHORITATIVE_BLOCK_BREAKING_PICK_RANGE_SCALAR=1.5
> If true, the server will compute block mining operations in sync with the client so it can verify that the client should be able to break blocks when it thinks it can.

CHAT_RESTRICTION=None
> Allowed values: "None", "Dropped", "Disabled"
> This represents the level of restriction applied to the chat for each player that joins the server.
> "None" is the default and represents regular free chat.
> "Dropped" means the chat messages are dropped and never sent to any client. Players receive a message to let them know the feature is disabled.
> "Disabled" means that unless the player is an operator, the chat UI does not even appear. No information is displayed to the player.

DISABLE_PLAYER_INTERACTION=false
> If true, the server will inform clients that they should ignore other players when interacting with the world. This is not server authoritative.

CLIENT_SIDE_CHUNK_GENERATION_ENABLED=true
> If true, the server will inform clients that they have the ability to generate visual level chunks outside of player interaction distances.

BLOCK_NETWORK_IDS_ARE_HASHES=true
> If true, the server will send hashed block network ID's instead of id's that start from 0 and go up.  These id's are stable and won't change regardless of other block changes.

DISABLE_PERSONA=false
> Internal Use Only

DISABLE_CUSTOM_SKINS=false
> If true, disable players customized skins that were customized outside of the Minecraft store assets or in game assets.  This is used to disable possibly offensive custom skins players make.

SERVER_BUILD_RADIUS_RATIO=Disabled
> Allowed values: "Disabled" or any value in range [0.0, 1.0]
> If "Disabled" the server will dynamically calculate how much of the player's view it will generate, assigning the rest to the client to build.
> Otherwise from the overridden ratio tell the server how much of the player's view to generate, disregarding client hardware capability.
> Only valid if client-side-chunk-generation-enabled is enabled





ALLOW_OUTBOUND_SCRIPT_DEBUGGING=false
> Allows script debugger 'connect' command and script-debugger-auto-attach=connect mode.

ALLOW_INBOUND_SCRIPT_DEBUGGING=false
> Allows script debugger 'listen' command and script-debugger-auto-attach=listen mode.

SCRIPT_DEBUGGER_AUTO_ATTACH=disabled
> Attempt to attach script debugger at level load, requires that either inbound port or connect address is set and that inbound or outbound connections are enabled.
> "disabled" will not auto attach.
> "connect" server will attempt to connect to debugger in listening mode on the specified port.
> "listen" server will listen to inbound connect attempts from debugger using connect mode on the specified port.





\# FORCE_INBOUND_DEBUG_PORT=19144
> Locks the inbound (listen) debugger port, if not set then default 19144 will be used. Required when using script-debugger-auto-attach=listen mode.

\# SCRIPT_DEBUGGER_AUTO_ATTACH_CONNECT_ADDRESS=localhost:19144
> When auto attach mode is set to 'connect', use this address in the form host:port. Required for script-debugger-auto-attach=connect mode.

\# SCRIPT_DEBUGGER_AUTO_ATTACH_TIMEOUT=0
> Amount of time to wait at world load for debugger to attach.

\# SCRIPT_DEBUGGER_PASSCODE=
> VSCode will prompt user for passcode to connect.

\# SCRIPT_WATCHDOG_ENABLE=true
> Enables the watchdog (default = true).

\# SCRIPT_WATCHDOG_ENABLE_EXCEPTION_HANDLING=true
> Enables watchdog exception handling via the events.beforeWatchdogTerminate event (default = true).

\# SCRIPT_WATCHDOG_ENABLE_SHUTDOWN=true
> Enables server shutdown in the case of an unhandled watchdog exception (default = true).

\# SCRIPT_WATCHDOG_HANG_EXCEPTION=true
> Throws a critical exception when a hang occurs, interrupting script execution (default = true).

\# SCRIPT_WATCHDOG_HANG_TRESHOLD=10000
> Sets the watchdog threshold for single tick hangs (default = 10000 ms).

\# SCRIPT_WATCHDOG_SPIKE_TRESHOLD=100
> Sets the watchdog threshold for single tick spikes.
> Warning is disabled if property left unset.

\# SCRIPT_WATCHDOG_SLOW_TRESHOLD=10
> Sets the watchdog threshold for slow scripts over multiple ticks.
> Warning is disabled if property left unset.

\# SCRIPT_WATCHDOG_MEMORY_WARNING=100
> Produces a content log warning when the combined memory usage exceeds the given threshold (in megabytes).
> Setting this value to 0 disables the warning. (default = 100, max = 2000)

\# SCRIPT_WATCHDOG_MEMORY_LIMIT=250
> Saves and shuts down the world when the combined script memory usage exceeds the given threshold (in megabytes).
> Setting this value to 0 disables the limit. (default = 250, max = 2000)

\# DIAGNOSTICS_CAPTURE_AUTO_START=false
> Starts a diagnostics capture session at level load (default = false)

\# DIAGNOSTICS_CAPTURE_MAX_FILES=5
> Maximum number of diagnostics capture files to keep before cycling. (default = 5)

\# DIAGNOSTICS_CAPTURE_MAX_FILES_SIZE=2097152
> Max size in bytes of current diagnostics capture file before system will cycle to a new file. (default = 2097152, 2mb)

\# DISABLE_CLIENT_VIBRANT_VISUALS=true
> If true, the server will tell clients to use the next best available graphics setting instead of Vibrant Visuals.