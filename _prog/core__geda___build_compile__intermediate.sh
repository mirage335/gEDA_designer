
_check_geda_intermediate_all() {
	local anticipated_attribsFile
	anticipated_attribsFile=$(_findDir "$currentInput")
	anticipated_attribsFile="$anticipated_attribsFile"/attribs
	if ! [[ -e "$anticipated_attribsFile" ]]
	then
		# Comprehensive attribs file is expected to have been provided by "_in_overlay" regardless of any other attribs file.
		_messagePlain_bad 'fail: unexpected: missing: attribs file!'
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



