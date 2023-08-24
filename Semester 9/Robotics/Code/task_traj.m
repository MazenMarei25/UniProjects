function [Task_Space]= task_traj(X0, Xf, Tf, Ts)
%% Variable Description
% X0 : Intital end effector coordiantes : x , y and z (Vector)
% Xf : Final end effector coordiantes : x , y and z (Vector)
% Tf : Trajctory Duration (no more than 10 sec)
% Ts : Sampling Time (0.1 seconds)
% count : Index counter 

%% Variable Declaration  
count = 1 ; % Intermediate Variables 
%% Calculate intial conditions 
% To calculate (c) "Offset" and (r) "radius" of the circle 
% X0(1) :  Set x_t at its intial pos 
% X0(2) :  Set y_t at its initial pos 

alpha = (Xf(1)-X0(1))/Tf ; 
beta =  (Xf(2)-X0(2))/Tf ; 
gama =  (Xf(3)-X0(3))/Tf ; 

%% Calculate x,y,z for each time stamp from T0 to Tf at 0.1 sampling time

for t = 0: Ts : Tf 
% Index MUST be an integer value : count variable was created to count the
% indcies of the loop 
% Calculate x , y and z at each time stamp and stor their values in a vect.

Task_Space(count,1) = X0(1) + alpha*t ;
Task_Space(count,2) = X0(2) + beta*t ;
Task_Space(count,3) = X0(3) + gama*t ; 
count = count + 1 ;

end 

end 