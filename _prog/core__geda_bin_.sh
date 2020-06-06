
_gschem_executable() {
	gschem "$@"
}

# ATTENTION: Overload with 'ops.sh' .
# Mostly serves as a hook and example. The 'gschem' schematic editor has some configuration variables a user may wish to override, but there is no known reason these would need to be set on a per-designer installation basis.
_gschem_method() {
	#export gschemExecutable=$(type -p pcb)
	#export gschemExecutable=
	#_fakeHome "$scriptAbsoluteLocation" --parent _gschem_executable "$@"
	#_gschem_executable "$@"
	
	#_fakeHome "$scriptAbsoluteLocation" --parent _gschem_executable "$@"
	_gschem_executable "$@"
}


_gschem_deconfigure_procedure() {
	true
}

_gschem_deconfigure_method() {
	true
	#_fakeHome "$scriptAbsoluteLocation" --parent _gschem_deconfigure_procedure "$@"
}









_pcb_executable() {
	pcb "$@"
}

# ATTENTION: Overload with 'ops.sh' .
# Mostly serves as a hook and example. The 'pcb' schematic editor has some configuration variables a user may wish to override, but there is no known reason these would need to be set on a per-designer installation basis.
_pcb_method() {
	#export pcbExecutable=$(type -p pcb)
	#export pcbExecutable=
	#_fakeHome "$scriptAbsoluteLocation" --parent _pcb_executable "$@"
	#_pcb_executable "$@"
	
	#_fakeHome "$scriptAbsoluteLocation" --parent _pcb_executable "$@"
	_pcb_executable "$@"
}


_pcb_deconfigure_procedure() {
	true
}

_pcb_deconfigure_method() {
	true
	#_fakeHome "$scriptAbsoluteLocation" --parent _pcb_deconfigure_procedure "$@"
}


