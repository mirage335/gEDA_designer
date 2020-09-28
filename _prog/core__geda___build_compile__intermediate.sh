

# ATTENTION: Overload with ops (including sketch ops) to FORCE incomplete build attempt.
# DANGER: Incomplete build attempt ability has not been adequately developed and tested. Forcing this may (however unlikely) be able to cause damage (ie. inappropraite rm) to the host system.
# CAUTION: Does not ensure underlying project is valid. Incorrect BOM data will be reflected in outputs. Missing 'gafrc' and similar files may result in empty 'bom' files.
_check_geda_intermediate_all() {
	[[ "$intermediate_layers" == "" ]] && _stop 1
	[[ ! -e "$intermediate_layers" ]] && _stop 1
	[[ ! -d "$intermediate_layers" ]] && _stop 1
	
	[[ "$intermediate_materials" == "" ]] && _stop 1
	[[ ! -e "$intermediate_materials" ]] && _stop 1
	[[ ! -d "$intermediate_materials" ]] && _stop 1
	
	[[ "$intermediate_materials_sch" == "" ]] && _stop 1
	[[ ! -e "$intermediate_materials_sch" ]] && _stop 1
	[[ ! -d "$intermediate_materials_sch" ]] && _stop 1
	
	local anticipated_attribsFile
	anticipated_attribsFile=$(_findDir "$currentInput")
	anticipated_attribsFile="$anticipated_attribsFile"/attribs
	if ! [[ -e "$anticipated_attribsFile" ]]
	then
		# Comprehensive attribs file is expected to have been provided by "_in_overlay" regardless of any other attribs file.
		_messagePlain_bad 'fail: unexpected: missing: attribs file!'
		_stop 1
	fi
	
	local anticipated_schFile
	anticipated_schFile=$(_findDir "$currentInput")
	anticipated_schFile="$anticipated_schFile"/"$currentInput_name".sch
	if ! [[ -e "$anticipated_schFile" ]]
	then
		# Without 'sch' file, relevant intermediate xy and similar files may not have been produced.
		_messagePlain_bad 'fail: unexpected: missing: sch file!'
		_stop 1
	fi
	
	local anticipated_pcbFile
	anticipated_pcbFile=$(_findDir "$currentInput")
	anticipated_pcbFile="$anticipated_pcbFile"/"$currentInput_name".pcb
	if ! [[ -e "$anticipated_pcbFile" ]]
	then
		# Without 'pcb' file, relevant intermediate xy and similar files may not have been produced.
		_messagePlain_bad 'fail: unexpected: missing: pcb file!'
		_stop 1
	fi
	
	! [[ -e "$intermediate_materials_sch"/machineBOM-pure.txt ]] && _messagePlain_bad 'fail: unexpected: missing: intermediate: sch: machineBOM-pure.txt !' && _stop 1
	! [[ -e "$intermediate_materials_sch"/"$currentInput_name".bom ]] && _messagePlain_bad 'fail: unexpected: missing: intermediate: sch: BOM !' && _stop 1
	
	! [[ -e "$intermediate_materials"/"$currentInput_name".bom ]] && _messagePlain_bad 'fail: unexpected: missing: intermediate: ...bom' && _stop 1
	! [[ -e "$intermediate_materials"/"$currentInput_name"-mil.xy ]] && _messagePlain_bad 'fail: unexpected: missing: intermediate: ...mil.xy' && _stop 1
	! [[ -e "$intermediate_materials"/"$currentInput_name"-in.xy ]] && _messagePlain_bad 'fail: unexpected: missing: intermediate: ...in.xy' && _stop 1
	! [[ -e "$intermediate_materials"/"$currentInput_name"-mm.xy ]] && _messagePlain_bad 'fail: unexpected: missing: intermediate: ...mm.xy' && _stop 1
	
	return 0
}


