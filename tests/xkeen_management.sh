#!/bin/sh
set -eu
test_dir=$(mktemp -d)
source_file=$(cd "$(dirname "$0")/.." && pwd)/xmenu-v1.0.sh
sed '/^main "$@"$/d' "$source_file" |
    sed "s#/opt/sbin/.xkeen/01_info/01_info_variable.sh#$test_dir/xkeen-variable.sh#g; s#/opt/sbin/xkeen#$test_dir/opt/sbin/xkeen#g; s#/opt/bin/xkeen#$test_dir/opt/bin/xkeen#g" > "$test_dir/library.sh"
# shellcheck disable=SC1090
. "$test_dir/library.sh"
ROOT_DIR="$test_dir/xmenu"
mkdir -p "$ROOT_DIR" "$test_dir/bin"
trap 'rm -rf "$test_dir"' 0
fail() { printf 'FAIL: %s\n' "$*" >&2; exit 1; }

# XKeen's installed build is authoritative even when Xmenu's old marker disagrees.
printf 'Stable\n' > "$ROOT_DIR/xkeen-channel"
printf 'xkeen_build="Beta"\n' > "$test_dir/xkeen-variable.sh"
test "$(xkeen_channel)" = Beta || fail 'installed Beta build was hidden by stale Xmenu Stable marker'
printf 'xkeen_build="Stable"\n' > "$test_dir/xkeen-variable.sh"
test "$(xkeen_channel)" = Stable || fail 'installed Stable build was not detected'

# Keep compatibility with systems where XKeen has no build metadata file.
rm -f "$test_dir/xkeen-variable.sh"
test "$(xkeen_channel)" = Stable || fail 'legacy Xmenu channel marker was not used as fallback'

# The management submenu must resolve an executable from PATH when the canonical
# /opt/sbin/xkeen path is absent (common for alternate Entware layouts).
printf '#!/bin/sh\nexit 0\n' > "$test_dir/bin/xkeen"
chmod +x "$test_dir/bin/xkeen"
PATH="$test_dir/bin:$PATH"
export PATH
test "$(xmenu_xkeen_command)" = "$test_dir/bin/xkeen" || fail 'XKeen executable was not resolved from PATH'
xmenu_xkeen_is_installed || fail 'XKeen installed through PATH was not detected'

# A group title should disappear when all its currently available items are hidden.
printf 'ru\n' > "$ROOT_DIR/language"
printf '12\n23\n' > "$ROOT_DIR/hidden-menu-items"
xmenu_load_hidden_items
_XMENU_RENDER_WIDTH=80
rendered="$test_dir/menu.txt"
xmenu_render_main_items > "$rendered"
if grep -Fq 'Управление XKeen и nfqws2' "$rendered"; then
    fail 'empty XKeen/nfqws2 group header remained after hiding both items'
fi

# The complete-removal action must use the same resolver as management/update.
cat > "$test_dir/bin/xkeen" <<'EOF'
#!/bin/sh
printf '%s\n' "$@" > "$XKEEN_CALL_LOG"
EOF
chmod +x "$test_dir/bin/xkeen"
XKEEN_CALL_LOG="$test_dir/xkeen-args"
export XKEEN_CALL_LOG
xmenu_xkeen_command() { printf '%s' "$test_dir/bin/xkeen"; }
confirm() { return 0; }
remove_xkeen_component || fail 'full XKeen removal rejected a PATH-resolved executable'
grep -Fxq -- '-remove' "$XKEEN_CALL_LOG" || fail 'full XKeen removal did not call xkeen -remove'

printf 'PASS: XKeen channel detection and command resolution\n'
