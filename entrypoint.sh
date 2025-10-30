#!/bin/sh
set -eu

BEDROCK_DIR="/bedrock"
PROPERTIES_FILE="${BEDROCK_DIR}/server.properties"

echo "[*] Generating server.properties from environment..."

# Clear or create server.properties
> "$PROPERTIES_FILE"

# Main variables required (mandatory)
cat > "$PROPERTIES_FILE" <<EOF
server-name=${SERVER_NAME:-My Bedrock Server}
gamemode=${GAMEMODE:-survival}
force-gamemode=${FORCE_GAMEMODE:-false}
difficulty=${DIFFICULTY:-easy}
allow-cheats=${ALLOW_CHEATS:-false}
max-players=${MAX_PLAYERS:-10}
online-mode=${ONLINE_MODE:-true}
allow-list=${ALLOW_LIST:-false}
server-port=${SERVER_PORT:-19132}
server-portv6=${SERVER_PORTV6:-19133}
enable-lan-visibility=${ENABLE_LAN_VISIBILITY:-true}
level-name=${LEVEL_NAME:-"Za Warudo"}
level-seed=${LEVEL_SEED:-}
view-distance=${VIEW_DISTANCE:-32}
tick-distance=${TICK_DISTANCE:-4}
player-idle-timeout=${PLAYER_IDLE_TIMEOUT:-30}
max-threads=${MAX_THREADS:-8}
default-player-permission-level=${DEFAULT_PLAYER_PERMISSION_LEVEL:-member}
texturepack-required=${TEXTUREPACK_REQUIRED:-false}
content-log-file-enabled=${CONTENT_LOG_FILE_ENABLED:-false}
compression-threshold=${COMPRESSION_THRESHOLD:-1}
compression-algorithm=${COMPRESSION_ALGORITHM:-zlib}
server-authoritative-movement-strict=${SERVER_AUTHORITATIVE_MOVEMENT_STRICT:-false}
server-authoritative-dismount-strict=${SERVER_AUTHORTATIVE_DISMOUNT_STRICT:-false}
server-authoritative-entity-interactions-strict=${SERVER_AUTHORITATIVE_ENTITY_INTERACTIONS_STRICT:-false}
player-position-acceptance-threshold=${PLAYER_POSITION_ACCEPTANCE_THRESHOLD:-0.5}
player-movement-action-direction-threshold=${PLAYER_MOVEMENT_ACTION_DIRECTION_THRESHOLD:-0.85}
server-authoritative-block-breaking-pick-range-scalar=${SERVER_AUTHORITATIVE_BLOCK_BREAKING_PICK_RANGE_SCALAR:-1.5}
chat-restriction=${CHAT_RESTRICTION:-None}
disable-player-interaction=${DISABLE_PLAYER_INTERACTION:-false}
client-side-chunk-generation-enabled=${CLIENT_SIDE_CHUNK_GENERATION_ENABLED:-true}
block-network-ids-are-hashes=${BLOCK_NETWORK_IDS_ARE_HASHES:-true}
disable-persona=${DISABLE_PERSONA:-false}
disable-custom-skins=${DISABLE_CUSTOM_SKINS:-false}
server-build-radius-ratio=${SERVER_BUILD_RADIUS_RATIO:-Disabled}
allow-outbound-script-debugging=${ALLOW_OUTBOUND_SCRIPT_DEBUGGING:-false}
allow-inbound-script-debugging=${ALLOW_INBOUND_SCRIPT_DEBUGGING:-false}
script-debugger-auto-attach=${SCRIPT_DEBUGGER_AUTO_ATTACH:-disabled}
EOF

