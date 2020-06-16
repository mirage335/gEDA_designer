

_vector_pcb_30MHzLowPass() {
	_start
	
	mkdir -p "$safeTmp"/vector/30MHzLowPass
	_instance_internal "$scriptLib"/vector/30MHzLowPass/. "$safeTmp"/vector/30MHzLowPass/
	
	cd "$safeTmp"/vector/30MHzLowPass
	
	pcb -x gerber --all-layers --name-style fixed --gerberfile 30MHzLowPass 30MHzLowPass.pcb
	
	local currentHash
	currentHash=$(cat 30MHzLowPass.top.gbr 30MHzLowPass.topmask.gbr 30MHzLowPass.toppaste.gbr 30MHzLowPass.topsilk.gbr 30MHzLowPass.outline.gbr 30MHzLowPass.plated-drill.cnc | grep -v '^G04' | md5sum | head -c 12)
	_messagePlain_probe "$currentHash"
	
	
	
	# DANGER ONLY add hashes from versions known to produce ALL valid outputs for ALL packages . Test completely.
	
	# 4.2.0
	[[ "$currentHash" == "f7d076b647a0" ]] && return 0
	
	
	_messageFAIL
	_stop 1
}

_vector_pcb_vector_usb_led() {
	_start
	
	mkdir -p "$safeTmp"/vector/vector_usb_led
	_instance_internal "$scriptLib"/vector/vector_usb_led/. "$safeTmp"/vector/vector_usb_led/
	
	cd "$safeTmp"/vector/vector_usb_led
	
	pcb -x gerber --all-layers --name-style fixed --gerberfile usb_led usb_led.pcb
	
	local currentHash
	currentHash=$(cat usb_led.top.gbr usb_led.topmask.gbr usb_led.toppaste.gbr usb_led.topsilk.gbr usb_led.outline.gbr usb_led.plated-drill.cnc | grep -v '^G04' | md5sum | head -c 12)
	_messagePlain_probe "$currentHash"
	
	
	
	# DANGER ONLY add hashes from versions known to produce ALL valid outputs for ALL packages . Test completely.
	
	# 4.2.0
	[[ "$currentHash" == "53771fc5b86f" ]] && return 0
	
	
	_messageFAIL
	_stop 1
}



_vector_sch_30MHzLowPass() {
	_start
	
	mkdir -p "$safeTmp"/vector/30MHzLowPass
	_instance_internal "$scriptLib"/vector/30MHzLowPass/. "$safeTmp"/vector/30MHzLowPass/
	
	cd "$safeTmp"/vector/30MHzLowPass
	
	gnetlist -g bom 30MHzLowPass.sch -o 30MHzLowPass_1.bom > /dev/null
	gnetlist -g bom2 30MHzLowPass.sch -o 30MHzLowPass_2.bom > /dev/null
	
	local currentHash
	currentHash=$(cat 30MHzLowPass_1.bom 30MHzLowPass_2.bom | md5sum | head -c 12)
	_messagePlain_probe "$currentHash"
	
	
	
	
	# DANGER ONLY add hashes from versions known to produce ALL valid outputs for ALL packages . Test completely.
	
	# 4.2.0
	[[ "$currentHash" == "5dccdd13a79d" ]] && return 0
	
	
	_messageFAIL
	_stop 1
}

_vector_sch_vector_usb_led() {
	_start
	
	mkdir -p "$safeTmp"/vector/vector_usb_led
	_instance_internal "$scriptLib"/vector/vector_usb_led/. "$safeTmp"/vector/vector_usb_led/
	
	cd "$safeTmp"/vector/vector_usb_led
	
	gnetlist -g bom usb_led.sch -o usb_led_1.bom > /dev/null 2>&1
	gnetlist -g bom2 usb_led.sch -o usb_led_2.bom > /dev/null 2>&1
	
	local currentHash
	currentHash=$(cat usb_led_1.bom usb_led_2.bom | md5sum | head -c 12)
	_messagePlain_probe "$currentHash"
	
	
	
	# DANGER ONLY add hashes from versions known to produce ALL valid outputs for ALL packages . Test completely.
	
	# 4.2.0
	[[ "$currentHash" == "d41d8cd98f00" ]] && return 0
	
	
	_messageFAIL
	_stop 1
}


