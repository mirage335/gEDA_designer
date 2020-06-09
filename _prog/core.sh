##### Core










# # ATTENTION: Add to ops!
_refresh_anchors_task() {
	true
	#cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_task_geometry_30MHzLowPass
}

_refresh_anchors_specific() {
	true
	
	_refresh_anchors_specific_single_procedure _gEDA_designer_geometry
}

_refresh_anchors_user() {
	true
	_refresh_anchors_user_single_procedure _gEDA_designer_geometry
}

_associate_anchors_request() {
	if type "_refresh_anchors_user" > /dev/null 2>&1
	then
		_tryExec "_refresh_anchors_user"
		#return
	fi
	
	
	_messagePlain_request 'association: dir, *.pcb'
	echo _gEDA_designer_geometry"$ub_anchor_suffix"
}


#duplicate _anchor
_refresh_anchors() {
	
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_scope
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_gEDA_designer_geometry
	
	_tryExec "_refresh_anchors_task"
	
	return 0
}

