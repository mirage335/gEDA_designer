
_geda_compile_intermediate_layers() {
	
	mkdir -p "$se_out_tmp"/_intermediate/layers/"$currentInput_name"
	mkdir -p "$se_out"/_intermediate/layers/"$currentInput_name"
	
	#pcb -x gerber --all-layers --name-style fixed --gerberfile ./_build/30MHzLowPass ./30MHzLowPass.pcb
	pcb -x gerber --all-layers --name-style fixed --gerberfile "$se_out_tmp"/_intermediate/layers/"$currentInput_name"/"$currentInput_name" "$currentInput"
	
	cp "$se_out_tmp"/_intermediate/layers/"$currentInput_name"/* "$se_out"/_intermediate/layers/"$currentInput_name"/
	
}

