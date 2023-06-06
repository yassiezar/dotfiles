# Defined in - @ line 1
function gencompilecommands --wraps='sbcompilecommands -mods autosar_core -mods autosar_upstream' --description 'alias gencompilecommands=sbcompilecommands -mods autosar_core -mods autosar_upstream'
  sbcompilecommands -mods autosar_core -mods autosar_upstream $argv;
end
