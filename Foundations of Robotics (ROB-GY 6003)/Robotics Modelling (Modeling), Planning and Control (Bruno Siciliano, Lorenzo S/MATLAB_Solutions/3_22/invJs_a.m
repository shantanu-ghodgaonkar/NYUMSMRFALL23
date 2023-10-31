function dq = invJs_a(w)
%INVJS_A Joint velocity with Jacobian inverse for SCARA manipulator.
%        dq = INVJS_A(w) returns joint velocity as:
%
%        dq = inv(J_a(w(5:8))*w(1:4)
%
%        where:
%
%        w(5:8)=[a(1)*c_1;a(2)*c_12;a(1)*s_1;a(2)*s_12]

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

Ja = Js_a(w(5:8));

dq(1:2) = Ja(1:2,1:2)\w(1:2);
dq(3) = w(3);
dq(4) = w(4) - dq(1) - dq(2);
