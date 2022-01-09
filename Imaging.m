%__________________________________________________________________________
%
%                   1. Image Reconstruction using PoCA
%__________________________________________________________________________
%
%   This is the script for reconstrucing target material image using PoCA
%   algorithm
%
%   'Functions' used in this current "Imaging" script
%
%   1. PoCA.m               % To find the PoCA points
%   2. InOutAngle.m         % To compute in/out scattering angles
%   3. voxel_image.m        % To draw voxel images according to the target
%                             materials' density
%   4. Classifier.m         % To couple muon momentum measurement into 
%                             Scattering angle information
%==========================================================================
tic
clear N k
N = length(record);
POCA = zeros(N,3);
Angles = zeros(N,1);

for k = 1 : N             
    p1 = [X_in_wErr(k,1)   Y_in_wErr(k,1)   Z_in(k,1)];
    p2 = [X_in_wErr(k,2)   Y_in_wErr(k,2)   Z_in(k,2)];   
    p3 = [X_out_wErr(k,1)  Y_out_wErr(k,1)  Z_out(k,1)];
    p4 = [X_out_wErr(k,2)  Y_out_wErr(k,2)  Z_out(k,2)];

    POCA(k,:) = PoCA(p1,p2,p3,p4);            % Call Function "PoCA"
    Angles(k) = InOutAngle(p1,p2,p3,p4);      % Call Function "InOutAngle"

end

Classifier                                    % Call Function "Classifier"

TimePoCa = toc;

%%
tic
vox_sz = [5 5 5];                % Voxel size = 10 x 10 x 10 mm3
% alpha = 0.2;
% edgec = [1 1 1];
% voxel_image( pts, vox_sz, color, alpha, edgec )

figure(1)
view(3)      % 3D view
xlabel('x [mm]', 'FontSize', 14)
ylabel('y [mm]', 'FontSize', 14)
zlabel('z [mm]', 'FontSize', 14)
xlim([-200 200]);
ylim([-200 200]);
zlim([-200 200]);
grid on

for v = 1 : length(POCA)
    
    %{
    %____________________________________________________
    %   This block is currently inactivated because
    %   this is for "Unknown muon momentum" case.
    %____________________________________________________
    %
    % Angles Classification
    voxel_image(round(POCA(v,:)),...               % Voxel Position                         
                vox_sz,...                  % Voxel Size
                [0 0 0],...      %[(AngClass(v)/3) (AngClass(v)/3) (AngClass(v)/3)],...   % Voxel color
                0.2*Angles(v)/max(Angles));...         % Voxel opacity
    hold on
    %}         
  %
    
    if AngClass(v) == 0
        %ColorClass = [1 1 1] ;
        Opacity = 0;
    elseif AngClass(v) == 1
        %ColorClass = [0.5 0.5 0.5];
        Opacity = 0.01;
    elseif AngClass(v) == 2
        %ColorClass = [0.2 0.2 0.2];
        Opacity = 0.02;
    else
        %ColorClass = [0 0 0];
        Opacity = 0.1;
    end
 % Call Function "voxel_image"
% 
    voxel_image(POCA(v,:),...               % Voxel Position                         
                vox_sz,...                  % Voxel Size
                [0 0 0],...      %[(AngClass(v)/3) (AngClass(v)/3) (AngClass(v)/3)],...   % Voxel color
                Opacity);...         % Voxel opacity 
    
 % 
    hold on
    
end

TimeVisualization = toc;

% Please do not close the figure to use "View" function
 view(0,90)   % X-Y view
%view(90,0)    % Y-Z view
% view(0, 0)    % X-Z view





