function [x_desired,x_actual] = test(q,q0)
    syms q1 q2 q3 q4
    f = forward_kinematics_func(); %Get the forward position kinematics symbolic
    fq = subs(f,[q1,q2,q3,q4], [q(1),-q(2),q(3),q(4)]); %Substitute with our input angles and get our desired coordinates aka our target cooridnates
    display(fq)
    j = inverse_kinematics_func(q0,fq); %here I generate qs for our target coordinates that supposedly will get me my desired coordinates again
    fa = subs(f,[q1,q2,q3,q4], [j(1),-j(2),j(3),j(4)]); % I feed in the generated angles from the inverse kinematics back to the forward 
    display(j);
    x_desired = eval(fq); %my desired coordinates hat i got initiallys from the forward kinematics
    x_actual = eval(fa);% computes coordinates from the angles out of the inverse kinematics
end