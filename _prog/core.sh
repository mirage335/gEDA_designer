##### Core










# # ATTENTION: Add to ops!
_refresh_anchors_task() {
	true
	#cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_task_arduino_compile_blink
	#cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_task_scope_arduinoide_blink
}

_refresh_anchors_specific() {
	true
	# EXAMPLE .
	#_refresh_anchors_specific_single_procedure _gEDA_designer_out_cad
}

_refresh_anchors_user() {
	true
	# EXAMPLE .
	#_refresh_anchors_user_single_procedure _gEDA_designer_out_cad
}

_associate_anchors_request() {
	if type "_refresh_anchors_user" > /dev/null 2>&1
	then
		_tryExec "_refresh_anchors_user"
		#return
	fi
	
	# EXAMPLE .
	#_messagePlain_request 'association: dir, *.pcb'
	#echo _gEDA_designer_out_cad"$ub_anchor_suffix"
}


#duplicate _anchor
_refresh_anchors() {
	
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_scope
	
	# EXAMPLE .
	#cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_out_cad
	
	# EXAMPLE - Internal developer test function.
	#cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_out_cad_30MHzLowPass
	
	_tryExec "_refresh_anchors_task"
	
	return 0
}

