
_set_geda_userShortHome() {
	export actualFakeHome="$shortFakeHome"
	export fakeHomeEditLib="false"
	export keepFakeHome="true"
}

_set_geda_editShortHome() {
	export actualFakeHome="$shortFakeHome"
	export fakeHomeEditLib="true"
	export keepFakeHome="true"
}

_set_geda_userFakeHome() {
	export actualFakeHome="$instancedFakeHome"
	export fakeHomeEditLib="false"
	export keepFakeHome="true"
}

_set_geda_editFakeHome() {
	export actualFakeHome="$globalFakeHome"
	export fakeHomeEditLib="false"
	export keepFakeHome="true"
}


# ATTENTION: Sets whether global fakeHome directory is used in editable mode for compile jobs and similar!
# DANGER: Setting 'user' non-editable is known to break automatic setting of 'preferences' needed for some applications in some unusual situations!
# WARNING: Setting 'user' non-editable is known to possibly cause warning messages with gdb and/or ddd .
_set_geda_fakeHome() {
	_set_geda_userFakeHome
	#_set_geda_editFakeHome
}


_reset_geda_sketchDir() {
	export se_sketch=
	export se_sketchDir=
	export se_out=
	
	export se_basename=
}

_validate_geda_sketchDir_buildOut() {
	find "$se_sketchDir" -maxdepth 1 -type f -name '*.pcb' | _condition_lines_zero && return 1
	
	# WARNING: Allows possible failures if ".sch" file is expected and not checked for.
	#find "$se_sketchDir" -maxdepth 1 -type f -name '*.sch' | _condition_lines_zero && return 1
	
	return 0
}

_validate_geda_sketchDir() {
	# WARNING: No known plausible justification. May interfere with building multiple layouts.
	#! [[ -e "$se_sketch" ]] && return 1
	
	! [[ -e "$se_sketchDir" ]] && return 1
	! [[ -d "$se_sketchDir" ]] && return 1
	
	# WARNING: Without '*.sch' files (layout), bill of materials cannot be generated. Usually these are required as standard geometry files!
	# WARNING: Without '*.pcb' files (layout), it will not be possible to build standard geometry files!
	_validate_geda_sketchDir_buildOut && return 0
	_messagePlain_bad 'missing: build: layout'
	
	# WARNING: Without even a schematic, there is nothing for the designer to work on.
	#if find "$se_sketchDir" -maxdepth 1 -type f -name '*.pcb' | _condition_lines_zero && find "$se_sketchDir" -maxdepth 1 -type f -name '*.sch' | _condition_lines_zero
	if find "$se_sketchDir" -maxdepth 1 -type f -name '*.sch' | _condition_lines_zero
	then
		_messagePlain_bad 'fail: missing: schematic'
		return 1
	fi
	
	
	return 0
}


_set_geda_sketchDir() {
	if [[ -d "$1" ]] && [[ -e "$1" ]]
	then
		_reset_geda_sketchDir
		export se_sketchDir=$(_getAbsoluteLocation "$1")
		export se_basename=$(basename "$se_sketchDir")
		export se_out="$se_sketchDir"/_build
		
		_validate_geda_sketchDir && return 0
		
		#Fallback. Fatal error, tool.
		_messagePlain_bad 'fail: _set_geda_sketchDir"'
		return 1
	fi
	
	if [[ -e "$1" ]]
	then
		_reset_geda_sketchDir
		export se_sketchDir=$(_findDir "$1")
		export se_sketchDir=$(_getAbsoluteLocation "$se_sketchDir")
		export se_basename=$(basename "$se_sketchDir")
		export se_out="$se_sketchDir"/_build
		
		_validate_geda_sketchDir && return 0
		
		#Fallback. Fatal error, tool.
		_messagePlain_bad 'fail: _set_geda_sketchDir"'
		return 1
	fi
	
	_reset_geda_sketchDir
	export se_sketchDir=$(_getAbsoluteLocation "$PWD")
	export se_basename=$(basename "$se_sketchDir")
	export se_out="$se_sketchDir"/_build
	
	_validate_geda_sketchDir && return 0
	
	#Fallback. Fatal error, tool.
	_messagePlain_bad 'fail: _set_geda_sketchDir"'
	return 1
}



_set_geda_var() {
	if ! _set_geda_sketchDir "$@"
	then
		return 1
	fi
	
	_messagePlain_probe_var se_sketch
	_messagePlain_probe_var se_sketchDir
	_messagePlain_probe_var se_out
	
	_messagePlain_probe_var se_basename
	
	return 0
}



# WARNING: May override user's project settings.
# WARNING: NECESSARY to ensure such things as complete list of attributes in correct order to satisfy manufacturer BOM requirements.
_prepare_geda_in_overlay() {
	_instance_internal "$scriptLib"/_in_overlay/. "$se_in_tmp"/
}




