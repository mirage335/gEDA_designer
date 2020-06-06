# Mostly serves as an example.


# WARNING: Ignores all sketch ops. Intended for manual IDE configuration management and testing.
# Mostly serves as an example.
_gschem_user_sequence() {
	_start
	
	if ! _set_geda_var "$@"
	then
		true
		#_stop 1
	fi
	
	_import_ops_geda_sketch
	_ops_geda_sketch
	
	_set_geda_userFakeHome
	#_set_geda_editFakeHome
	
	_gschem_method "$@"
	
	_set_geda_userFakeHome
	#_set_geda_editFakeHome
	_gschem_deconfigure_method
	
	_stop
}

_gschem_user() {
	"$scriptAbsoluteLocation" _gschem_user_sequence "$@"
}



# WARNING: Ignores all sketch ops. Intended for manual IDE configuration management and testing.
# Mostly serves as an example.
_gschem_edit_sequence() {
	_start
	
	if ! _set_geda_var "$@"
	then
		true
		#_stop 1
	fi
	
	_import_ops_geda_sketch
	_ops_geda_sketch
	
	#_set_geda_userFakeHome
	_set_geda_editFakeHome
	
	_gschem_method "$@"
	
	#_set_geda_userFakeHome
	_set_geda_editFakeHome
	_gschem_deconfigure_method
	
	_stop
}

_gschem_edit() {
	"$scriptAbsoluteLocation" _gschem_user_sequence "$@"
}
