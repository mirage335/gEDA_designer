
_vector_prog() {
	true
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
	
	
	_getDep zip
	
	
	
	
	_vector_prog
	
	return 0
}

_setup_prog() {
	#true
	
	
	return 0
}

