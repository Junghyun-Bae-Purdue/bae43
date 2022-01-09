
%__________________________________________________________________________
%
%                                 Function
%                        In and Out Scattering Angle
%__________________________________________________________________________
%
%   This is a function to compute in and out muon angle
%   And the scattered angle from the in/out angles
%
%==========================================================================

function ScattAng = InOutAngle(p1,p2,p3,p4)

AngXZ_in  = atan(abs(p2(3)-p1(3))/abs(p2(1)-p1(1)));
AngXZ_out = atan(abs(p4(3)-p3(3))/abs(p4(1)-p3(1)));

AngYZ_in = atan(abs(p2(3)-p1(3))/abs(p2(2)-p1(2)));
AngYZ_out = atan(abs(p4(3)-p3(3))/abs(p4(2)-p3(2)));

DiffAngXZ = abs(AngXZ_in - AngXZ_out);
DiffAngYZ = abs(AngYZ_in - AngYZ_out);

ScattAng = sqrt(DiffAngXZ^2 + DiffAngYZ^2);
end

%===============================  END  ====================================

