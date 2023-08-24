function J_dot = jacobian_derivative(q,q_dot)
syms q1 q2 q3 q4 q1d q2d q3d q4d;

J = jacobian_matrix(q1,q2,q3,q4);
a1 = diff(J(1,1),q1)*q1d+diff(J(1,1),q2)*q2d+diff(J(1,1),q3)*q3d+diff(J(1,1),q4)*q4d;
a2 = diff(J(1,2),q1)*q1d+diff(J(1,2),q2)*q2d+diff(J(1,2),q3)*q3d+diff(J(1,2),q4)*q4d;
a3 = diff(J(1,3),q1)*q1d+diff(J(1,3),q2)*q2d+diff(J(1,3),q3)*q3d+diff(J(1,3),q4)*q4d;
a4 = diff(J(1,4),q1)*q1d+diff(J(1,4),q2)*q2d+diff(J(1,4),q3)*q3d+diff(J(1,4),q4)*q4d;

b1 = diff(J(2,1),q1)*q1d+diff(J(2,1),q2)*q2d+diff(J(2,1),q3)*q3d+diff(J(2,1),q4)*q4d;
b2 = diff(J(2,2),q1)*q1d+diff(J(2,2),q2)*q2d+diff(J(2,2),q3)*q3d+diff(J(2,2),q4)*q4d;
b3 = diff(J(2,3),q1)*q1d+diff(J(2,3),q2)*q2d+diff(J(2,3),q3)*q3d+diff(J(2,3),q4)*q4d;
b4 = diff(J(2,4),q1)*q1d+diff(J(2,4),q2)*q2d+diff(J(2,4),q3)*q3d+diff(J(2,4),q4)*q4d;

c1 = diff(J(3,1),q1)*q1d+diff(J(3,1),q2)*q2d+diff(J(3,1),q3)*q3d+diff(J(3,1),q4)*q4d;
c2 = diff(J(3,2),q1)*q1d+diff(J(3,2),q2)*q2d+diff(J(3,2),q3)*q3d+diff(J(3,2),q4)*q4d;
c3 = diff(J(3,3),q1)*q1d+diff(J(3,3),q2)*q2d+diff(J(3,3),q3)*q3d+diff(J(3,3),q4)*q4d;
c4 = diff(J(3,4),q1)*q1d+diff(J(3,4),q2)*q2d+diff(J(3,4),q3)*q3d+diff(J(3,4),q4)*q4d;

a= [a1;a2;a3;a4];
b= [b1;b2;b3;b4];
c= [c1;c2;c3;c4];

J_dot = [a;b;c];
J_dot = subs(J_dot,[q1,q2,q3,q4,q1d,q2d,q3d,q4d],...
    [q(1),q(2),q(3),q(4),q_dot(1),q_dot(2),q_dot(3),q_dot ...
    (4)]);

end