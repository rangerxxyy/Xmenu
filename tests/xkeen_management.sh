#!/bin/sh
set -eu
test_dir=$(mktemp -d)
source_file=$(cd "$(dirname "$0")/.." && pwd)/xmenu-v1.0.sh
sed '/^main "$@"$/d' "$source_file" |
    sed "s#/opt/sbin/.xkeen/01_info/01_info_variable.sh#$test_dir/xkeen-variable.sh#g" > "$test_dir/library.sh"
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

printf 'PASS: XKeen channel detection and command resolution\n'
