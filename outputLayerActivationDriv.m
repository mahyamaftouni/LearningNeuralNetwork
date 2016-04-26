function y=outputLayerActivationDriv(code,x)
  if code==0
    y=1;
  elseif code==1
    y=drivSigmoid(x);
  endif
endfunction