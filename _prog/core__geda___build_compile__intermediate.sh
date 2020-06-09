
_geda_compile_intermediate_layers() {
	_messagePlain_nominal 'Compile: intermediate_layers'
	export intermediate_layers="$se_out_tmp"/_intermediate/layers/"$currentInput_name"
	
	mkdir -p "$intermediate_layers"
	mkdir -p "$se_out"/_intermediate/layers/"$currentInput_name"
	
	#pcb -x gerber --all-layers --name-style fixed --gerberfile ./_build/30MHzLowPass ./30MHzLowPass.pcb
	_messagePlain_probe_cmd pcb -x gerber --all-layers --name-style fixed --gerberfile "$intermediate_layers"/"$currentInput_name" "$currentInput"
	
	cp "$intermediate_layers"/* "$se_out"/_intermediate/layers/"$currentInput_name"/
	
}

_geda_compile_intermediate_materials() {
	_messagePlain_nominal 'Compile: intermediate_materials'
	export intermediate_materials="$se_out_tmp"/_intermediate/materials/"$currentInput_name"
	
	mkdir -p "$intermediate_materials"
	mkdir -p "$se_out"/_intermediate/materials/"$currentInput_name"
	
	local anticipated_attribsFile
	anticipated_attribsFile=$(_getAbsoluteFolder "$currentInput")
	anticipated_attribsFile="$anticipated_attribsFile"/attribs
	
	#_messagePlain_probe_cmd_quoteAdd
	if [[ -e "$anticipated_attribsFile" ]]
	then
		_messagePlain_probe_cmd pcb -x bom --attrs "$anticipated_attribsFile" --bomfile "$intermediate_materials"/"$currentInput_name".bom "$currentInput"
		_messagePlain_probe_cmd pcb -x bom --attrs "$anticipated_attribsFile" --xy-unit mm --xyfile "$intermediate_materials"/"$currentInput_name"-mm.xy "$currentInput"
		_messagePlain_probe_cmd pcb -x bom --attrs "$anticipated_attribsFile" --xy-unit mil --xyfile "$intermediate_materials"/"$currentInput_name"-mil.xy "$currentInput"
	fi
	if ! [[ -e "$anticipated_attribsFile" ]]
	then
		_messagePlain_bad 'fail: BOM generation without attrs file currently not supported!'
		_stop 1
	fi
	
	cp "$intermediate_materials"/* "$se_out"/_intermediate/materials/"$currentInput_name"/
	
}




_geda_compile_intermediate_materials_sch() {
	_messagePlain_nominal 'Compile: intermediate_materials_sch'
	export intermediate_materials_sch="$se_out_tmp"/_intermediate/materials_sch/"$currentInput_name"
	
	mkdir -p "$intermediate_materials_sch"
	mkdir -p "$se_out"/_intermediate/materials_sch/"$currentInput_name"
	
	#pcb -x gerber --all-layers_sch --name-style fixed --gerberfile ./_build/30MHzLowPass ./30MHzLowPass.pcb
	#pcb -x gerber --all-layers_sch --name-style fixed --gerberfile "$intermediate_materials_sch"/"$currentInput_name" "$currentInput"
	
	_messagePlain_probe_cmd gnetlist -g bom2 ""$currentInput"" -o "$intermediate_materials_sch"/machineBOM-complete.txt
	
	tail -n +2 "$intermediate_materials_sch"/machineBOM-complete.txt > "$intermediate_materials_sch"/machineBOM-pure.txt
	
	
	
	_geda_compile_materials_sch
	
	
	
	cp "$intermediate_materials_sch"/* "$se_out"/_intermediate/materials_sch/"$currentInput_name"/
	
}



