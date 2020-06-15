



_package_geda_compile_materials_sch_pcbway() {
	_safeRMR "$currentSpecific_work"/package
	mkdir -p "$currentSpecific_work"/package
	cp "$currentSpecific_work"/*.gbr "$currentSpecific_work"/package/ > /dev/null 2>&1
	cp "$currentSpecific_work"/*.G*L "$currentSpecific_work"/package/ > /dev/null 2>&1
	cp "$currentSpecific_work"/*.cnc "$currentSpecific_work"/package/ > /dev/null 2>&1
	cp "$currentSpecific_work"/"$currentInput_name"-mil.xy "$currentSpecific_work"/package/ > /dev/null 2>&1
	cp "$currentSpecific_work"/"$currentInput_name".bom "$currentSpecific_work"/package/ > /dev/null 2>&1
	cp "$currentSpecific_work"/*.xlsx "$currentSpecific_work"/package/ > /dev/null 2>&1
}




_geda_compile_XY_line_pcbway() {
	refdes=$(echo "$refdes" | sed 's/,/;/g')
	#echo "$refdes,$footprint,$value,$description,$cost,$device,$mfr,$mfrpn,$dst,$dstpn,$link,$link_page,$supplier,$sbapn,$kitting,$kitting_d,$Xpos,$Ypos,$rot,$side"
	echo "$refdes,$footprint,$value,$description,$cost,$device,$mfr,$mfrpn,$dst,$dstpn,$link,$link_page,$kitting,$kitting_d,$Xpos,$Ypos,$rot,$side"
}

_geda_compile_bom_line_pcbway() {
	refdes=$(echo "$refdes" | sed 's/,/;/g')
	#echo "$refdes,$footprint,$value,$description,$cost,$device,$mfr,$mfrpn,$dst,$dstpn,$link,$link_page,$supplier,$sbapn,$kitting,$kitting_d,$nobom,$noplace,$qty"
	echo "$refdes,$footprint,$value,$description,$cost,$device,$mfr,$mfrpn,$dst,$dstpn,$link,$link_page,$kitting,$kitting_d,$nobom,$noplace,$qty"
}


_geda_compile_materials_sch_pcbway_format_layers() {
	local currentLayer
	local currentLayer_name
	local currentLayer_number
	local currentMaxLayer
	currentMaxLayer=32
	export currentTotalLayer
	
	
	# Derived from 'generate-gerbers.sh' developed by Shawn Nock under MIT license. See '_lib/generate-gerbers' for details.
	#cat usb_led.group1.gbr | head -n10 | grep 'G04' | sed -n -e '/Title/s/.*, \([^\*]*\).*/\1/p'
	# Rename inner layers.
	_messagePlain_nominal '_geda_compile_materials_sch_pcbway: package'
	cp "$intermediate_layers"/* "$currentSpecific_work"/
	currentTotalLayer=2
	cd "$se_in_tmp"
	for currentLayer in `seq 1 "$currentMaxLayer"`; do
		if [[ -e "$currentSpecific_work"/"$currentInput_name".group"$currentLayer".gbr ]]; then
			mv "$currentSpecific_work"/"$currentInput_name".group"$currentLayer".gbr "$currentSpecific_work"/"$currentInput_name".G$(("$currentLayer_number"+2))L
			currentLayer_number=$(( "$currentLayer_number"+1 ))
		fi
		[[ -e "$currentSpecific_work"/"$currentInput_name".G"$currentLayer"L ]] && let currentTotalLayer="$currentTotalLayer"+1
	done
	_messagePlain_probe_var currentTotalLayer
	currentTotalLayer=2
	for currentLayer in `seq 1 "$currentMaxLayer"`; do
		if [[ -e "$currentSpecific_work"/"$currentInput_name".G"$currentLayer"L ]] && [[ $(stat -c%s "$currentSpecific_work"/"$currentInput_name".G"$currentLayer"L) -lt 2500 ]]; then
			currentLayer_name=$(cat "$currentSpecific_work"/"$currentInput_name".G"$currentLayer"L  | head -n10 | grep 'G04' | sed -n -e '/Title/s/.*, \([^\*]*\).*/\1/p')
			_messagePlain_warn 'warn: Layer '"'""$currentLayer_name""'"' probably empty .'
			#rm -f "$currentSpecific_work"/"$currentInput_name".G"$currentLayer"L
		fi
		[[ -e "$currentSpecific_work"/"$currentInput_name".G"$currentLayer"L ]] && let currentTotalLayer="$currentTotalLayer"+1
	done
	[[ $(( "$currentTotalLayer" % 2 )) = 1 ]] && _messagePlain_bad 'caution: Non-standard layer count '"$currentTotalLayer"' . Rarely intentional, consider removing unused layers!'
	_messagePlain_probe_var currentTotalLayer
	_package_geda_compile_materials_sch_pcbway
	cd "$currentSpecific_work"/package
	rm -f "$se_out"/pcbway/"$currentInput_name"/"$currentInput_name".zip > /dev/null 2>&1
	zip -r "$se_out"/pcbway/"$currentInput_name"/"$currentInput_name" .
	cd "$se_in_tmp"
}