_vector_pcb() {
	! "$scriptAbsoluteLocation" _vector_pcb_30MHzLowPass && _stop 1
	! "$scriptAbsoluteLocation" _vector_pcb_vector_usb_led && _stop 1
	return 0
}
_vector_sch() {
	! "$scriptAbsoluteLocation" _vector_sch_30MHzLowPass && _stop 1
	! "$scriptAbsoluteLocation" _vector_sch_vector_usb_led && _stop 1
	return 0
}


_vector_prog() {
	! "$scriptAbsoluteLocation" _vector_pcb && _stop 1
	! "$scriptAbsoluteLocation" _vector_sch && _stop 1
	return 0
}


_test_prog_imagemagick_limit_command() {
	identify -limit width 64KP -limit height 64KP -limit list-length 16EP -limit area 6GP -limit memory 2GiB -limit map 3GiB -limit disk 96GiB -limit file 768 -limit thread 2 -limit throttle 0 -limit time 2764800 "$@"
}

_test_prog_imagemagick_limit_check() {
	! _test_prog_imagemagick_limit_command -list resource | grep 'Width: 64KP' > /dev/null 2>&1 && return 1
	! _test_prog_imagemagick_limit_command -list resource | grep 'Height: 64KP' > /dev/null 2>&1 && return 1
	
	! _test_prog_imagemagick_limit_command -list resource | grep 'List length: 16EP' > /dev/null 2>&1 && return 1
	
	! _test_prog_imagemagick_limit_command -list resource | grep 'Area: 6GP' > /dev/null 2>&1 && return 1
	
	! _test_prog_imagemagick_limit_command -list resource | grep 'Memory: 2GiB' > /dev/null 2>&1 && return 1
	! _test_prog_imagemagick_limit_command -list resource | grep 'Map: 3GiB' > /dev/null 2>&1 && return 1
	! _test_prog_imagemagick_limit_command -list resource | grep 'Disk: 96GiB' > /dev/null 2>&1 && return 1
	! _test_prog_imagemagick_limit_command -list resource | grep 'File: 768' > /dev/null 2>&1 && return 1
	
	! _test_prog_imagemagick_limit_command -list resource | grep 'Thread: 2' > /dev/null 2>&1 && return 1
	
	! _test_prog_imagemagick_limit_command -list resource | grep 'Throttle: 0' > /dev/null 2>&1 && return 1
	
	! _test_prog_imagemagick_limit_command -list resource | grep 'Time: 2764800' > /dev/null 2>&1 && return 1
	
	return 0
}


_test_prog_imagemagick_limit() {
	#ImageMagick 'security' policy very inappropriately protects 'users' from consuming their own resources as needed.
	#A daemon could have allowed webservers to request limits on their own users, sane defaults could have been used without restriction, or typical web server accounts could have been limited by default.
	#Debian default in particular can be far too restrictive for processing PCB panel photolithography images at 24in dimension and 1mil/10um resolution .
	sudo -n find /etc -path '*ImageMagick*' -name 'policy.xml' -exec cp "$scriptLib"/imagemagick_policy/policy.xml '{}' \;
	
	! _test_prog_imagemagick_limit_check && _messagePlain_warn 'fail: imagemagick: limits: ignored'
	
	
	return 0
}


_test_prog() {
	_getDep gschem
	_getDep gsch2pcb
	_getDep pcb
	
	_getDep gnetlist
	
	_getDep gerbv
	
	
	
	_getDep inkscape
	
	
	_getDep pstoedit
	
	if pstoedit 2>&1 | grep 'version 3.73' > /dev/null 2>&1
	then
		_messagePlain_warn 'warn: pstoedit: version: missing or broken 3.73 cannot convert eps to dxf'
		_messagePlain_request 'request: remove all pstoedit packages and replace with pstoedit version 3.75 from '"'"_lib/optional"'"' '
	fi
	
	
	
	_getDep convert
	_getDep composite
	
	
	_test_prog_imagemagick_limit
	
	
	
	_getDep libreoffice
	
	
	_getDep zip
	
	
	
	
	! echo \$123 | grep -E '^\$[0-9]|^\.[0-9]' > /dev/null 2>&1 && _messageFAIL && return 1
	! echo \.123 | grep -E '^\$[0-9]|^\.[0-9]' > /dev/null 2>&1 && _messageFAIL && return 1
	echo 123 | grep -E '^\$[0-9]|^\.[0-9]' > /dev/null 2>&1 && _messageFAIL && return 1
	
	
	
	
	_messageNormal 'Vector (prog)...'
	_vector_prog
	_messagePASS
	
	return 0
}

_setup_prog() {
	#true
	
	
	return 0
}

