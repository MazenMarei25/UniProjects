function V_F = forward_velocity_kinematics(q,q_dot)
J = jacobian_matrix(q);
V_F = J*q_dot;
end