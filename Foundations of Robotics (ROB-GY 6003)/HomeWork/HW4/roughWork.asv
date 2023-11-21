% syms l1;
% syms l2;
% syms s1;
% syms c1;
% syms s12;
% syms c12;
% 
% j = [-l1*s1-l2*s12 -l2*s12; l1*c1+l2*c12 l2*c12];
% f = [10; 0];
% 
% t = j*f
syms c1 c2 c3 s1 s2 s3
aRb = [c1*c2*c3-s1*s3 -c1*c2*s3-s1*c3 c1*s2; s1*c2*c3+c1*s3 -s1*c2*s3+c1*c3 s1*s2; -s2*c3 s2*s3 c2]
% aRbDIFF = diff(aRb)
% aRbTPSE = transpose(aRb)
% aRbINV = aRb^-1
% aRbDIFF*aRbINV
% aRbDIFF*aRbTPSE
E = [diff(aRb(3,1))*aRb(2,1)]
