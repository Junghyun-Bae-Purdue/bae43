
%__________________________________________________________________________
%
%                                Function
%                        Point of Closest Approach 
%__________________________________________________________________________
%
%   This is a function to calculate the PoCA point between two lines
%   Two lines are defined by (p1, p2) and (p3, p4).
%                            ^^^^^^^^     ^^^^^^^^ 
%                             Line #1      Line #2
%
%   INPUT: (p1, p2, p3, p4) which are four 3D points "(x,y,z)".
%
%==========================================================================
function Coord = PoCA(p1,p2,p3,p4)

ROI_X_min = -300;         % Region of Interest_X_minimum [mm]
ROI_X_max =  300;         % Region of Interest_X_minimum [mm]
ROI_Y_min = -300;         % Region of Interest_Y_minimum [mm]
ROI_Y_max =  300;         % Region of Interest_Y_minimum [mm]
ROI_Z_min = -200;         % Region of Interest_Z_minimum [mm]
ROI_Z_max =  200;         % Region of Interest_Z_minimum [mm]
clear N
N = 60;                  % Number of Line segments

A = p1 - p2;
B = p3 - p4;
u1 = A/norm(A);
u2 = B/norm(B);
x = linspace(ROI_X_min, ROI_X_max, N);    % Extrapolation line range 
y = linspace(ROI_Y_min, ROI_Y_max, N);    % Extrapolation line range
z = linspace(ROI_Z_min, ROI_Z_max, N);    % In between two middle detectors (#2 and #3)
P1 = p2 + [x y z]' * u1;        % Generates points in the Line #1
P2 = p3 + [x y z]' * u2;        % Generates points in the Line #2
Dist = zeros(N,N);              % Generate Distance matrix

for i = 1 : N
    for j = 1 : N 
        Dist(i,j) = sqrt(sum((P1(i,:) - P2(j,:)) .^ 2));    
        % OR -> dist = norm(P1(i,:)-P2(j,:)) 
        % Distance Matrix looks like:
 %       
 %         | dist(P1(1), P2(1)) dist(P1(1), P2(2)) ... dist(P1(1), P2(N)) |
 % Dist =  | dist(P1(2), P2(1)) dist(P1(2), P2(2)) ... dist(P1(2), P2(N)) |
 %         |         ...               ...                    ...        
 %         | dist(P1(N), P2(1)) dist(P1(N), P2(2)) ... dist(P1(N), P2(N)) |

    end
end

clear i j

for i = 1 : N
    for j = 1 : N 
%       This is the process to find the minimum distance and its location.
        if Dist(i,j) == min(Dist,[],'all')
            MinDist1 = i;   % This number indicates the position in Line 1
            MinDist2 = j;   % This number indicates the position in Line 2
        else
            continue;
        end
    end
end

PA = P1(MinDist1,:);   % Position that has a minimum distance in Line 1
PB = P2(MinDist2,:);   % Position that has a minimum distance in Line 2

Coord = [(PA(1)+PB(1))/2 (PA(2)+PB(2))/2 (PA(3)+PB(3))/2]; % Midpoint of PA and PB

%plot3(P1(:,1), P1(:,2), P1(:,3))
%hold on
%plot3(P2(:,1), P2(:,2), P2(:,3))
%grid on

end

%===============================  END  ====================================

