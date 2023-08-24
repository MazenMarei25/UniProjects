function q = inverse_kinematics_func(q0,X) 
%X is the desired x,y,z coordinates
%q0 is the initial guess
syms q1 q2 q3 q4

f = forward_kinematics_func();
fq_num  = subs(f,[q1,q2,q3,q4],[q0(1),-q0(2),q0(3),q0(4)]) - X ;
display(eval(fq_num))

J_inv = inverse_jacobian_matrix(q0);
display(J_inv)

qPrevious = q0;
qCurrent = qPrevious - (J_inv*fq_num);
display(eval(qCurrent))

while(qCurrent - qPrevious >= 10e-3)
    qPrevious = qCurrent;
%     display()
    qCurrent = qPrevious - (inverse_jacobian_matrix(qPrevious)*...
        (subs(f,[q1,q2,q3,q4],[qPrevious(1),-qPrevious(2),qPrevious(3),qPrevious(4)]) - X));
    
end
display(eval(qCurrent))
q = eval(qCurrent);

end