_geda_compile_intermediate_diagram_png() {
	_messagePlain_nominal 'Compile: intermediate_diagram_png'
	#cd "$se_sketchDir"
	cd "$se_in_tmp"
	
	export intermediate_diagram="$se_out_tmp"/_intermediate/diagram/"$currentInput_name"
	
	mkdir -p "$intermediate_diagram"
	mkdir -p "$se_out"/_intermediate/diagram/"$currentInput_name"
	
	#pcb -x gerber --all-layers --name-style fixed --gerberfile ./_build/30MHzLowPass ./30MHzLowPass.pcb
	#_messagePlain_probe_cmd pcb -x gerber --all-layers --name-style fixed --gerberfile "$intermediate_diagram"/"$currentInput_name" "$currentInput"
	
	#_messagePlain_probe_cmd pcb -x png --dpi 300 --outfile "$intermediate_diagram"/"$currentInput_name".png --layer-color-1 "#6666FF" --layer-color-2 "#0000A6" --layer-color-3 "#FFCC66" --layer-color-4 "#A66F00" --layer-color-5 "#66FF66" --layer-color-6 "#00A600" --layer-color-7 "#8C4F31" --layer-color-8 "#592C16" --layer-color-9 "#E6B8B8" --layer-color-10 "#E6DAB8" --layer-color-11 "#CFE6B8" --layer-color-12 "#CFB8E6" --layer-color-13 "#001819" --layer-color-14 "#404040" --layer-color-15 "#330000" --layer-color-16 "#332600" "$currentInput"
	#pcb -x png --dpi 300 --outfile "$intermediate_diagram"/"$currentInput_name".png --layer-color-1 "#6666FF" --layer-color-2 "#0000A6" --layer-color-3 "#FFCC66" --layer-color-4 "#A66F00" --layer-color-5 "#66FF66" --layer-color-6 "#00A600" --layer-color-7 "#8C4F31" --layer-color-8 "#592C16" --layer-color-9 "#E6B8B8" --layer-color-10 "#E6DAB8" --layer-color-11 "#CFE6B8" --layer-color-12 "#CFB8E6" --layer-color-13 "#001819" --layer-color-14 "#404040" --layer-color-15 "#330000" --layer-color-16 "#332600" --white-color "#000000" --black-color "#FFFFFF" --background-color "#E5E5E5" "$currentInput"
	#pcb -x ps --psfile ./test.ps --ps-color --dpi 300 --layer-color-1 "#6666FF" --layer-color-2 "#0000A6" --layer-color-3 "#FFCC66" --layer-color-4 "#A66F00" --layer-color-5 "#66FF66" --layer-color-6 "#00A600" --layer-color-7 "#8C4F31" --layer-color-8 "#592C16" --layer-color-9 "#E6B8B8" --layer-color-10 "#E6DAB8" --layer-color-11 "#CFE6B8" --layer-color-12 "#CFB8E6" --layer-color-13 "#001819" --layer-color-14 "#404040" --layer-color-15 "#330000" --layer-color-16 "#332600" --white-color "#000000" --black-color "#FFFFFF" --background-color "#E5E5E5" "$currentInput"
	
	#_geda_compile_layers
	
	
	#pcb -x png --dpi 300 --outfile "$intermediate_diagram"/"$currentInput_name".png --layer-color-1 "#6666FF" --layer-color-2 "#0000A6" --layer-color-3 "#FFCC66" --layer-color-4 "#A66F00" --layer-color-5 "#66FF66" --layer-color-6 "#00A600" --layer-color-7 "#8C4F31" --layer-color-8 "#592C16" --layer-color-9 "#E6B8B8" --layer-color-10 "#E6DAB8" --layer-color-11 "#CFE6B8" --layer-color-12 "#CFB8E6" --layer-color-13 "#001819" --layer-color-14 "#404040" --layer-color-15 "#330000" --layer-color-16 "#332600" --white-color "#000000" --black-color "#FFFFFF" --background-color "#E5E5E5" "$currentInput"
	
	#--use-alpha
	"$scriptAbsoluteLocation" _pcb_color_project "T568A-special-png" "$currentInput" -x png --dpi 1200 --outfile "$intermediate_diagram"/"$currentInput_name"-T568A-raw.png
	"$scriptAbsoluteLocation" _pcb_color_project "rainbow-special-png" "$currentInput" -x png --dpi 1200 --outfile "$intermediate_diagram"/"$currentInput_name"-rainbow-raw.png
	"$scriptAbsoluteLocation" _pcb_color_project "wirewrap-special-png" "$currentInput" -x png --dpi 1200 --outfile "$intermediate_diagram"/"$currentInput_name"-wirewrap-raw.png
	"$scriptAbsoluteLocation" _pcb_color_project "custom-special-png" "$currentInput" -x png --dpi 1200 --outfile "$intermediate_diagram"/"$currentInput_name"-custom-raw.png
	
	cp "$intermediate_diagram"/* "$se_out"/_intermediate/diagram/"$currentInput_name"/
	
	
	_messageNormal "Compile: CAD: diagram"
	
	
	local currentSpecific_work_cad
	currentSpecific_work_cad="$safeTmp"/_specific/cad/"$currentInput_name"
	mkdir -p "$currentSpecific_work_cad"
	
	# ATTENTION: Rather than merely copying/renaming files, image postprocessing may be done here.
	# Color swapping to improve diagram contrast/readability might be desirable.
	# In practice, sufficiently robust and simple color swapping may not be practical with typically available applications (ie. ImageMagick).
	# Scriptable desktop applications in particular (ie. Inkscape, GIMP) may change too much in fucntionality or availability with sufficient time.
	
	#cp "$se_out"/_intermediate/diagram/"$currentInput_name"/* "$currentSpecific_work_cad"/
	cp "$se_out"/_intermediate/diagram/"$currentInput_name"/"$currentInput_name"-T568A-raw.png "$currentSpecific_work_cad"/"$currentInput_name"-T568A.png
	cp "$se_out"/_intermediate/diagram/"$currentInput_name"/"$currentInput_name"-rainbow-raw.png "$currentSpecific_work_cad"/"$currentInput_name"-rainbow.png
	cp "$se_out"/_intermediate/diagram/"$currentInput_name"/"$currentInput_name"-wirewrap-raw.png "$currentSpecific_work_cad"/"$currentInput_name"-wirewrap.png
	cp "$se_out"/_intermediate/diagram/"$currentInput_name"/"$currentInput_name"-custom-raw.png "$currentSpecific_work_cad"/"$currentInput_name"-custom.png
	
	mkdir -p "$se_out"/cad/"$currentInput_name"/
	cp "$currentSpecific_work_cad"/* "$se_out"/cad/"$currentInput_name"/
	
	
	
	
	_messageNormal "Compile: CAD: diagram: end"
	
}

_geda_compile_intermediate_layers() {
	_messagePlain_nominal 'Compile: intermediate_layers'
	#cd "$se_sketchDir"
	cd "$se_in_tmp"
	
	export intermediate_layers="$se_out_tmp"/_intermediate/layers/"$currentInput_name"
	
	mkdir -p "$intermediate_layers"
	mkdir -p "$se_out"/_intermediate/layers/"$currentInput_name"
	
	#pcb -x gerber --all-layers --name-style fixed --gerberfile ./_build/30MHzLowPass ./30MHzLowPass.pcb
	_messagePlain_probe_cmd pcb -x gerber --all-layers --name-style fixed --gerberfile "$intermediate_layers"/"$currentInput_name" "$currentInput"
	
	_geda_compile_layers
	
	cp "$intermediate_layers"/* "$se_out"/_intermediate/layers/"$currentInput_name"/
	
}

_geda_compile_intermediate_materials() {
	_messagePlain_nominal 'Compile: intermediate_materials'
	#cd "$se_sketchDir"
	cd "$se_in_tmp"
	
	export intermediate_layers="$se_out_tmp"/_intermediate/layers/"$currentInput_name"
	export intermediate_materials="$se_out_tmp"/_intermediate/materials/"$currentInput_name"
	
	mkdir -p "$intermediate_materials"
	mkdir -p "$se_out"/_intermediate/materials/"$currentInput_name"
	
	local anticipated_attribsFile
	anticipated_attribsFile=$(_findDir "$currentInput")
	anticipated_attribsFile="$anticipated_attribsFile"/attribs
	
	
	if ! [[ -e "$anticipated_attribsFile" ]]
	then
		_messagePlain_bad 'fail: BOM generation without attrs file currently not supported!'
		_stop 1
	fi
	
	if [[ -e "$anticipated_attribsFile" ]]
	then
		#_messagePlain_probe_cmd_quoteAdd
		_messagePlain_probe_cmd pcb -x bom --attrs "$anticipated_attribsFile" --bomfile "$intermediate_materials"/"$currentInput_name".bom "$currentInput"
		_messagePlain_probe_cmd pcb -x bom --attrs "$anticipated_attribsFile" --xy-unit mil --xyfile "$intermediate_materials"/"$currentInput_name"-mil.xy "$currentInput"
		_messagePlain_probe_cmd pcb -x bom --attrs "$anticipated_attribsFile" --xy-unit in --xyfile "$intermediate_materials"/"$currentInput_name"-in.xy "$currentInput"
		_messagePlain_probe_cmd pcb -x bom --attrs "$anticipated_attribsFile" --xy-unit mm --xyfile "$intermediate_materials"/"$currentInput_name"-mm.xy "$currentInput"
	fi
	
	_geda_compile_materials
	
	cp "$intermediate_materials"/* "$se_out"/_intermediate/materials/"$currentInput_name"/
}




_geda_compile_intermediate_materials_sch() {
	_messagePlain_nominal 'Compile: intermediate_materials_sch'
	#cd "$se_sketchDir"
	cd "$se_in_tmp"
	
	export intermediate_layers="$se_out_tmp"/_intermediate/layers/"$currentInput_name"
	export intermediate_materials="$se_out_tmp"/_intermediate/materials/"$currentInput_name"
	export intermediate_materials_sch="$se_out_tmp"/_intermediate/materials_sch/"$currentInput_name"
	
	mkdir -p "$intermediate_materials_sch"
	mkdir -p "$se_out"/_intermediate/materials_sch/"$currentInput_name"
	
	local anticipated_attribsFile
	anticipated_attribsFile=$(_findDir "$currentInput")
	anticipated_attribsFile="$anticipated_attribsFile"/attribs
	if ! [[ -e "$anticipated_attribsFile" ]]
	then
		_messagePlain_bad 'fail: BOM generation without attribs file currently not supported!'
		_stop 1
	fi
	
	_messagePlain_probe_cmd gnetlist -g bom2 "$currentInput" -o "$intermediate_materials_sch"/machineBOM-complete.txt
	tail -n +2 "$intermediate_materials_sch"/machineBOM-complete.txt > "$intermediate_materials_sch"/machineBOM-pure.txt
	
	_messagePlain_probe_cmd gnetlist -g bom "$currentInput" -o "$intermediate_materials_sch"/"$currentInput_name".bom
	
	
	
	_geda_compile_intermediate_materials_sch_comprehensive
	
	
	_geda_compile_materials_sch
	
	cp "$intermediate_materials_sch"/* "$se_out"/_intermediate/materials_sch/"$currentInput_name"/
}



