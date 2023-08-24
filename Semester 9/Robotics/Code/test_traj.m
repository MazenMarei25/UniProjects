%% Objective : 
% Given the XYZ cooridnates from trajectory , find the required angles from
% the inverse position kinematics equation 
syms q1 q2 q3 q4


X01 = [15 0 0]; X02 = [31 0 0]; X03 = [30 0 10]; X04 = [15 0 0];
Xf1 = [30 0 0]; Xf2 = [31 0 10]; Xf3 = [15 0 10]; Xf4 = [15 0 0]; 
Tf1 = 4 ; Tf2 = 1 ; Tf3 = 2 ; Tf4 = 1 ;
Ts = 1;

side_1 = task_traj(X01, Xf1, Tf1, Ts) ;
[m,n] = size(side_1);

intial_guess_1 = [0; 0; 0; 0]; 

a = inverse_kinematics_func(intial_guess_1 , side_1(1,:).') ;
b = inverse_kinematics_func(a , side_1(2,:).') ;
c = inverse_kinematics_func(b , side_1(3,:).') ;
d = inverse_kinematics_func(c , side_1(4,:).') ;
e = inverse_kinematics_func(d , side_1(5,:).') ;
ass = rad2deg([a,b,c,d,e]);
f = forward_kinematics_func();

% for i = 1:5
%     A(:,i) = eval(simplifyFraction(subs(f,[q1 q2 q3 q4],[ass(1,i) ass(2,i) ass(3,i) ass(4,i)])))
% end

% for i =1 : (m) 
% angles_1(:,i) = inverse_kinematics_func(intial_guess_1 , side_1(i,:).') ;
% %intial_guess_1 = angles_1(:,i);
% end


% intial_guess_2 ;
% side_2 = task_traj(X02, Xf2, Tf2, Ts) ;
% for j =1 : (m) 
% angles_2(:,j) = inverse_kinematics_func(intial_guess_2 , side_2(j,:).') ;
% intial_guess_2 = angles_2(:,j);
% end


% 
% side_3 = task_traj(X03, Xf3, Tf3, Ts) ;
% 
% 
% 
% 
% 
% side_4 = task_traj(X04, Xf4, Tf4, Ts) ;


% grid on 
% hold on 
% plot(side_1(:,1),side_1(:,3))
% plot(side_2(:,1),side_2(:,3))
% plot(side_3(:,1),side_3(:,3))
% plot(side_4(:,1),side_4(:,3))

