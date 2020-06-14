





_geda_compile_bom_line_mouser() {
	! echo "$description" | grep MOUSER > /dev/null 2>&1 && return 0
	
	#refdes=$(echo "$refdes" | sed 's/,/;/g')
	#echo "$refdes,$footprint,$value,$description,$cost,$device,$mfr,$mfrpn,$dst,$dstpn,$link,$link_page,$supplier,$sbapn,$kitting,$kitting_d,$nobom,$noplace,$qty"
	
	mouserPart=$(echo "$description" | sed 's/.*["MOUSER","DigiKey"]\ //g')
	echo "$mouserPart,$qty"
	
	unset mouserPart
}


_geda_compile_bom_line_html() {
	refdes=$(echo "$refdes" | sed 's/,/|/g')
	
	mouserPart=$(echo "$description" | grep MOUSER | sed 's/.*["MOUSER","DigiKey"]\ //g')
	
	# Delimeter specified by
	#sed 's/'","'/<\/td><td>/g'
	
	echo '('"$refdes"')'",$device,$value,$footprint,$description,$qty,$cost,$mouserPart" | sed 's/^/<tr><td>/g' | sed 's/'","'/<\/td><td>/g' | sed 's/$/<\/tr>/g' | sed 's/unknown/<font color=red>unknown<\/font>/g' | sed 's/\?/<font color=red>?<\/font>/g' | sed 's/\$/<font color=green>\$<\/font>/g' | sed 's/>X\ /><font color=red>X\ <\/font>/g'
	
}


_geda_compile_materials_sch_bom() {
	_messageNormal "Compile: BOM"
	cd "$se_in_tmp"
	_check_geda_intermediate_all
	
	local currentSpecific_work
	currentSpecific_work="$safeTmp"/_specific/bom/"$currentInput_name"
	mkdir -p "$currentSpecific_work"
	
	
	
	
	
	#echo 'refdes,footprint,value,description,cost,device,mfr,mfrpn,dst,dstpn,link,link_page,supplier,sbapn,kitting,kitting_d,nobom,noplace,qty' > "$currentSpecific_work"/"$currentInput_name"-bom-mouser.csv
	_geda_compile_bom "$intermediate_materials_sch"/machineBOM-pure.txt "" "$currentSpecific_work"/"$currentInput_name"-bom-mouser.csv _geda_compile_bom_line_mouser
	
	echo '<table border=1>' >  "$currentSpecific_work"/"$currentInput_name".html
	echo '<tr><td>refdes</td><td>device</td><td>value</td><td>footprint</td><td>description</td><td>qty</td><td>cost</td><td>Mouser Part</td><td></tr>' >> "$currentSpecific_work"/"$currentInput_name".html
	_geda_compile_bom "$intermediate_materials_sch"/machineBOM-pure.txt "" "$currentSpecific_work"/"$currentInput_name".html _geda_compile_bom_line_html
	echo '</table>' >>  "$currentSpecific_work"/"$currentInput_name".html
	
	
	
	mkdir -p "$se_out"/bom/"$currentInput_name"/
	cp "$currentSpecific_work"/* "$se_out"/bom/"$currentInput_name"/
	cp "$currentSpecific_work"/*.html "$se_sketchDir"/
	
	
	
	
	
	
	
	
	cd "$se_in_tmp"
	_messageNormal "Compile: BOM: end"
}

