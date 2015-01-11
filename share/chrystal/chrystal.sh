CHRYSTAL_VERSION="0.1.0"
CRYSTALS=()

for dir in "$PREFIX/opt/crystals" "$HOME/.crystals"; do
	[[ -d "$dir" && -n "$(ls -A "$dir")" ]] && CRYSTALS+=("$dir"/*)
done
unset dir

function chrystal_reset()
{
	[[ -z "$CRYSTAL_ROOT" ]] && return

	PATH=":$PATH:"; PATH="${PATH//:$CRYSTAL_ROOT\/bin:/:}"

	PATH="${PATH#:}"; PATH="${PATH%:}"
	unset CRYSTAL_ROOT CRYSTAL_VERSION
	hash -r
}

function chrystal_use()
{
	if [[ ! -x "$1/bin/crystal" ]]; then
		echo "chrystal: $1/bin/crystal not executable" >&2
		return 1
	fi

	[[ -n "$CRYSTAL_ROOT" ]] && chrystal_reset

	export CRYSTAL_ROOT="$1"
	export PATH="$CRYSTAL_ROOT/bin:$PATH"

	export CRYSTAL_VERSION=`$CRYSTAL_ROOT/bin/crystal --version | cut -d' ' -f2`
# 	eval "$("$CRYSTAL_ROOT/bin/ruby" - <<EOF
# puts "export RUBY_ENGINE=#{defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'ruby'};"
# puts "export RUBY_VERSION=#{RUBY_VERSION};"
# begin; require 'rubygems'; puts "export GEM_ROOT=#{Gem.default_dir.inspect};"; rescue LoadError; end
# EOF
# )"
}

function chrystal()
{
	case "$1" in
		-h|--help)
			echo "usage: chrystal [CRYSTAL|VERSION|system]"
			;;
		-V|--version)
			echo "chrystal: $CHRYSTAL_VERSION"
			;;
		"")
			local dir star
			for dir in "${CRYSTALS[@]}"; do
				dir="${dir%%/}"
				if [[ "$dir" == "$CRYSTAL_ROOT" ]]; then star="*"
				else                                  star=" "
				fi

				echo " $star ${dir##*/}"
			done
			;;
		system) chrystal_reset ;;
		*)
			local dir match
			for dir in "${CRYSTALS[@]}"; do
				dir="${dir%%/}"
				case "${dir##*/}" in
					"$1")	match="$dir" && break ;;
					*"$1"*)	match="$dir" ;;
				esac
			done

			if [[ -z "$match" ]]; then
				echo "chrystal: unknown Crystal: $1" >&2
				return 1
			fi

			shift
			chrystal_use "$match" "$*"
			;;
	esac
}
