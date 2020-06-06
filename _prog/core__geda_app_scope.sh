_scope_geda_gschem_procedure() {
	_messagePlain_nominal 'gschem'
	mkdir -p "$shortTmp"/_build
	
	
	if ! _set_geda_var "$@"
	then
		true
		#_stop 1
	fi
	
	_import_ops_geda_sketch
	_ops_geda_sketch
	
	# Highly unlikely to be required.
	cd "$ub_specimen"
	#_geda_compile_preferences_procedure
	
	_set_geda_fakeHome
	#_set_geda_userShortHome
	#_set_geda_editShortHome
	
	_gschem_method "$@"
	
	_set_geda_userShortHome
	_gschem_deconfigure_method
}

# WARNING: No known production use.
_scope_geda_gschem() {
	local shiftParam1
	shiftParam1="$1"
	shift
	_declare_scope_geda
	_scope "$shiftParam1" "_scope_geda_gschem_procedure" "$@"
}

