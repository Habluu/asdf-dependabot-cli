#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/dependabot/cli"
TOOL_NAME="dependabot"
TOOL_TEST="dependabot --help"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if dependabot-cli is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
	list_github_tags
}

download_release() {
	local version filename url os_type cpu_type
	version="$1"
	filename="$2"
	os_type=$(get_os)
	cpu_type=$(get_cpu)
	url="$GH_REPO/releases/download/v${version}/dependabot-v${version}-${os_type}-${cpu_type}.tar.gz"

	echo "* Downloading $TOOL_NAME release $version in $filename"
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

get_cpu() {
	local machine_hardware_name
	machine_hardware_name=${ASDF_DEPENDABOT_CLI_OVERWRITE_ARCH:-"$(uname -m)"}

	local cpu_type
	case "$machine_hardware_name" in
	'x86_64' | 'x86-64' | 'x64' | 'amd64') cpu_type="amd64" ;;
	'i386') cpu_type="386" ;;
	'aarch64' | 'arm64') cpu_type="arm64" ;;
	'armv7l' | 'armv8l') cpu_type="arm" ;;
	*) fail "Unsupported machine architecture" ;;
	esac
	echo "$cpu_type"
}

get_os() {
	uname | tr '[:upper:]' '[:lower:]'
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		local tool_cmd
		tool_cmd="$(printf "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
