# Defined in - @ line 1
function lmake --wraps='sbmake DEBUG=1' --description 'alias lmake=sbmake DEBUG=1'
  sbmake DEBUG=1 $argv;
end
