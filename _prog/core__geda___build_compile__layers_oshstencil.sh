



_package_geda_compile_layers_oshstencil() {
	_safeRMR "$currentSpecific_work"/package
	mkdir -p "$currentSpecific_work"/package
	cp "$currentSpecific_work"/*.gbr "$currentSpecific_work"/package/ > /dev/null 2>&1
	cp "$currentSpecific_work"/*.G*L "$currentSpecific_work"/package/ > /dev/null 2>&1
	cp "$currentSpecific_work"/*.cnc "$currentSpecific_work"/package/ > /dev/null 2>&1
	cp "$currentSpecific_work"/"$currentInput_name"-mil.xy "$currentSpecific_work"/package/ > /dev/null 2>&1
	cp "$currentSpecific_work"/"$currentInput_name".bom "$currentSpecific_work"/package/ > /dev/null 2>&1
	cp "$currentSpecific_work"/*.xlsx "$currentSpecific_work"/package/ > /dev/null 2>&1
	
	cp "$currentSpecific_work"/*.gtp "$currentSpecific_work"/package/ > /dev/null 2>&1
	cp "$currentSpecific_work"/*.gbp "$currentSpecific_work"/package/ > /dev/null 2>&1
	cp "$currentSpecific_work"/*.gko "$currentSpecific_work"/package/ > /dev/null 2>&1
}





_geda_compile_layers_oshstencil() {
	_messageNormal "Compile: OSHStencil"
	cd "$se_in_tmp"
	#_check_geda_intermediate_all
	
	mkdir -p "$se_out"/oshstencil/"$currentInput_name"/
	
	local currentSpecific_work
	currentSpecific_work="$safeTmp"/_specific/oshstencil/"$currentInput_name"
	mkdir -p "$currentSpecific_work"
	
	mkdir -p "$currentSpecific_work"/package
	[[ "$currentSpecific_work" == "" ]] && _stop 1
	[[ ! -e "$currentSpecific_work"/package ]] && _stop 1
	
	
	
	_messagePlain_nominal '_geda_compile_layers_oshstencil: layers'
	
	_messagePlain_nominal '_geda_compile_layers_oshstencil: package: default - top only'
	cd "$se_in_tmp"
	rm -f "$currentSpecific_work"/* > /dev/null 2>&1
	cp "$intermediate_layers"/* "$currentSpecific_work"/
	
	# Only Paste files, for OSHStencils.
	find "$currentSpecific_work" -maxdepth 1 -type f -regextype posix-egrep -regex ".*(\.gbr|\.cnc).*" ! -regex ".*(paste|outline).*" -delete
	
	# Only TopPaste by default.
	find "$currentSpecific_work" -maxdepth 1 -type f -regextype posix-egrep -regex ".*(\.gbr|\.cnc).*" ! -regex ".*(toppaste|outline).*" -delete
	
	find "$currentSpecific_work" -maxdepth 1 -type f -regextype posix-egrep -regex ".*toppaste.*" -exec mv {} {}.gtp \;
	find "$currentSpecific_work" -maxdepth 1 -type f -regextype posix-egrep -regex ".*bottompaste.*" -exec mv {} {}.gbp \;
	find "$currentSpecific_work" -maxdepth 1 -type f -regextype posix-egrep -regex ".*outline.*" -exec mv {} {}.gko \;
	
	rm -f "$currentSpecific_work"/*.G*L* > /dev/null 2>&1
	
	_package_geda_compile_layers_oshstencil
	cd "$currentSpecific_work"/package
	rm -f "$se_out"/oshstencil/"$currentInput_name"/"$currentInput_name".zip > /dev/null 2>&1
	zip -r "$se_out"/oshstencil/"$currentInput_name"/"$currentInput_name" .
	cd "$se_in_tmp"
	
	
	
	_messagePlain_nominal '_geda_compile_layers_oshstencil: package: double - top and bottom'
	cd "$se_in_tmp"
	rm -f "$currentSpecific_work"/* > /dev/null 2>&1
	cp "$intermediate_layers"/* "$currentSpecific_work"/
	
	# Only Paste files, for OSHStencils.
	find "$currentSpecific_work" -maxdepth 1 -type f -regextype posix-egrep -regex ".*(\.gbr|\.cnc).*" ! -regex ".*(paste|outline).*" -delete
	
	# Only TopPaste by default.
	#find "$currentSpecific_work" -maxdepth 1 -type f -regextype posix-egrep -regex ".*(\.gbr|\.cnc).*" ! -regex ".*(toppaste|outline).*" -delete
	
	find "$currentSpecific_work" -maxdepth 1 -type f -regextype posix-egrep -regex ".*toppaste.*" -exec mv {} {}.gtp \;
	find "$currentSpecific_work" -maxdepth 1 -type f -regextype posix-egrep -regex ".*bottompaste.*" -exec mv {} {}.gbp \;
	find "$currentSpecific_work" -maxdepth 1 -type f -regextype posix-egrep -regex ".*outline.*" -exec mv {} {}.gko \;
	
	rm -f "$currentSpecific_work"/*.G*L* > /dev/null 2>&1
	
	_package_geda_compile_layers_oshstencil
	cd "$currentSpecific_work"/package
	rm -f "$se_out"/oshstencil/"$currentInput_name"/"$currentInput_name"-double.zip > /dev/null 2>&1
	zip -r "$se_out"/oshstencil/"$currentInput_name"/"$currentInput_name"-double .
	cd "$se_in_tmp"
	
	
	cd "$se_in_tmp"
	_messageNormal "Compile: OSHStencil: end"
}