_geda_compile_materials_sch_pcbway() {
	_messageNormal "Compile: PCBWay"
	cd "$se_in_tmp"
	_check_geda_intermediate_all
	
	mkdir -p "$se_out"/pcbway/"$currentInput_name"/
	
	local currentSpecific_work
	currentSpecific_work="$safeTmp"/_specific/pcbway/"$currentInput_name"
	mkdir -p "$currentSpecific_work"
	
	mkdir -p "$currentSpecific_work"/package
	[[ "$currentSpecific_work" == "" ]] && _stop 1
	[[ ! -e "$currentSpecific_work"/package ]] && _stop 1
	
	
	_messagePlain_nominal '_geda_compile_materials_sch_pcbway: bom'
	#echo '#refdes,footprint,value,description,cost,device,mfr,mfrpn,dst,dstpn,link,link_page,supplier,sbapn,kitting,kitting_d,Xpos,Ypos,rot,side' > "$currentSpecific_work"/"$currentInput_name"-mil.xy
	echo '#refdes,footprint,value,description,cost,device,mfr,mfrpn,dst,dstpn,link,link_page,kitting,kitting_d,Xpos,Ypos,rot,side' > "$currentSpecific_work"/"$currentInput_name"-mil.xy
	_geda_compile_XY "$intermediate_materials_sch"/"$currentInput_name".bom "$intermediate_materials"/"$currentInput_name"-mil.xy "$currentSpecific_work"/"$currentInput_name"-mil.xy _geda_compile_XY_line_pcbway
	
	#echo 'refdes,footprint,value,description,cost,device,mfr,mfrpn,dst,dstpn,link,link_page,supplier,sbapn,kitting,kitting_d,nobom,noplace,qty' > "$currentSpecific_work"/"$currentInput_name".bom
	echo 'refdes,footprint,value,description,cost,device,mfr,mfrpn,dst,dstpn,link,link_page,kitting,kitting_d,nobom,noplace,qty' > "$currentSpecific_work"/"$currentInput_name".bom
	_geda_compile_bom "$intermediate_materials_sch"/machineBOM-pure.txt "" "$currentSpecific_work"/"$currentInput_name".bom _geda_compile_bom_line_pcbway
	
	
	cd "$currentSpecific_work"
	cp "$currentSpecific_work"/"$currentInput_name"-mil.xy "$currentSpecific_work"/"$currentInput_name"-mil.xy.csv
	libreoffice --headless --convert-to xlsx:"Calc MS Excel 2007 XML" "$currentSpecific_work"/"$currentInput_name"-mil.xy.csv
	rm -f "$currentSpecific_work"/"$currentInput_name"-mil.xy.csv
	
	cp "$currentSpecific_work"/"$currentInput_name".bom "$currentSpecific_work"/"$currentInput_name".bom.csv
	libreoffice --headless --convert-to xlsx:"Calc MS Excel 2007 XML" "$currentSpecific_work"/"$currentInput_name".bom.csv
	rm -f "$currentSpecific_work"/"$currentInput_name".bom.csv
	cd "$se_in_tmp"
	
	
	_messagePlain_nominal '_geda_compile_materials_sch_pcbway: layers'
	
	
	
	
	local currentLayer
	local currentLayer_name
	local currentLayer_number
	local currentMaxLayer
	currentMaxLayer=32
	export currentTotalLayer
	local currentLowerLimit
	local currentUpperLimit
	
	
	_geda_compile_materials_sch_pcbway_format_layers
	
	
	# Six Layer .
	# 8 == 2-7 .
	# 7 == 2-6
	# Preserve 2-3 and 5-6 .
	# 6 == 2-5 .
	# Preserve 2-3 and 4-5 .
	if [[ "$currentTotalLayer" -ge 6 ]]
	then
		_messagePlain_nominal '_geda_compile_materials_sch_pcbway: package: sixLayer'
		_messagePlain_probe_var currentTotalLayer
		if [[ "$currentTotalLayer" -gt 6 ]]
		then
			let currentLowerLimit=4
			let currentUpperLimit="$currentTotalLayer"-3
			for currentLayer in `seq "$currentLowerLimit" "$currentUpperLimit"`; do
				rm -f "$currentSpecific_work"/"$currentInput_name".G"$currentLayer"L
			done
		fi
		_package_geda_compile_materials_sch_pcbway
		cd "$currentSpecific_work"/package
		rm -f "$se_out"/pcbway/"$currentInput_name"/"$currentInput_name"-sixLayer.zip > /dev/null 2>&1
		zip -r "$se_out"/pcbway/"$currentInput_name"/"$currentInput_name"-sixLayer .
		cd "$se_in_tmp"
	fi
	
	
	# Four Layer .
	if [[ "$currentTotalLayer" -ge 4 ]]
	then
		_messagePlain_nominal '_geda_compile_materials_sch_pcbway: package: fourLayer'
		_messagePlain_probe_var currentTotalLayer
		if [[ "$currentTotalLayer" -gt 4 ]]
		then
			let currentLowerLimit=3
			let currentUpperLimit="$currentTotalLayer"-2
			for currentLayer in `seq "$currentLowerLimit" "$currentUpperLimit"`; do
				rm -f "$currentSpecific_work"/"$currentInput_name".G"$currentLayer"L
			done
		fi
		_package_geda_compile_materials_sch_pcbway
		cd "$currentSpecific_work"/package
		rm -f "$se_out"/pcbway/"$currentInput_name"/"$currentInput_name"-fourLayer.zip > /dev/null 2>&1
		zip -r "$se_out"/pcbway/"$currentInput_name"/"$currentInput_name"-fourLayer .
		cd "$se_in_tmp"
	fi
	
	
	# Two Layer .
	if [[ "$currentTotalLayer" -ge 2 ]]
	then
		_messagePlain_nominal '_geda_compile_materials_sch_pcbway: package: twoLayer'
		_messagePlain_probe_var currentTotalLayer
		if [[ "$currentTotalLayer" -gt 2 ]]
		then
			let currentLowerLimit=2
			let currentUpperLimit="$currentTotalLayer"-1
			for currentLayer in `seq "$currentLowerLimit" "$currentUpperLimit"`; do
				rm -f "$currentSpecific_work"/"$currentInput_name".G"$currentLayer"L
			done
		fi
		_package_geda_compile_materials_sch_pcbway
		cd "$currentSpecific_work"/package
		rm -f "$se_out"/pcbway/"$currentInput_name"/"$currentInput_name"-twoLayer.zip > /dev/null 2>&1
		zip -r "$se_out"/pcbway/"$currentInput_name"/"$currentInput_name"-twoLayer .
		cd "$se_in_tmp"
	fi
	
	
	
	_geda_compile_materials_sch_pcbway_format_layers
	
	
	# Delete empty layers.
	_messagePlain_nominal '_geda_compile_materials_sch_pcbway: package: noempty'
	currentTotalLayer=2
	cd "$se_in_tmp"
	for currentLayer in `seq 1 "$currentMaxLayer"`; do
		if [[ -e "$currentSpecific_work"/"$currentInput_name".G"$currentLayer"L ]] && [[ $(stat -c%s "$currentSpecific_work"/"$currentInput_name".G"$currentLayer"L) -lt 2500 ]]; then
			currentLayer_name=$(cat "$currentSpecific_work"/"$currentInput_name".G"$currentLayer"L  | head -n10 | grep 'G04' | sed -n -e '/Title/s/.*, \([^\*]*\).*/\1/p')
			_messagePlain_warn 'warn: Layer '"'""$currentLayer_name""'"' probably empty .'
			rm -f "$currentSpecific_work"/"$currentInput_name".G"$currentLayer"L
		fi
		[[ -e "$currentSpecific_work"/"$currentInput_name".G"$currentLayer"L ]] && let currentTotalLayer="$currentTotalLayer"+1
	done
	_messagePlain_probe_var currentTotalLayer
	_package_geda_compile_materials_sch_pcbway
	cd "$currentSpecific_work"/package
	rm -f "$se_out"/pcbway/"$currentInput_name"/"$currentInput_name"_noempty.zip > /dev/null 2>&1
	zip -r "$se_out"/pcbway/"$currentInput_name"/"$currentInput_name"_noempty .
	cd "$se_in_tmp"
	
	
	# Six Layer .
	# 8 == 2-7 .
	# 7 == 2-6
	# Preserve 2-3 and 5-6 .
	# 6 == 2-5 .
	# Preserve 2-3 and 4-5 .
	if [[ "$currentTotalLayer" -ge 6 ]]
	then
		_messagePlain_nominal '_geda_compile_materials_sch_pcbway: package: noempty-sixLayer'
		_messagePlain_probe_var currentTotalLayer
		if [[ "$currentTotalLayer" -gt 6 ]]
		then
			let currentLowerLimit=4
			let currentUpperLimit="$currentTotalLayer"-3
			for currentLayer in `seq "$currentLowerLimit" "$currentUpperLimit"`; do
				rm -f "$currentSpecific_work"/"$currentInput_name".G"$currentLayer"L
			done
		fi
		_package_geda_compile_materials_sch_pcbway
		cd "$currentSpecific_work"/package
		rm -f "$se_out"/pcbway/"$currentInput_name"/"$currentInput_name"_noempty-sixLayer.zip > /dev/null 2>&1
		zip -r "$se_out"/pcbway/"$currentInput_name"/"$currentInput_name"_noempty-sixLayer .
		cd "$se_in_tmp"
	fi
	
	
	# Four Layer .
	if [[ "$currentTotalLayer" -ge 4 ]]
	then
		_messagePlain_nominal '_geda_compile_materials_sch_pcbway: package: noempty-fourLayer'
		_messagePlain_probe_var currentTotalLayer
		if [[ "$currentTotalLayer" -gt 4 ]]
		then
			let currentLowerLimit=3
			let currentUpperLimit="$currentTotalLayer"-2
			for currentLayer in `seq "$currentLowerLimit" "$currentUpperLimit"`; do
				rm -f "$currentSpecific_work"/"$currentInput_name".G"$currentLayer"L
			done
		fi
		_package_geda_compile_materials_sch_pcbway
		cd "$currentSpecific_work"/package
		rm -f "$se_out"/pcbway/"$currentInput_name"/"$currentInput_name"_noempty-fourLayer.zip > /dev/null 2>&1
		zip -r "$se_out"/pcbway/"$currentInput_name"/"$currentInput_name"_noempty-fourLayer .
		cd "$se_in_tmp"
	fi
	
	
	# Two Layer .
	if [[ "$currentTotalLayer" -ge 2 ]]
	then
		_messagePlain_nominal '_geda_compile_materials_sch_pcbway: package: noempty-twoLayer'
		_messagePlain_probe_var currentTotalLayer
		if [[ "$currentTotalLayer" -gt 2 ]]
		then
			let currentLowerLimit=2
			let currentUpperLimit="$currentTotalLayer"-1
			for currentLayer in `seq "$currentLowerLimit" "$currentUpperLimit"`; do
				rm -f "$currentSpecific_work"/"$currentInput_name".G"$currentLayer"L
			done
		fi
		_package_geda_compile_materials_sch_pcbway
		cd "$currentSpecific_work"/package
		rm -f "$se_out"/pcbway/"$currentInput_name"/"$currentInput_name"_noempty-twoLayer.zip > /dev/null 2>&1
		zip -r "$se_out"/pcbway/"$currentInput_name"/"$currentInput_name"_noempty-twoLayer .
		cd "$se_in_tmp"
	fi
	
	
	
	
	cd "$se_in_tmp"
	mkdir -p "$se_out"/pcbway/"$currentInput_name"/
	#cp "$currentSpecific_work"/package/* "$se_out"/pcbway/"$currentInput_name"/ > /dev/null 2>&1
	cp "$currentSpecific_work"/package/*.zip "$se_out"/pcbway/"$currentInput_name"/ > /dev/null 2>&1
	
	
	cd "$se_in_tmp"
	_messageNormal "Compile: PCBWay: end"
}

