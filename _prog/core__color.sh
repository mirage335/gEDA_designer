# DANGER: Arbitrary color-code schemes for point-to-point wiring do NOT necessarily prioritize signal integrity or conform to any standard (eg. PatchRap)!

# ATTENTION: All wire layers top side, "jump" layer bottom side.
# ATTENTION: Intentionally compatible with similar 8-wire color coding layer schemes, to allow immediate conversion.
# WARNING: Requires PCB layout to adhere strictly to 8-wire color coded layer scheme.
# WARNING: Point-to-point layouts requiring wire pairing (ie. twisting/shielding) should explicitly specify this.
# P1W1		WBl - White Blue
# P1W2		Bl - Blue
# P2W3		WO - White Orange
# P2W4		O - Orange
# P3W5		WG - White Green
# P3W6		G - Green
# P4W7		WBr - White Brown
# P4W8		Br - Brown
# "outline"
# "jump"
# "exclude1"
# "exclude2"


# WARNING: Typical PatchRap assignments mentioned only as example of signal integrity preservation scheme.
# 3 / 1 - P3W5		WG - White Green		Vsys/Vcc
# 3 \ 2 - P3W6		G - Green			pGND/sGnd
# 2 - 3 - P2W3		WO - White Orange		Vext/Vmid/Avcc/SigAlt	(NC)								(LO)
# 1 / 4 - P1W2		Bl - Blue			Sig-/SigTx-		(sGND)				(Dir)		(I2C, UART)	
# 1 \ 5 - P1W1		WBl - White Blue		Sig+/SigTx+		(COM,ANA,Probe)			(Step)		(I2C, UART)	(IF)
# 2 - 6 - P2W4		O - Orange			sGND			(NO)
# 4 / 7 - P4W7		WBr - White Brown		PWMalternate/SigRx+	(Control, Servo, Heater)	(I2C,UART)			(RF)
# 4 \ 8 - P4W8		Br - Brown			PWMdirect/SigRx-	(Fan)				(I2C,UART)



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


_pcb_color_config() {
	local current_pcbColorSchemeWiringDiagram
	current_pcbColorSchemeWiringDiagram="$1"
	[[ "$current_pcbColorSchemeWiringDiagram" == "" ]] && current_pcbColorSchemeWiringDiagram=T568A
	
	export specialArgs_pcb
	
	if [[ "$current_pcbColorSchemeWiringDiagram" == "rainbow" ]] || [[ "$current_pcbColorSchemeWiringDiagram" == "EIA" ]] || [[ "$current_pcbColorSchemeWiringDiagram" == "RETMA" ]] || [[ "$current_pcbColorSchemeWiringDiagram" == "RTMA" ]] || [[ "$current_pcbColorSchemeWiringDiagram" == "RMA" ]] || [[ "$current_pcbColorSchemeWiringDiagram" == "RMA" ]]
	then
		# Common 'rainbow' jumper and ribbon cable colors.
		
		# https://en.wikipedia.org/wiki/Ribbon_cable#Color-coding
		# https://en.wikipedia.org/wiki/Electronic_color_code
		# Brown, red, orange, yellow, green, blue, purple, grey, white, black .
		# ATTENTION: Brown is pin 1.
		# WARNING: White (X5_W09) color could be mistaken for far side layer.
		specialArgs_pcb+=( --layer-color-1 "#884C31" --layer-color-2 "#CA3109" --layer-color-3 "#C46A07" --layer-color-4 "#CAB83F" --layer-color-5 "#0E8C8F" --layer-color-6 "#11599E" --layer-color-7 "#5A415D" --layer-color-8 "#999594" --layer-color-9 "#CCCCCC" --layer-color-10 "#595959" )
		
		# Additional layers typically invalid, as cables are bundles of smaller numbers of wires, and color codes are repeated for each bundle.
		specialArgs_pcb+=( --layer-color-11 "#CFE6B8" --layer-color-12 "#CFB8E6" )
	fi
	
	if [[ "$current_pcbColorSchemeWiringDiagram" == "wirewrap" ]]
	then
		# Typical 'wirewrap' colors.
		
		# https://en.wikipedia.org/wiki/Wire_wrap
		# https://en.wikipedia.org/wiki/Electronic_color_code
		# Blue, Yellow, Violet, Green, Orange, Brown/White, Red, Black.
		# Blue, Yellow as first two layers (Bottom, Top, respectively).
		# Violet, Green, Orange, Brown/White, as subsequent arbitrary layers.
		# Red, Black as logic power, or subsequent arbitrary layers.
		specialArgs_pcb+=( --layer-color-1 "#246F9B" --layer-color-2 "#D2B831" --layer-color-3 "#8276AA" --layer-color-4 "#379966" --layer-color-5 "#D76B2F" --layer-color-6 "#7C4E3B" --layer-color-7 "#9B3025" --layer-color-8 "#595959" )
		
		# Additional layers typically invalid, as cables are bundles of smaller numbers of wires, and color codes are repeated for each bundle.
		specialArgs_pcb+=( --layer-color-9 "#E6B8B8" --layer-color-10 "#E6DAB8" --layer-color-11 "#CFE6B8" --layer-color-12 "#CFB8E6" )
	fi
	
	
	
	if [[ "$current_pcbColorSchemeWiringDiagram" == "T568A" ]]
	then
		# Standard 'T568A' colors commonly used by Ethernet/Telephone cable.
		
		specialArgs_pcb+=( --layer-color-1 "#6666FF" --layer-color-2 "#0000A6" --layer-color-3 "#FFCC66" --layer-color-4 "#A66F00" --layer-color-5 "#66FF66" --layer-color-6 "#00A600" --layer-color-7 "#8C4F31" --layer-color-8 "#592C16" )
		
		# Additional layers typically invalid, as cables are bundles of smaller numbers of wires, and color codes are repeated for each bundle.
		specialArgs_pcb+=( --layer-color-9 "#E6B8B8" --layer-color-10 "#E6DAB8" --layer-color-11 "#CFE6B8" --layer-color-12 "#CFB8E6" )
	fi
}

