


_geda_compile_XY_line_comprehensive() {
	#echo '#refdes,footprint,value,description,cost,device,mfr,mfrpn,dst,dstpn,link,link_page,supplier,sbapn,kitting,kitting_d,Xpos,Ypos,rot,side' > "$intermediate_materials_sch"/"$currentInput_name"-mil.xy
	echo "$refdes,$footprint,$value,$description,$cost,$device,$mfr,$mfrpn,$dst,$dstpn,$link,$link_page,$supplier,$sbapn,$kitting,$kitting_d,$Xpos,$Ypos,$rot,$side"
}


#"$1" == xyfile (comprehensive, exported by 'pcb')
#"$2" == bom (comprehensive, exported by 'gnetlist')
#"$3" == out
#shift
#shift
#shift
#"$@" == line write echo (function)
# EXAMPLE
#echo '#refdes,footprint,value,description,cost,device,mfr,mfrpn,dst,dstpn,link,link_page,supplier,sbapn,kitting,kitting_d,Xpos,Ypos,rot,side' > ./test.out
#_geda_compile_XY ./test-mil.xy ./test-sch.bom ./test.out _geda_compile_XY_line_comprehensive
_geda_compile_XY() {
	[[ "$1" == "" ]] && return 1
	[[ "$2" == "" ]] && return 1
	[[ "$3" == "" ]] && return 1
	
	local currentFile_xy
	currentFile_xy="$1"
	
	local currentFile_bom
	currentFile_bom="$2"
	
	local currentFile_out
	currentFile_out="$3"
	
	shift
	shift
	shift
	
	local currentLine_xy
	local currentLine_bom
	
	
	! [[ -e "$currentFile_xy" ]] && return 1
	! [[ -e "$currentFile_bom" ]] && return 1
	
	while read currentLine_xy
	do
		if ! echo "$currentLine_xy" | grep '^[^#\;]' > /dev/null && [[ "$currentLine_xy" != "" ]]
		then
			continue
		fi
		
		refdes=$(echo "$currentLine_xy" | cut -d ',' -f1)
		footprint=$(echo "$currentLine_xy" | cut -d ',' -f2)
		value=$(echo "$currentLine_xy" | cut -d ',' -f3)
		Xpos=$(echo "$currentLine_xy" | cut -d ',' -f4)
		Ypos=$(echo "$currentLine_xy" | cut -d ',' -f5)
		rot=$(echo "$currentLine_xy" | cut -d ',' -f6)
		side=$(echo "$currentLine_xy" | cut -d ',' -f7)
		
		while read currentLine_bom
		do
			
			if ! echo "$currentLine_bom" | cut -f1 | grep "$refdes" > /dev/null
			then
				continue
			fi
			
			description=$(echo "$currentLine_bom" | cut -f4)
			
			cost=$(echo "$currentLine_bom" | cut -f5)
			
			device=$(echo "$currentLine_bom" | cut -f6)
			mfr=$(echo "$currentLine_bom" | cut -f7)
			mfrpn=$(echo "$currentLine_bom" | cut -f8)
			dst=$(echo "$currentLine_bom" | cut -f9)
			dstpn=$(echo "$currentLine_bom" | cut -f10)
			link=$(echo "$currentLine_bom" | cut -f11)
			link_page=$(echo "$currentLine_bom" | cut -f12)
			
			supplier=$(echo "$currentLine_bom" | cut -f13)
			sbapn=$(echo "$currentLine_bom" | cut -f14)
			kitting=$(echo "$currentLine_bom" | cut -f15)
			kitting_d=$(echo "$currentLine_bom" | cut -f16)
			
			nobom=$(echo "$currentLine_bom" | cut -f17)
			noplace=$(echo "$currentLine_bom" | cut -f18)
			
			
		done < "$currentFile_bom"
		
		if [[ $noplace != "true" ]]
		then
			"$@" >> "$currentFile_out"
		fi
		
		unset refdes footprint value description cost device mfr mfrpn dst dstpn link link_page supplier sbapn kitting kitting_d Xpos Ypos rot side
		
		
	done < "$currentFile_xy"
	
	sed -i 's/,unknown/,/g' "$currentFile_out"
	
	
	[[ ! -e "$currentFile_out" ]] && return 1
	return 0
}



_geda_compile_intermediate_materials_sch_comprehensive() {
	_check_geda_intermediate_all
	
	
	echo '#refdes,footprint,value,description,cost,device,mfr,mfrpn,dst,dstpn,link,link_page,supplier,sbapn,kitting,kitting_d,Xpos,Ypos,rot,side' > "$intermediate_materials_sch"/"$currentInput_name"-mil.xy
	_geda_compile_XY "$intermediate_materials"/"$currentInput_name"-mil.xy "$intermediate_materials_sch"/"$currentInput_name".bom "$intermediate_materials_sch"/"$currentInput_name"-mil.xy _geda_compile_XY_line_comprehensive
	
	
	echo '#refdes,footprint,value,description,cost,device,mfr,mfrpn,dst,dstpn,link,link_page,supplier,sbapn,kitting,kitting_d,Xpos,Ypos,rot,side' > "$intermediate_materials_sch"/"$currentInput_name"-in.xy
	_geda_compile_XY "$intermediate_materials"/"$currentInput_name"-in.xy "$intermediate_materials_sch"/"$currentInput_name".bom "$intermediate_materials_sch"/"$currentInput_name"-in.xy _geda_compile_XY_line_comprehensive
	
	echo '#refdes,footprint,value,description,cost,device,mfr,mfrpn,dst,dstpn,link,link_page,supplier,sbapn,kitting,kitting_d,Xpos,Ypos,rot,side' > "$intermediate_materials_sch"/"$currentInput_name"-mm.xy
	_geda_compile_XY "$intermediate_materials"/"$currentInput_name"-mm.xy "$intermediate_materials_sch"/"$currentInput_name".bom "$intermediate_materials_sch"/"$currentInput_name"-mm.xy _geda_compile_XY_line_comprehensive
	
}





