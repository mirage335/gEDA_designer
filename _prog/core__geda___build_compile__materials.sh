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
	
	
	
}









_geda_compile_XY_line_pcbway() {
	refdes=$(echo "$refdes" | sed 's/,/;/g')
	echo "$refdes,$footprint,$value,$description,$cost,$device,$mfr,$mfrpn,$dst,$dstpn,$link,$link_page,$supplier,$sbapn,$kitting,$kitting_d,$Xpos,$Ypos,$rot,$side"
}

_geda_compile_bom_line_pcbway() {
	refdes=$(echo "$refdes" | sed 's/,/;/g')
	echo "$refdes,$footprint,$value,$description,$cost,$device,$mfr,$mfrpn,$dst,$dstpn,$link,$link_page,$supplier,$sbapn,$kitting,$kitting_d,$nobom,$noplace,$qty"
}


_geda_compile_materials_sch_pcbway() {
	_messageNormal "Compile: PCBWay"
	cd "$se_in_tmp"
	_check_geda_intermediate_all
	
	local currentSpecific_work
	currentSpecific_work="$safeTmp"/_specific/pcbway/"$currentInput_name"
	mkdir -p "$currentSpecific_work"
	
	
	# TODO: Correctly name and select out gerber files.
	
	
	
	echo '#refdes,footprint,value,description,cost,device,mfr,mfrpn,dst,dstpn,link,link_page,supplier,sbapn,kitting,kitting_d,Xpos,Ypos,rot,side' > "$currentSpecific_work"/"$currentInput_name"-mil.xy
	_geda_compile_XY "$intermediate_materials_sch"/"$currentInput_name".bom "$intermediate_materials"/"$currentInput_name"-mil.xy "$currentSpecific_work"/"$currentInput_name"-mil.xy _geda_compile_XY_line_pcbway
	
	echo 'refdes,footprint,value,description,cost,device,mfr,mfrpn,dst,dstpn,link,link_page,supplier,sbapn,kitting,kitting_d,nobom,noplace,qty' > "$currentSpecific_work"/"$currentInput_name".bom
	_geda_compile_bom "$intermediate_materials_sch"/machineBOM-pure.txt "" "$currentSpecific_work"/"$currentInput_name".bom _geda_compile_bom_line_pcbway
	
	
	
	mkdir -p "$currentSpecific_work"/package
	[[ "$currentSpecific_work" == "" ]] && _stop 1
	[[ ! -e "$currentSpecific_work"/package ]] && _stop 1
	cd "$currentSpecific_work"/package
	rm -f "$currentSpecific_work"/package/*.zip > /dev/null 2>&1
	
	cp "$currentSpecific_work"/"$currentInput_name"-mil.xy "$currentSpecific_work"/package/
	cp "$currentSpecific_work"/"$currentInput_name".bom "$currentSpecific_work"/package/
	
	zip -r "$currentInput_name" .
	cd "$se_in_tmp"
	
	
	
	mkdir -p "$se_out"/pcbway/"$currentInput_name"/
	#cp "$currentSpecific_work"/package/* "$se_out"/pcbway/"$currentInput_name"/
	cp "$currentSpecific_work"/package/*.zip "$se_out"/pcbway/"$currentInput_name"/
	
	
	cd "$se_in_tmp"
	_messageNormal "Compile: PCBWay: end"
}