_pcb_color_config_exclude() {
	export specialArgs_pcb
	
	#"outline - #001819 or #191919
	#"jump" - #404040
	#"exclude1" - #330000
	#"exclude2" - #332600
	specialArgs_pcb+=( --layer-color-13 "#001819" --layer-color-14 "#404040" --layer-color-15 "#330000" --layer-color-16 "#332600" )
}


# "$1" == "$current_pcbColorSchemeWiringDiagram"
# shift
# "$@" == pcb "${specialArgs_pcb[@]}" "$@"
# _pcb_color "T568A" ./file.pcb
_pcb_color_procedure() {
	local current_pcbColorSchemeWiringDiagram
	current_pcbColorSchemeWiringDiagram="$1"
	[[ "$current_pcbColorSchemeWiringDiagram" == "" ]] && current_pcbColorSchemeWiringDiagram=T568A
	shift
	
	export specialArgs_pcb
	specialArgs_pcb=()
	
	_pcb_color_config "$current_pcbColorSchemeWiringDiagram"
	_pcb_color_config_custom "$current_pcbColorSchemeWiringDiagram"
	_pcb_color_config_exclude "$current_pcbColorSchemeWiringDiagram"
	
	pcb "${specialArgs_pcb[@]}" "$@"
}

# Unusual. Typically used to temporarily set atypical wiring colors, possibly to accommodate scrap or specialized (eg. high-temperature, fiber optic) wire.
_pcb_color_project() {
	local current_project_dir
	
	export sharedHostProjectDir=''
	_virtUser "$@"
	current_project_dir="$sharedHostProjectDir"
	
	if [[ -e "$current_project_dir"/ops ]]
	then
		_messagePlain_nominal 'project ops: found: project ops'
		. "$current_project_dir"/ops
	fi
	
	if [[ -e "$current_project_dir"/ops.sh ]]
	then
		_messagePlain_nominal 'project ops: found: project ops'
		. "$current_project_dir"/ops.sh
	fi
	
	if ! [[ -e "$current_project_dir"/ops ]] && ! [[ -e "$current_project_dir"/ops.sh ]] && _messagePlain_warn 'project ops: missing: project ops'
	then
		# && return 1
		true
	fi
	
	_pcb_color_procedure "$@"
}

_pcb_color_T568A() {
	_pcb_color_project "T568A" "$@"
}
_pcb_color_ethernet() {
	_pcb_color_project "T568A" "$@"
}

_pcb_color_rainbow() {
	_pcb_color_project "rainbow" "$@"
}

_pcb_color_wirewrap() {
	_pcb_color_project "wirewrap" "$@"
}


_pcb_color_custom() {
	_pcb_color_project "custom" "$@"
}


_pcb_color() {
	_pcb_color_T568A "$@"
}



