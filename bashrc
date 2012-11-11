#!/bin/bash
#
# Runs extra code per phase.

_run_hooks() {
	local hook basedir hook
	phase="$1"
	basedir="$(dirname $0)/hooks"

	einfo "Running ${phase} hooks"

	if [[ -d ${basedir}/${phase}.d/ ]]; then
		for hook in ${basedir}/${phase}.d/* ; do
			if [[ -x ${hook} ]]; then
				einfo "  ${phase} hook: $(basename ${hook})"
				${hook} $@ || exit 1
			fi
		done
	else
		:
	fi

	exit 0
}

post_src_unpack() {
	if has ${EAPI:-0} 0 1; then
		_run_hooks post_src_prepare
	fi
}

post_src_prepare() {
	_run_hooks post_src_prepare
}

post_src_compile() {
	_run_hooks post_src_compile
}

post_src_install() {
	_run_hooks post_src_install
}
