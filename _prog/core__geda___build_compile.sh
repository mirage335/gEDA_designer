

_geda_compile__in_copy() {
	_instance_internal "$se_sketchDir"/. "$se_in_tmp"/
}


# WARNING: No production use.
# DANGER: Breaks building from a copy with automatic modifications.
_geda_compile___file_pcb() {
	_messagePlain_nominal 'Compile: pcb'
	_messagePlain_good 'found: '"$1"
	
	local currentInput
	currentInput=$(_getAbsoluteLocation "$1")
	
	local currentInput_base
	currentInput_base=$(basename "$currentInput")
	
	local currentInput_name
	currentInput_name="${currentInput_base%.*}"
	
	_messagePlain_probe_var currentInput_name
	
	
	
	
	_geda_compile_intermediate_layers "$@"
	_geda_compile_intermediate_materials "$@"
	
}

# WARNING: No production use.
# DANGER: Breaks building from a copy with automatic modifications.
_geda_compile___file_sch() {
	_messagePlain_nominal 'Compile: sch'
	_messagePlain_good 'found: '"$1"
	
	local currentInput
	currentInput=$(_getAbsoluteLocation "$1")
	
	local currentInput_base
	currentInput_base=$(basename "$currentInput")
	
	local currentInput_name
	currentInput_name="${currentInput_base%.*}"
	
	_messagePlain_probe_var currentInput_name
	
	
	
	
	#_geda_compile_intermediate_layers "$@"
	_geda_compile_intermediate_materials_sch "$@"
	
}


# First parameter must be '*.pcb' or directory .
_geda_compile__build_pcb_procedure() {
	# WARNING: May be imperfect.
	# Ignore directory parameter (already validated).
	[[ "$1" != "" ]] && [[ -d "$1" ]] && shift
	[[ "$1" != "" ]] && [[ "$1" != *".pcb" ]] && _messagePlain_bad 'fail: invalid parameter input' && return 1
	
	
	if [[ "$1" != "" ]] && [[ "$1" == *".pcb" ]] && [[ -e "$1" ]]
	then
		# Single file requested.
		#_geda_compile___file_pcb "$@"
		#return 0
		
		# WARNING: Support for individual files DISABLED to support building from a copy with automatic modifications.
		#Best practice is to manually identify and separately save specialized output as required.
		_messagePlain_bad 'fail: invalid parameter input: single file not supported'
		return 1
	elif [[ "$1" != "" ]]
	then
		_messagePlain_bad 'fail: invalid parameter input' && return 1
	fi
	
	#find "$se_sketchDir" -maxdepth 1 -type f -name '*.pcb' -exec "$scriptAbsoluteLocation" _geda_compile___file_pcb {} "$@" \;
	find "$se_in_tmp" -maxdepth 1 -type f -name '*.pcb' -exec "$scriptAbsoluteLocation" _geda_compile___file_pcb {} "$@" \;
}

# First parameter must be '*.sch' or directory .
_geda_compile__build_sch_procedure() {
	# WARNING: May be imperfect.
	# Ignore directory parameter (already validated).
	[[ "$1" != "" ]] && [[ -d "$1" ]] && shift
	[[ "$1" != "" ]] && [[ "$1" != *".sch" ]] && _messagePlain_bad 'fail: invalid parameter input' && return 1
	
	
	if [[ "$1" != "" ]] && [[ "$1" == *".sch" ]] && [[ -e "$1" ]]
	then
		# Single file requested.
		#_geda_compile___file_sch "$@"
		#return 0
		
		# WARNING: Support for individual files DISABLED to support building from a copy with automatic modifications.
		#Best practice is to manually identify and separately save specialized output 
		_messagePlain_bad 'fail: invalid parameter input: single file not supported'
		return 1
	elif [[ "$1" != "" ]]
	then
		_messagePlain_bad 'fail: invalid parameter input' && return 1
	fi
	
	#find "$se_sketchDir" -maxdepth 1 -type f -name '*.sch' -exec "$scriptAbsoluteLocation" _geda_compile___file_sch {} "$@" \;
	find "$se_in_tmp" -maxdepth 1 -type f -name '*.sch' -exec "$scriptAbsoluteLocation" _geda_compile___file_sch {} "$@" \;
}


_geda_compile__preferences_procedure() {
	# Example ONLY.
	#_set_geda_fakeHome
	#_messagePlain_nominal '_geda...: compile: set: build path'
	#_geda_method_special --save-prefs --pref build.path="$safeTmp"/_build
	
	# Example ONLY.
	# ATTENTION: WARNING: Full operation combination. Undefined behavior may occur.
	#_set_geda_fakeHome
	#_messagePlain_nominal '_geda...: compile: combine: full'
	#_geda_method_special --save-prefs --pref build.path="$safeTmp"/_build "$@"
	
	_geda_compile__build_pcb_procedure "$@"
	_geda_compile__build_sch_procedure "$@"
}



_geda_compile__procedure() {
	local localFunctionEntryPWD
	localFunctionEntryPWD="$PWD"
	
	_messagePlain_nominal 'Compile.'
	
	#Current directory is generally irrelevant to typical compile, and if different from sketchDir, may cause problems.
	cd "$se_sketchDir"
	
	export se_out_tmp="$safeTmp"/_build
	mkdir -p "$se_out_tmp"
	mkdir -p "$se_out"
	
	
	export se_in_tmp="$safeTmp"/_in
	mkdir -p "$se_in_tmp"
	_geda_compile__in_copy
	_prepare_geda_manufacturer
	
	_geda_compile__preferences_procedure "$@"
	
	
	
	
	#cp "$safeTmp"/_build/*.bin "$se_out"/
	
	
	cd "$localFunctionEntryPWD"
}


_geda_compile__sequence() {
	_start
	
	if ! _set_geda_var "$@"
	then
		#true
		_stop 1
	fi
	
	_import_ops_geda_sketch
	_ops_geda_sketch
	
	#cd "$ub_specimen"
	#_geda_compile__preferences_procedure
	
	_set_geda_fakeHome
	#_set_geda_userFakeHome
	#_set_geda_editFakeHome
	
	#_gschem_method "$@"
	#_gschem_executable "$@"
	_geda_compile__procedure "$@"
	
	_set_geda_fakeHome
	_gschem_deconfigure_method
	
	_stop
}


_geda_compile() {
	"$scriptAbsoluteLocation" _geda_compile__sequence "$@"
}

_gEDA_designer_out_geometry() {
	_geda_compile "$@"
}
_gEDA_designer_geometry() {
	_gEDA_designer_out_geometry "$@"
}

