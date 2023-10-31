function dq = dagcJ_p(w)
%DAGCJ_P Joint velocity with Jacobian pseudo-inverse and constraint.
%        dq =DAGCJ_P(w) returns joint velocity for a three-link planar arm as:
%
%        dq = Jdag*v+(I-Jdag*Jp)*dq_a
%
%        where:
%
%        Jdag=Jp'*inv(Jp*Jp')
%        v=w(4:5)
%        Jp=J_p(w(6:11))
%        dq_a=w(1:3)
%        w(6:11)=[a(1)*c_1;a(2)*c_12;a(3)*c_123;a(1)*s_1;a(2)*s_12;a(3)*s_123]

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

Jp = J_p(w(6:11));
Jdag = Jp'/(Jp*Jp');
dq = Jdag*w(4:5) + (eye(3,3) - Jdag*Jp)*w(1:3);
