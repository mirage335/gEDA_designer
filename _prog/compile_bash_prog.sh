_compile_bash_deps_prog() {
	true
}

#Default is to include all, or run a specified configuration. For this reason, it will be more typical to override this entire function, rather than append any additional code.
# WARNING Find current version of this function at "build/bash/compile_bash.sh"
# _compile_bash_deps() {
# 	[[ "$1" == "lean" ]] && return 0
# 	
# 	false
# }

_vars_compile_bash_prog() {
	#export configDir="$scriptAbsoluteFolder"/_config
	
	#export progDir="$scriptAbsoluteFolder"/_prog
	#export progScript="$scriptAbsoluteFolder"/ubiquitous_bash.sh
	#[[ "$1" != "" ]] && export progScript="$scriptAbsoluteFolder"/"$1"
	
	true
}

_compile_bash_header_prog() {	
	export includeScriptList
	true
}

_compile_bash_header_program_prog() {	
	export includeScriptList
	true
}

_compile_bash_essential_utilities_prog() {	
	export includeScriptList
	true
}

_compile_bash_utilities_virtualization_prog() {	
	export includeScriptList
	true
}

_compile_bash_utilities_prog() {	
	export includeScriptList
	true
}

_compile_bash_shortcuts_prog() {	
	export includeScriptList
	true
}

_compile_bash_shortcuts_setup_prog() {	
	export includeScriptList
	true
}

_compile_bash_bundled_prog() {	
	export includeScriptList
	true
}

_compile_bash_vars_basic_prog() {	
	export includeScriptList
	true
}

_compile_bash_vars_global_prog() {	
	export includeScriptList
	true
}

_compile_bash_vars_spec_prog() {	
	export includeScriptList
	true
}

_compile_bash_vars_shortcuts_prog() {	
	export includeScriptList
	true
}

_compile_bash_vars_virtualization_prog() {	
	export includeScriptList
	true
}

_compile_bash_vars_bundled_prog() {	
	export includeScriptList
	true
}

_compile_bash_buildin_prog() {	
	export includeScriptList
	true
}

_compile_bash_environment_prog() {	
	export includeScriptList
	true
}

_compile_bash_installation_prog() {	
	export includeScriptList
	true
}

_compile_bash_program_prog() {	
	export includeScriptList
	
	includeScriptList+=( core__geda___build_compile__intermediate_comprehensive.sh )
	includeScriptList+=( core__geda___build_compile__intermediate.sh )
	
	
	includeScriptList+=( core__geda_env.sh )
	includeScriptList+=( core__geda_bin_.sh )
	includeScriptList+=( core__geda.sh )
	
	includeScriptList+=( core__geda_scope.sh )
	
	includeScriptList+=( core__geda_app.sh )
	includeScriptList+=( core__geda_app_scope.sh )
	
	
	includeScriptList+=( core__geda____manufacturer__pcbway.sh )
	includeScriptList+=( core__geda____manufacturer__oshpark.sh )
	includeScriptList+=( core__geda____manufacturer__oshstencil.sh )
	#includeScriptList+=( core__geda____manufacturer_default.sh )
	
	
	includeScriptList+=( core__geda__build_ops.sh )
	includeScriptList+=( core__geda__build_ops_default.sh )
	
	
	includeScriptList+=( core__geda___build_compile_cad.sh )
	includeScriptList+=( core__geda___build_compile_bom.sh )
	
	includeScriptList+=( core__geda___build_compile__layers_oshpark.sh )
	includeScriptList+=( core__geda___build_compile__layers_oshstencil.sh )
	includeScriptList+=( core__geda___build_compile__layers.sh )
	
	includeScriptList+=( core__geda___build_compile__materials_pcbway.sh )
	includeScriptList+=( core__geda___build_compile__materials.sh )
	
	includeScriptList+=( core__geda___build_compile.sh )
	
	
	includeScriptList+=( core__geda____manufacturer_default.sh )
	
	
	#includeScriptList+=( core.sh )
	includeScriptList+=( core_default.sh )
}

_compile_bash_config_prog() {	
	export includeScriptList
	true
}

_compile_bash_selfHost_prog() {	
	export includeScriptList
	true
}

_compile_bash_overrides_prog() {	
	export includeScriptList
	true
}

_compile_bash_entry_prog() {	
	export includeScriptList
	true
}
