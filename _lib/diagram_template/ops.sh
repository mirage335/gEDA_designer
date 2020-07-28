# ATTENTION: Override with 'ops' or similar. Example color schemes included within '_pcb_color_config' function.
_pcb_color_config_custom() {
	local current_pcbColorSchemeWiringDiagram
	current_pcbColorSchemeWiringDiagram="$1"
	[[ "$current_pcbColorSchemeWiringDiagram" == "" ]] && current_pcbColorSchemeWiringDiagram=T568A
	
	export specialArgs_pcb
	
	# Specified 'custom' colors.
	if [[ "$current_pcbColorSchemeWiringDiagram" == "custom" ]]
	then
		# Standard 'T568A' colors commonly used by Ethernet/Telephone cable.
		
		specialArgs_pcb+=( --layer-color-1 "#6666FF" --layer-color-2 "#0000A6" --layer-color-3 "#FFCC66" --layer-color-4 "#A66F00" --layer-color-5 "#66FF66" --layer-color-6 "#00A600" --layer-color-7 "#8C4F31" --layer-color-8 "#592C16" )
		
		# Additional layers typically invalid, as cables are bundles of smaller numbers of wires, and color codes are repeated for each bundle.
		specialArgs_pcb+=( --layer-color-9 "#E6B8B8" --layer-color-10 "#E6DAB8" --layer-color-11 "#CFE6B8" --layer-color-12 "#CFB8E6" )
	fi
}
