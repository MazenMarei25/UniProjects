function [x,y,z] = fucn(q11,q22,q33,q44)
syms q1 q2 q3 q4

X = forward_kinematics_func();
fq = subs(X,[q1,q2,q3,q4],[q11,-q22,q33,q44]);
display(eval(fq))
x = eval(fq(1,1));
y = eval(fq(2,1));
z = eval(fq(3,1));

end