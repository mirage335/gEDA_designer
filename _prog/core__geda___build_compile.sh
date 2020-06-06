

_geda_compile___file_pcb() {
	_messagePlain_nominal 'Compile: extract_layers'
	_messagePlain_good 'found: '"$1"
	
	local currentInput
	currentInput=$(_getAbsoluteLocation "$1")
	
	local currentInput_base
	currentInput_base=$(basename "$currentInput")
	
	local currentInput_name
	currentInput_name="${currentInput_base%.*}"
	
	_messagePlain_probe_var currentInput_name
	
	
	
	
	mkdir -p "$se_out_tmp"/_raw/layers/"$currentInput_name"
	mkdir -p "$se_out"/_raw/layers/"$currentInput_name"
	
	#pcb -x gerber --all-layers --name-style fixed --gerberfile ./_build/30MHzLowPass ./30MHzLowPass.pcb
	pcb -x gerber --all-layers --name-style fixed --gerberfile "$se_out_tmp"/_raw/layers/"$currentInput_name"/"$currentInput_name" "$currentInput"
	
	cp "$se_out_tmp"/_raw/layers/"$currentInput_name"/* "$se_out"/_raw/layers/"$currentInput_name"/
	
}


# First parameter must be '*.pcb' or directory .
_geda_compile__build_procedure() {
	# WARNING: May be imperfect.
	# Ignore directory parameter (already validated).
	[[ "$1" != "" ]] && [[ -d "$1" ]] && shift
	[[ "$1" != "" ]] && [[ "$1" != *".pcb" ]] && _messagePlain_bad 'fail: invalid parameter input' && return 1
	
	
	if [[ "$1" != "" ]] && [[ "$1" == *".pcb" ]] && [[ -e "$1" ]]
	then
		# Single file requested.
		_geda_compile___file_pcb "$@"
		return 0
	elif [[ "$1" != "" ]]
	then
		_messagePlain_bad 'fail: invalid parameter input' && return 1
	fi
	
	find "$se_sketchDir" -maxdepth 1 -type f -name '*.pcb' -exec "$scriptAbsoluteLocation" _geda_compile___file_pcb {} "$@" \;
}



_geda_compile__preferences_procedure() {
	# Example ONLY.
	#_set_geda_fakeHome
	#_messagePlain_nominal '_geda...: compile: set: build path'
	#_geda_method_special --save-prefs --pref build.path="$shortTmp"/_build
	
	# Example ONLY.
	# ATTENTION: WARNING: Full operation combination. Undefined behavior may occur.
	#_set_arduino_fakeHome
	#_messagePlain_nominal '_geda...: compile: combine: full'
	#_geda_method_special --save-prefs --pref build.path="$shortTmp"/_build "$@"
	
	_geda_compile__build_procedure "$@"
}



_geda_compile__procedure() {
	local localFunctionEntryPWD
	localFunctionEntryPWD="$PWD"
	
	_messagePlain_nominal 'Compile.'
	
	#Current directory is generally irrelevant to typical compile, and if different from sketchDir, may cause problems.
	cd "$se_sketchDir"
	
	export se_out_tmp="$shortTmp"/_build
	mkdir -p "$se_out_tmp"
	mkdir -p "$se_out"
	
	
	
	_geda_compile__preferences_procedure "$@"
	
	
	
	
	#cp "$shortTmp"/_build/*.bin "$se_out"/
	
	
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
	#_set_geda_userShortHome
	#_set_geda_editShortHome
	
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

_gEDA_designer_out_geometery() {
	_geda_compile "$@"
}
_gEDA_designer_geometery() {
	_gEDA_designer_out_geometery "$@"
}

