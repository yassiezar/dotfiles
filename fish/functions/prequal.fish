# Defined in - @ line 1
function prequal --wraps='sbprequal -copy-to-sbs -opened -testsuites-cfg autosar -levels check_coverage_test -session-priority auto' --description 'alias prequal=sbprequal -copy-to-sbs -opened -testsuites-cfg autosar autosar_realtime_tests -levels check_coverage_test -session-priority auto'
  sbprequal -copy-to-sbs -opened -testsuites-cfg autosar autosar_realtime_tests -levels check_coverage_test -session-priority auto $argv;
end
