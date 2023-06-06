# Defined in - @ line 1
function prequal --wraps='sbprequal -copy-to-sbs -opened -cfg autosar -levels check_coverage_test -session-priority 2' --description 'alias prequal=sbprequal -copy-to-sbs -opened -cfg autosar -levels check_coverage_test -session-priority 2'
  sbprequal -copy-to-sbs -opened -cfg autosar -levels check_coverage_test -session-priority 2 $argv;
end
