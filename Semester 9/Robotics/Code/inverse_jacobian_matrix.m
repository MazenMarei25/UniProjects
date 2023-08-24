function J_inv = inverse_jacobian_matrix(q)
J = jacobian_matrix(q) ;
J_inv = pinv(J);
end