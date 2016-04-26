

#two-Layer Perceptron- with sigmoid as activation funtion. 
#one hidden layer

#1 means Sigmoid
#0 means f(x)=x
actHidden=1; 
actOut=1;
#arbitrary number of hidden units 
hidden_units_num=3;
input_units_num=8;
output_units_num=8;
learning_rate=0.2;

train_tuples_num=8;
#CREATE DUMMY TRAINING SET
inputs=zeros(train_tuples_num,input_units_num+output_units_num);
##RANDOM INPUT
#{ 
for i=1:train_tuples_num
  for j=1:input_units_num+output_units_num
    inputs(i,j)=mod(ceil(normrnd (0, 1)),2);
   endfor
endfor
#}

#AUTO ENCODER!
for i=1:train_tuples_num
    inputs(i,i)=1;
    inputs(i,i+8)=1;
endfor

inputs

#initialise weights to small random values
Input_to_Hidden_weights=zeros(input_units_num,hidden_units_num);
Hidden_to_Output_weights=zeros(hidden_units_num,output_units_num);
for i=1:input_units_num
 for j=1:hidden_units_num
    Input_to_Hidden_weights(i,j)=normrnd (0, 1/2);
 endfor
endfor

for i=1:hidden_units_num
  for j=1:output_units_num
    Hidden_to_Output_weights(i,j)=normrnd (0, 1/2);
  endfor
endfor
Input_to_Hidden_weights
Hidden_to_Output_weights
epoch_num=2500;
errors=zeros(output_units_num,epoch_num);


for e=1:epoch_num
  for t=1:train_tuples_num
    #FEEDFORWARD
    Sh=zeros(1,hidden_units_num);
    Oh=zeros(1,hidden_units_num);
    So=zeros(1,output_units_num);
     O=zeros(1,output_units_num);
   
    for i=1:input_units_num
      for j=1:hidden_units_num
        Sh(1,j)+=inputs(t,i)*Input_to_Hidden_weights(i,j);
      endfor
    endfor
    
    Oh=hiddenLayerActivation(actHidden,Sh);         
    for i=1:hidden_units_num
      for j=1:output_units_num
          So(1,j)+=Oh(1,i)*Hidden_to_Output_weights(i,j);
      endfor
    endfor
    O=outputLayerActivation(actOut,So);
    #this Stochastic Kind of learning so lets BackPropagate 
   
    deltaO=zeros(1,output_units_num);
    deltaH=zeros(1,hidden_units_num); 
    
    for i=1:output_units_num
      target=inputs(t,input_units_num+i);
      errors(i,e)+=1/2*((target-O(1,i))*(target-O(1,i)));
      deltaO(1,i)=(target-O(1,i))*outputLayerActivationDriv(actOut,So(1,i));
    endfor

    for i=1:hidden_units_num
      for j=1:output_units_num
      Hidden_to_Output_weights(i,j)+=learning_rate*deltaO(1,j)*Oh(1,i);
      deltaH(1,i)+=deltaO(1,j)*Hidden_to_Output_weights(i,j);
      endfor
      deltaH(1,i)*=hiddenLayerActivationDriv(actHidden,Sh(1,i));
    endfor

    
    for i=1:input_units_num
      for j=1:hidden_units_num
          Input_to_Hidden_weights(i,j)+=learning_rate*deltaH(1,j)*inputs(t,i);
      endfor
    endfor
    
    
    if e==epoch_num
      Oh
    endif
    
  endfor
  
endfor

i=1:1:epoch_num;
for o=1:output_units_num
  plot(errors(o,i),"linewidth",1)
  hold on
endfor

for i=1:output_units_num
  printf("%d,  %d\n",inputs(t,i+8),O(1,i))
endfor