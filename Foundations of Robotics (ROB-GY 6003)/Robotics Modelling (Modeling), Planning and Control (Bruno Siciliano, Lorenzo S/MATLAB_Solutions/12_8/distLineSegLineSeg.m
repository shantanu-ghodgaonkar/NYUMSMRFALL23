function d=distLineSegLineSeg(P,Q)
%The algorithm was inspiread by the technique explained at:
%http://homepage.univie.ac.at/Franz.Vesely/notes/hard_sticks/hst/hst.html
%REMARK: I consider only the 2D case!
%The algorithm consider the case of parallel segments and null length segments
% Here I use m and n for respectively for gamma and delta

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

%P=[p0;p1]
%Q=[q0;q1]
%p0,p1 are the initial and final points of segment P
%q0, q1 are the initial and final points of segment Q
%p0=[xp0,yp0] point coordinates (analogously for Q)
p0=P(1,:);
p1=P(2,:);
q0=Q(1,:);
q1=Q(2,:);

%Parametrizes the segments as intervals on the axis defined by versors eP and eQ
lP = norm(p0-p1);    %norm is the euclidean norm (distance between two points)
lQ = norm(q0-q1);

if lP && lQ %if both segments have non zero length

    eP = (p1-p0) / lP;
    eQ = (q1-q0) / lQ;


    % Finds intersection point (m0,n0) between axis (using parameters m and n)
    if rank([eP',-eQ'])==2  %is segments are not parallel
        O=linsolve([eP',-eQ'],(q0-p0)');

        m0=O(1); n0=O(2);

        %Intersez = p0+m0*eP;    %intersection point in cartesian coordinates
        
        % Both segments can be defined as an interval for the parameters m and n
        infP=-m0; supP=-m0+lP;
        infQ=-n0; supQ=-n0+lQ;

        %In this interval it finds the points of the segments whose distance is minimum
        %These point are defined usin the parameters m and n
        if infP*supP<0 && infQ*supQ<0 %if the origin belongs to the interval
            %this appens if the segments intersect
            d=0;
        else
            %I find the extreme of the interval nearest to the origin
            V = [infP,supP];
            [C I] = min(abs(V));
            mInf = C*sign(V(I));
            V = [infQ,supQ];
            [C I] = min(abs(V));
            nInf = C*sign(V(I));

            mMin = nInf*dot(eP,eQ);
            if infP <= mMin && mMin <= supP     %if is a minimum in the interval of m
                d1 = mMin^2 + nInf^2 - 2*mMin*nInf*dot(eP,eQ);
            else
                if infP > mMin
                d1 = infP^2 + nInf^2 - 2*infP*nInf*dot(eP,eQ);
                else %if supP < mMin
                d1 = supP^2 + nInf^2 - 2*supP*nInf*dot(eP,eQ);
                end
            end

            nMin = mInf*dot(eP,eQ);
            if infQ <= nMin && nMin <= supQ     %if is a minimum in the interval of n
                d2 = mInf^2 + nMin^2 - 2*mInf*nMin*dot(eP,eQ);
            else
                if infQ > nMin
                    d2 = mInf^2 + infQ^2 - 2*mInf*infQ*dot(eP,eQ);
                else %if supQ < nMin
                   d2 = mInf^2 + supQ^2 - 2*mInf*supQ*dot(eP,eQ); 
                end
            end

            d = sqrt(min(d1,d2));

        end
    else %rank([eP',-eQ'])==1 paralel segments
        l = norm(p0-q0);
        if l==0
            d=0;
        else
            ed = (p0-q0)/l;   %the particular pair of ending points is irrelevant
            proj_p0 = min([dot(p0,eP),dot(p1,eP)]);     
            proj_p1 = max([dot(p0,eP),dot(p1,eP)]);
            proj_q0 = min([dot(q0,eP),dot(q1,eP)]);         %remark: eP==eQ
            proj_q1 = max([dot(q0,eP),dot(q1,eP)]);
            if (proj_p0 < proj_q0 && proj_q0 < proj_p1) || (proj_q0 < proj_p0 && proj_p0 < proj_q1)
                d = l*sqrt(1-dot(eP,ed)^2);   %if the projection are overlapping (remind: segments parallel)
            else %if not the minimum distance is between ending points of the segmnets
                d = min([norm(p0-q0),norm(p0-q1),norm(p1-q0),norm(p1-q1)]);
            end
        end
    end
else % ~(lP && lQ) if one segments is a null length segment
    if lQ == 0 && lP == 0%if both segments have null length
        d = norm(p0-q0);
    else
        if lQ == 0
            H=Q;
            K=P;
            lK=lP;
        else    % lP == 0
            H=P;
            K=Q;
            lK=lQ;
        end

        h0=H(1,:);  %remark: k0==k1
        k0=K(1,:);
        k1=K(2,:);
        eK=(k1-k0)/lK;

        l = norm(h0-k0);
        if l==0
            d=0;
        else
            ed = (h0-k0)/l;   %with k1 it would be the same
            proj_h0 = dot(h0,eK);
            proj_k1 = max([dot(k0,eK),dot(k1,eK)]);
            proj_k0 = min([dot(k0,eK),dot(k1,eK)]);
            if (proj_k0 < proj_h0 && proj_h0 < proj_k1)
                d = l*sqrt(1-dot(eK,ed)^2);   %if the projection are overlapping
            else
                d = min([norm(h0-k0),norm(h0-k1)]);
            end
        end
    end
end



