function X = forward_kinematics_func()
syms q1 q2 q3 q4
thetas = [q1 ; q2 ; q3+ pi/2 ; q4 + pi/2];
ds = readmatrix("DH_param.xlsx","Range",'C2:C5');
as = readmatrix("DH_param.xlsx","Range",'D2:D5');
alphas = readmatrix("DH_param.xlsx","Range",'E2:E5');

%V = eye(4) ;


V1 = transformation_func(thetas(1,1),ds(1,1),as(1,1),alphas(1,1));
V2 = transformation_func(thetas(2,1),ds(2,1),as(2,1),alphas(2,1));
V3 = transformation_func(thetas(3,1),ds(3,1),as(3,1),alphas(3,1));
V4 = transformation_func(thetas(4,1),ds(4,1),as(4,1),alphas(4,1));
V = eval(V1*V2*V3*V4);

% for i = 1 : 4
%     theta = thetas( i , 1 );
%     d = ds( i , 1 );
%     a = as( i , 1 );
%     alpha = alphas( i , 1 );
%     V = simplify(V * transformation_func(theta ,d ,a , alpha)) ;
%     display(theta)
%     display(d)
%     display(a)
%     display(alpha)
% end

X = V(1:3,4);
end
