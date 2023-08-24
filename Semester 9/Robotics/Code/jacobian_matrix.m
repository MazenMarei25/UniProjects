function J = jacobian_matrix(q)
syms q1;
syms q2;
syms q3;
syms q4;
X = forward_kinematics_func();
J_symbolic = jacobian(X,[q1,q2,q3,q4]);
J = eval (subs(J_symbolic,[q1,q2,q3,q4],[q(1),q(2),q(3),q(4)])) ;
end