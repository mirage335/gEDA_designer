

_declare_scope_geda() {

		_scope_prog() {
		[[ "$ub_scope_name" == "" ]] && export ub_scope_name='geda'
	}


	_scope_var_here_prog() {
		cat << CZXWXcRMTo8EmM8i4d

#Global Variables and Defaults
#Sketch (Scope Current, SEssion)
export se_sketch="$se_sketch"
export se_sketchDir="$se_sketchDir"
export se_out="$se_out"

export se_basename="$se_basename"

#Debug
export se_remotePort="$se_remotePort"
export se_sym="$se_sym"

CZXWXcRMTo8EmM8i4d
	}

	_scope_attach_prog() {
		_messagePlain_nominal '_scope_attach: prog'
		
		if ! _set_geda_var "$@"
		then
			_messagePlain_bad 'fail: _set_geda_var'
			_stop 1
		fi
		
		_messagePlain_probe_var ub_specimen
		
		#_set_geda_userShortHome
		#_set_geda_editShortHome
		_set_geda_fakeHome
		
		_messagePlain_nominal '_scope_attach: prog: deploy'
		
		#_scope_command_write _true
		_scope_command_write _gEDA_designer_geometry
	}






}


# Only relevant if other tools are also supported by designer. (eg. KiCAD)
_scope_geda() {
	_declare_scope_geda
	_scope "$@"
}






