% sensors.m
%   Compute the output of rate gyros, accelerometers, and pressure sensors
%
%  Revised:
%   3/5/2010  - RB 
%   5/14/2010 - RB

function y = sensors(uu, P)

    % relabel the inputs
%    pn      = uu(1);
%    pe      = uu(2);
    pd      = uu(3);
%    u       = uu(4);
%    v       = uu(5);
%    w       = uu(6);
    phi     = uu(7);
    theta   = uu(8);
%    psi     = uu(9);
    p       = uu(10);
    q       = uu(11);
    r       = uu(12);
    F_x     = uu(13);
    F_y     = uu(14);
    F_z     = uu(15);
%    M_l     = uu(16);
%    M_m     = uu(17);
%    M_n     = uu(18);
    Va      = uu(19);
%    alpha   = uu(20);
%    beta    = uu(21);
%    wn      = uu(22);
%    we      = uu(23);
%    wd      = uu(24);
    defl1   = uu(25);
    defl2   = uu(26);
    defl3   = uu(27);
    
    % simulate rate gyros (units are rad/sec)
    y_gyro_x = p + randn()*P.std_gyrox;
    y_gyro_y = q + randn()*P.std_gyroy;
    y_gyro_z = r + randn()*P.std_gyroz;

    % simulate accelerometers (units of g)
%     y_accel_x = F_x/P.mass/P.gravity+sin(theta)+randn()*P.std_accelx;
%     y_accel_y = F_y/P.mass/P.gravity-cos(theta)*sin(phi)+randn()*P.std_accely;
%     y_accel_z = F_z/P.mass/P.gravity-cos(theta)*sin(phi)+randn()*P.std_accelz;
    y_accel_x = F_x/P.mass+P.gravity*sin(theta)+randn()*P.std_accelx;
    y_accel_y = F_y/P.mass-P.gravity*cos(theta)*sin(phi)+randn()*P.std_accely;
    y_accel_z = F_z/P.mass-P.gravity*cos(theta)*sin(phi)+randn()*P.std_accelz;

    % simulate pressure sensors
    y_static_pres = P.rho*P.gravity*(-pd)+P.bias_abspres+randn()*P.std_abspres;
    y_diff_pres = P.rho*Va^2/2 + P.bias_abspres+randn()*P.std_abspres;

    % construct total output
    y = [...
        y_gyro_x;...
        y_gyro_y;...
        y_gyro_z;...
        y_accel_x;...
        y_accel_y;...
        y_accel_z;...
        y_static_pres;...
        y_diff_pres;...
        defl1;...
        defl2;...
        defl3;...
    ];

end



