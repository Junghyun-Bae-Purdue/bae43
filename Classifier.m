%__________________________________________________________________________
%
%                               Classifier
%__________________________________________________________________________
%
%   Classifier is designed to classify muon scattering angels according to
%   the muon momentum.
%
%   Classification Steps
%   1. Identify the muon momentum range           
%   2. within this range, classify scattering angle in three levels
%   3. Save the classification number (0, 1, 2, 3)
%      0 = low density | 1 = medimum density | 2 = high density                               
%==========================================================================
%__________________________________________________________________________
%
%                 1. Muon energy to momentum conversion
%__________________________________________________________________________
%
m_mu = 105.658E-3;      % [GeV/c^2]
E_mu = muon_E/1000;     % [GeV]
p_mu = sqrt(abs(muon_E.^2-m_mu^2));
%
%__________________________________________________________________________

%__________________________________________________________________________
%
%                             2. Classification
%__________________________________________________________________________

AngPlusMuE = [Angles E_mu];     % Save scattering angles and corresponding muon energies

[i1, i2, i3, i4, i5, i6, i7] = deal(1);

%==========================================================================
% **Explanation
%
% Scan all sample muons' scattering angles and corresponding energies
% For example,
% When muon momentum < 0.2 GeV/c,
%
%       if Scattering angle < 0.1 rad   <- it means small scattering angles
%           Save 0                      <- therefore, save 0 for this
%       if 0.1 < Scattering angle < 0.2 <- it means medium scattering angle
%           Save 1                      <- therefore, save 1 for this
%       if Scattering angle > 0.2       <- it means large scattering angles
%           Save 2                      <- therefore, save 2 for this
% 
% In the same manner,
% When 0.2 < muon momentum < 1.0 Gev/c,
%       if Scattering angle < 0.05 rad   <- small scattering angles
%                             ^^^^^^^^
%       * Here, the criteria for small, medium, and large are chagned.
%           Save 0                      
%       if (same manner...)
%       (same manner...)
%       end
%
% At the end, we saved only 0, 1, or 2 in the "AngClass" 
% by considering each momentum level.
% 
% This is the script for:
%   Muon momentum measurement range and resolution
%   - Range: 0.2 ~ 13 GeV
%   - Resolution: <0.2 GeV/c, 0.2<, 1.0<, 2.0<, 3.0<, 4.0<, 5.0<.
%   - Classification level: 3 (high - medium - low)
%==========================================================================

% Scattering angles [mrad] for mateiral classifications
% M12: materials 1 & 2 threshold angles
% each columnsrepresents p = 0.5, 1.5, 2.5, 3.5, 4.5, 10.

M12 = 1E-3 * [1335 29.3 9.4 5.5 4.0 3.1 2.6];        % [rad]
M23 = 2E-3 * [3466 76.0 24.3 14.1 10.2 8.0 6.6];     % [rad]
M34 = 0.6E-3 * [13363 294.8 94.1 56.4 40.3 31.4 25.4];  % [rad]

%M12 = 1E-3 * [3132 67.7 22.1 13.3 9.5 7.4 5.9];        % [rad]
%M23 = 1E-3 * [8066 173.2 57.0 34.3 24.5 19.1 15.2];     % [rad]
%M34 = 1E-3 * [31190 671.2 220.1 132.3 94.6 73.6 58.6];  % [rad]

%M12 = 1E-3 * [4515 96.9 31.9 19.2 13.8 10.7 8.5];        % [rad]
%M23 = 1E-3 * [11587 246.6 82.1 49.5 35.4 27.6 21.6];     % [rad]
%M34 = 1E-3 * [44751 954.8 316.5 190.6 136.4 106.2 83.6];  % [rad]

