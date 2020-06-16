_geda_compile_materials() {
	true
}


_geda_compile_materials_sch() {
	true
	
	_geda_compile_materials_sch_bom
	
	#_check_geda_intermediate_all
	
	
	#local currentSpecific_work
	#currentSpecific_work="$safeTmp"/_specific/cad/"$currentInput_name"
	#mkdir -p "$currentSpecific_work"
	
	
	
	
	
	
	
	
	#"$intermediate_materials_sch"/machineBOM-complete.txt
	#"$intermediate_materials_sch"/machineBOM-pure.txt
	
	#"$intermediate_materials"/"$currentInput_name"-mil.xy
	#"$intermediate_materials"/"$currentInput_name"-in.xy
	#"$intermediate_materials"/"$currentInput_name"-mm.xy
	
	
	
	
	
	
	
	
	
	#"$intermediate_layers"/"$currentInput_name".bottom.gbr
	#"$intermediate_layers"/"$currentInput_name".bottommask.gbr
	#"$intermediate_layers"/"$currentInput_name".bottompaste.gbr
	#"$intermediate_layers"/"$currentInput_name".bottomsilk.gbr
	#"$intermediate_layers"/"$currentInput_name".fab.gbr
	
	#"$intermediate_layers"/"$currentInput_name".group1.gbr
	#"$intermediate_layers"/"$currentInput_name".group2.gbr
	#"$intermediate_layers"/"$currentInput_name".group3.gbr
	#"$intermediate_layers"/"$currentInput_name".group4.gbr
	
	# Usually 'spare' layer. Warn if present.
	#"$intermediate_layers"/"$currentInput_name".group7.gbr
	
	#"$intermediate_layers"/"$currentInput_name".outline.gbr
	#"$intermediate_layers"/"$currentInput_name".plated-drill.cnc
	#"$intermediate_layers"/"$currentInput_name".top.gbr
	#"$intermediate_layers"/"$currentInput_name".topmask.gbr
	#"$intermediate_layers"/"$currentInput_name".toppaste.gbr
	#"$intermediate_layers"/"$currentInput_name".topsilk.gbr

	
	#mkdir -p "$se_out"/cad/"$currentInput_name"/
	#cp "$currentSpecific_work"/* "$se_out"/cad/"$currentInput_name"/
	
	
	
	
	
	_geda_compile_materials_sch_pcbway
	
	
	_geda_compile_materials_sch_geometry
}










