#!/usr/bin/env bash
set -euo pipefail

# ── Configuration ────────────────────────────────────────────────────────────
CONTAINER_NAME="small-sql-db"
SA_PASSWORD="YourStrongPassword123!"
HOST_PORT=1433
IMAGE="mcr.microsoft.com/mssql/server:2025-latest"
SQLCMD="/opt/mssql-tools18/bin/sqlcmd"
READY_TIMEOUT=60   # seconds to wait for SQL Server to accept connections

# ── Colours ──────────────────────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
log()  { echo -e "${CYAN}[$(date +%T)]${NC} $*"; }
ok()   { echo -e "${GREEN}[$(date +%T)] ✔${NC} $*"; }
warn() { echo -e "${YELLOW}[$(date +%T)] ⚠${NC} $*"; }
die()  { echo -e "${RED}[$(date +%T)] ✘${NC} $*" >&2; exit 1; }

# ── Prerequisites ────────────────────────────────────────────────────────────
check_prereqs() {
  command -v docker &>/dev/null || die "Docker is not installed or not in PATH."
  docker info &>/dev/null       || die "Docker daemon is not running."
  ok "Docker is available."
}

# ── Container lifecycle ──────────────────────────────────────────────────────
stop_existing() {
  local state
  state=$(docker inspect --format '{{.State.Status}}' "$CONTAINER_NAME" 2>/dev/null || true)
  case "$state" in
    running) warn "Container '$CONTAINER_NAME' already running — stopping it."; docker stop "$CONTAINER_NAME" >/dev/null ;;
    exited|created|paused) warn "Container '$CONTAINER_NAME' exists (state: $state) — removing it." ;;
    "")      return 0 ;;  # does not exist
  esac
  docker rm "$CONTAINER_NAME" >/dev/null
}

start_container() {
  log "Starting SQL Server container…"
  docker run \
    --name  "$CONTAINER_NAME" \
    -e      "ACCEPT_EULA=Y" \
    -e      "MSSQL_SA_PASSWORD=${SA_PASSWORD}" \
    -p      "${HOST_PORT}:1433" \
    --health-cmd  "$SQLCMD -S localhost -U sa -P '${SA_PASSWORD}' -No -Q 'SELECT 1' 2>/dev/null" \
    --health-interval 5s \
    --health-retries 12 \
    -d      "$IMAGE" \
    >/dev/null
  ok "Container started."
}

# ── Readiness ────────────────────────────────────────────────────────────────
wait_for_sql() {
  log "Waiting for SQL Server to accept connections (timeout: ${READY_TIMEOUT}s)…"
  local elapsed=0 interval=3
  until docker exec "$CONTAINER_NAME" \
        "$SQLCMD" -S localhost -U sa -P "$SA_PASSWORD" -No -Q "SELECT 1" &>/dev/null; do
    if (( elapsed >= READY_TIMEOUT )); then
      die "SQL Server did not become ready within ${READY_TIMEOUT}s."
    fi
    sleep "$interval"
    (( elapsed += interval ))
    log "  still waiting… (${elapsed}s elapsed)"
  done
  ok "SQL Server is ready."
}

# ── Summary ──────────────────────────────────────────────────────────────────
print_summary() {
  echo
  echo -e "${GREEN}════════════════════════════════════════${NC}"
  echo -e "${GREEN}  SQL Server ready${NC}"
  echo -e "${GREEN}════════════════════════════════════════${NC}"
  echo -e "  Host     : localhost:${HOST_PORT}"
  echo -e "  User     : sa"
  echo -e "  Password : ${SA_PASSWORD}"
  echo
  echo -e "  Connect via sqlcmd:"
  echo -e "  ${CYAN}docker exec -it ${CONTAINER_NAME} ${SQLCMD} \\"
  echo -e "    -S localhost -U sa -P '${SA_PASSWORD}' -No${NC}"
  echo
  echo -e "  Stop & remove when done:"
  echo -e "  ${CYAN}docker rm -f ${CONTAINER_NAME}${NC}"
  echo -e "${GREEN}════════════════════════════════════════${NC}"
}

# ── Main ─────────────────────────────────────────────────────────────────────
main() {
  check_prereqs
  stop_existing
  start_container
  wait_for_sql
  print_summary
}

main "$@"
