function y=outputLayerActivation(code,x)
  if code==0
    y=x;
  elseif code==1
    y=sigmoid(x);
  endif
endfunction