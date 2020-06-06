#Redundant within scope. Required by any subshell operations (eg. _compile).
_import_ops_geda_sketch() {
	if [[ -e "$se_sketchDir"/ops ]]
	then
		_messagePlain_nominal 'sketch ops: found: sketch ops'
		. "$se_sketchDir"/ops
	fi
	
	if [[ -e "$se_sketchDir"/ops.sh ]]
	then
		_messagePlain_nominal 'sketch ops: found: sketch ops'
		. "$se_sketchDir"/ops.sh
	fi
	
	! [[ -e "$se_sketchDir"/ops ]] && ! [[ -e "$se_sketchDir"/ops.sh ]] && _messagePlain_warn 'sketch ops: missing: sketch ops' && return 1
	
	#_messagePlain_warn 'sketch ops: missing: sketch ops'
	#return 1
	
	return 0
}