for i = 1 : length(E_mu)
    
    if AngPlusMuE(i,2) <= 0.2
        AngMu1(i1,:) = AngPlusMuE(i,:);
        
            if AngMu1(i1,1) <= M12(1)
                AngClass(i) = 0;
            elseif AngMu1(i1,1) > M12(1) && AngMu1(i1,1) <= M23(1)
                AngClass(i) = 1;
            elseif AngMu1(i1,1) > M23(1) && AngMu1(i1,1) <= M34(1)
                AngClass(i) = 2;
            else
                AngClass(i) = 3;
            end
        i1 = i1 + 1;
     
    elseif AngPlusMuE(i,2) > 0.2 && AngPlusMuE(i,2) <= 1.0
        AngMu2(i2,:) = AngPlusMuE(i,:);

            if AngMu2(i2,1) <= M12(2)
                AngClass(i) = 0;
            elseif AngMu2(i2,1) > M12(2) && AngMu2(i2,1) <= M12(2)
                AngClass(i) = 1;
            elseif AngMu2(i2,1) > M23(2) && AngMu2(i2,1) <= M34(2)
                AngClass(i) = 2;
            else
                AngClass(i) = 3;
            end      
        i2 = i2 + 1;
        
    elseif AngPlusMuE(i,2) > 1.0 && AngPlusMuE(i,2) <= 2.0
        AngMu3(i3,:) = AngPlusMuE(i,:);

            if AngMu3(i3,1) <= M12(3)
                AngClass(i) = 0;
            elseif AngMu3(i3,1) > M12(3) && AngMu3(i3,1) <= M23(3)
                AngClass(i) = 1;
            elseif AngMu3(i3,1) > M23(3) && AngMu3(i3,1) <= M34(3)
                AngClass(i) = 2;
            else
                AngClass(i) = 3;
            end       
        i3 = i3 + 1;
        
    elseif AngPlusMuE(i,2) > 2.0 && AngPlusMuE(i,2) <= 3.0
        AngMu4(i4,:) = AngPlusMuE(i,:);

            if AngMu4(i4,1) <= M12(4)
                AngClass(i) = 0;
            elseif AngMu4(i4,1) > M12(4) && AngMu4(i4,1) <= M23(4)
                AngClass(i) = 1;
            elseif AngMu4(i4,1) > M23(4) && AngMu4(i4,1) <= M34(4)
                AngClass(i) = 2;
            else
                AngClass(i) = 3;
            end       
        i4 = i4 + 1;    
        
    elseif AngPlusMuE(i,2) > 3.0 && AngPlusMuE(i,2) <= 4.0
        AngMu5(i5,:) = AngPlusMuE(i,:);

            if     AngMu5(i5,1) <= M12(5)
                AngClass(i) = 0;
            elseif AngMu5(i5,1) > M12(5) && AngMu5(i5,1) <= M23(5)
                AngClass(i) = 1;
            elseif AngMu5(i5,1) > M23(5) && AngMu5(i5,1) <= M34(5)
                AngClass(i) = 2;
            else
                AngClass(i) = 3;
            end     
        i5 = i5 + 1;
        
    elseif AngPlusMuE(i,2) > 4.0 && AngPlusMuE(i,2) <= 5.0
        AngMu6(i6,:) = AngPlusMuE(i,:);

            if AngMu6(i6,1) <= M12(6)
                AngClass(i) = 0;
            elseif AngMu6(i6,1) > M12(6) && AngMu6(i6,1) <= M23(6)
                AngClass(i) = 1;
            elseif AngMu6(i6,1) > M23(6) && AngMu6(i6,1) <= M34(6)
                AngClass(i) = 2;
            else
                AngClass(i) = 3;
            end     
        i6 = i6 + 1;  
       
    else
        AngMu7(i7,:) = AngPlusMuE(i,:);

            if AngMu7(i7,1) <= M12(7)
                AngClass(i) = 0;
            elseif AngMu7(i7,1) > M12(7) && AngMu7(i7,1) <= M23(7)
                AngClass(i) = 1;
            elseif AngMu7(i7,1) > M23(7) && AngMu7(i7,1) <= M34(7)
                AngClass(i) = 2;
            else
                AngClass(i) = 3;
            end  
        i7 = i7 + 1; 
        
    end
end

%=================================END======================================