# Advanced variables (optional)
# Only include if set in .env
[ -n "${FORCE_INBOUND_DEBUG_PORT:-}" ] && echo "force-inbound-debug-port=${FORCE_INBOUND_DEBUG_PORT}" >> "$PROPERTIES_FILE"
[ -n "${SCRIPT_DEBUGGER_AUTO_ATTACH_CONNECT_ADDRESS:-}" ] && echo "script-debugger-auto-attach-connect-address=${SCRIPT_DEBUGGER_AUTO_ATTACH_CONNECT_ADDRESS}" >> "$PROPERTIES_FILE"
[ -n "${SCRIPT_DEBUGGER_AUTO_ATTACH_TIMEOUT:-}" ] && echo "script-debugger-auto-attach-timeout=${SCRIPT_DEBUGGER_AUTO_ATTACH_TIMEOUT}" >> "$PROPERTIES_FILE"
[ -n "${SCRIPT_DEBUGGER_PASSCODE:-}" ] && echo "script-debugger-passcode=${SCRIPT_DEBUGGER_PASSCODE}" >> "$PROPERTIES_FILE"
[ -n "${SCRIPT_WATCHDOG_ENABLE:-}" ] && echo "script-watchdog-enable=${SCRIPT_WATCHDOG_ENABLE}" >> "$PROPERTIES_FILE"
[ -n "${SCRIPT_WATCHDOG_ENABLE_EXCEPTION_HANDLING:-}" ] && echo "script-watchdog-enable-exception-handling=${SCRIPT_WATCHDOG_ENABLE_EXCEPTION_HANDLING}" >> "$PROPERTIES_FILE"
[ -n "${SCRIPT_WATCHDOG_ENABLE_SHUTDOWN:-}" ] && echo "script-watchdog-enable-shutdown=${SCRIPT_WATCHDOG_ENABLE_SHUTDOWN}" >> "$PROPERTIES_FILE"
[ -n "${SCRIPT_WATCHDOG_HANG_EXCEPTION:-}" ] && echo "script-watchdog-hang-exception=${SCRIPT_WATCHDOG_HANG_EXCEPTION}" >> "$PROPERTIES_FILE"
[ -n "${SCRIPT_WATCHDOG_HANG_THRESHOLD:-}" ] && echo "script-watchdog-hang-threshold=${SCRIPT_WATCHDOG_HANG_THRESHOLD}" >> "$PROPERTIES_FILE"
[ -n "${SCRIPT_WATCHDOG_SPIKE_THRESHOLD:-}" ] && echo "script-watchdog-spike-threshold=${SCRIPT_WATCHDOG_SPIKE_THRESHOLD}" >> "$PROPERTIES_FILE"
[ -n "${SCRIPT_WATCHDOG_SLOW_THRESHOLD:-}" ] && echo "script-watchdog-slow-threshold=${SCRIPT_WATCHDOG_SLOW_THRESHOLD}" >> "$PROPERTIES_FILE"
[ -n "${SCRIPT_WATCHDOG_MEMORY_WARNING:-}" ] && echo "script-watchdog-memory-warning=${SCRIPT_WATCHDOG_MEMORY_WARNING}" >> "$PROPERTIES_FILE"
[ -n "${SCRIPT_WATCHDOG_MEMORY_LIMIT:-}" ] && echo "script-watchdog-memory-limit=${SCRIPT_WATCHDOG_MEMORY_LIMIT}" >> "$PROPERTIES_FILE"
[ -n "${DIAGNOSTICS_CAPTURE_AUTO_START:-}" ] && echo "diagnostics-capture-auto-start=${DIAGNOSTICS_CAPTURE_AUTO_START}" >> "$PROPERTIES_FILE"
[ -n "${DIAGNOSTICS_CAPTURE_MAX_FILES:-}" ] && echo "diagnostics-capture-max-files=${DIAGNOSTICS_CAPTURE_MAX_FILES}" >> "$PROPERTIES_FILE"
[ -n "${DIAGNOSTICS_CAPTURE_MAX_FILES_SIZE:-}" ] && echo "diagnostics-capture-max-file-size=${DIAGNOSTICS_CAPTURE_MAX_FILES_SIZE}" >> "$PROPERTIES_FILE"
[ -n "${DISABLE_CLIENT_VIBRANT_VISUALS:-}" ] && echo "disable-client-vibrant-visuals=${DISABLE_CLIENT_VIBRANT_VISUALS}" >> "$PROPERTIES_FILE"

echo "[+] server.properties generated at $PROPERTIES_FILE"

# ----Symlink logic to mantain player data in a Docker volume----
# CAVE: Server binary expects allowlist.json and permissions.json to be in /bedrock
# A volume expects a directory, but mounting /bedrock entirely would be problematic for 
# changes in .env, server version, etc., 
# Solution: moving the 2 files in a separate folder (for mounting) and create 2 links in the main /bedrock

# Ensure player_data directory exists
PLAYER_DATA_DIR="$BEDROCK_DIR/player_data"
mkdir -p "$PLAYER_DATA_DIR"

# Move files into player_data only if they exist in /bedrock and not already in player_data
for file in allowlist.json permissions.json; do
    if [ -f "$BEDROCK_DIR/$file" ] && [ ! -f "$PLAYER_DATA_DIR/$file" ]; then
        mv "$BEDROCK_DIR/$file" "$PLAYER_DATA_DIR/$file"
    fi
    # Create or recreate the symlink in /bedrock
    ln -sf "$PLAYER_DATA_DIR/$file" "$BEDROCK_DIR/$file"
done

# Start the Bedrock server
echo "[+] Starting bedrock_server..."
cd "$BEDROCK_DIR"
# Use exec to make the Bedrock server process PID 1
exec env LD_LIBRARY_PATH="$BEDROCK_DIR" "$BEDROCK_DIR/bedrock_server"