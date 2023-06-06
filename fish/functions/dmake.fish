# Defined in - @ line 1
function dmake --wraps='sbmake -distcc DEBUG=1' --description 'alias dmake=sbmake -distcc DEBUG=1'
  sbmake -distcc DEBUG=1 $argv;
end
