
_gschem_executable() {
	gschem "$@"
}

# ATTENTION: Overload with 'ops.sh' .
# Mostly serves as an example. The 'gschem' schematic editor has some configuration variables a user may wish to override, but there is no known reason these would need to be set on a per-designer installation basis.
_gschem_method() {
	#export gschemExecutable=$(type -p pcb)
	#export gschemExecutable=
	#_fakeHome "$scriptAbsoluteLocation" --parent _gschem_executable "$@"
	#_gschem_executable "$@"
	
	_fakeHome "$scriptAbsoluteLocation" --parent _gschem_executable "$@"
	#gschem "$@"
}


_gschem_deconfigure_procedure() {
	true
}

_gschem_deconfigure_method() {
	_fakeHome "$scriptAbsoluteLocation" --parent _gschem_deconfigure_procedure "$@"
}





