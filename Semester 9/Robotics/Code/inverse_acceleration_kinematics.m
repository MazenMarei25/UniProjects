function q_double_dot = inverse_acceleration_kinematics(q,q_dot,A_F)
J = jacobian_matrix(q);
J_inv = inverse_jacobian_matrix(J);
J_dot = jacobian_derivative(q,q_dot);
q_double_dot = J_inv*(A_F - J_dot*q_dot);


end