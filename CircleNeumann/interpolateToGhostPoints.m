%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Description: This function constructs boundary interpolants from an
%   input array and evaluates it at ghost points.
%
%
%   Inputs:
%   array_in - input array containing the interior grid point values
%   x_sweep - data structure containing x-sweep information
%   y_sweep - data structure containing y-sweep information
%   x - vector containing x-locations of cell edges
%   y - vector containing y-locations of cell edges
%   Nx - number of cells in the x-direction
%   Ny - number of cells in the y-direction
%   dx - grid spacing in the x-direction
%   dy - grid spacing in the y-direction
%   
%
%   Outputs:
%   array_out - output array containing the input array values at interior
%   grid points and interpolated values at ghost points
%
%   Author: Eric Wolf
%
%   Date: March 30, 2016 (commented)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function array_out = interpolateToGhostPoints(array_in,x_sweep,y_sweep,x,y,Nx,Ny,dx,dy)

array_out = array_in;

R = pi/2;


%Interpolate along x-sweeps
for k=1:Ny+1
    if x_sweep.on(k)==1
        %Interplolate to ghost points
        
        %Left boundary
        idx_x = x_sweep.start_ind(k)-x_sweep.bdry_offset_L(k);
        
        val_pt1 = evaluateInteriorInterpolation(array_in,...
            x_sweep.norm_pt1_loc_x(k,idx_x), x_sweep.norm_pt1_loc_y(k,idx_x),...
            x_sweep.norm_pt1_ind_x(k,idx_x), x_sweep.norm_pt1_ind_y(k,idx_x),...
            x_sweep.norm_pt1_offset_x(k,idx_x), x_sweep.norm_pt1_offset_y(k,idx_x),...
            x,y,dx,dy);
        
        val_pt2 = evaluateInteriorInterpolation(array_in,...
            x_sweep.norm_pt2_loc_x(k,idx_x), x_sweep.norm_pt2_loc_y(k,idx_x),...
            x_sweep.norm_pt2_ind_x(k,idx_x), x_sweep.norm_pt2_ind_y(k,idx_x),...
            x_sweep.norm_pt2_offset_x(k,idx_x), x_sweep.norm_pt2_offset_y(k,idx_x),...
            x,y,dx,dy);
        
        array_out(k,idx_x) = evaluateBoundaryInterpolant(x_sweep.ext_pt_dist(k,idx_x),...
            x_sweep.norm_pt1_dist(k,idx_x),x_sweep.norm_pt2_dist(k,idx_x),...
            val_pt1,val_pt2);
        
        %Right boundary
        idx_x = x_sweep.end_ind(k)+x_sweep.bdry_offset_R(k);
        
        val_pt1 = evaluateInteriorInterpolation(array_in,...
            x_sweep.norm_pt1_loc_x(k,idx_x), x_sweep.norm_pt1_loc_y(k,idx_x),...
            x_sweep.norm_pt1_ind_x(k,idx_x), x_sweep.norm_pt1_ind_y(k,idx_x),...
            x_sweep.norm_pt1_offset_x(k,idx_x), x_sweep.norm_pt1_offset_y(k,idx_x),...
            x,y,dx,dy);
        
        val_pt2 = evaluateInteriorInterpolation(array_in,...
            x_sweep.norm_pt2_loc_x(k,idx_x), x_sweep.norm_pt2_loc_y(k,idx_x),...
            x_sweep.norm_pt2_ind_x(k,idx_x), x_sweep.norm_pt2_ind_y(k,idx_x),...
            x_sweep.norm_pt2_offset_x(k,idx_x), x_sweep.norm_pt2_offset_y(k,idx_x),...
            x,y,dx,dy);
        
        array_out(k,idx_x) = evaluateBoundaryInterpolant(x_sweep.ext_pt_dist(k,idx_x),...
            x_sweep.norm_pt1_dist(k,idx_x),x_sweep.norm_pt2_dist(k,idx_x),...
            val_pt1,val_pt2);
        
    end
end



%Interpolate along y-sweeps
for j=1:Nx+1
    if y_sweep.on(j)==1
        %Interplolate to reflection ghost points
        
        %Downer boundary
        idx_y = y_sweep.start_ind(j)-y_sweep.bdry_offset_D(j);
        
        val_pt1 = evaluateInteriorInterpolation(array_in,...
            y_sweep.norm_pt1_loc_x(idx_y,j), y_sweep.norm_pt1_loc_y(idx_y,j),...
            y_sweep.norm_pt1_ind_x(idx_y,j), y_sweep.norm_pt1_ind_y(idx_y,j),...
            y_sweep.norm_pt1_offset_x(idx_y,j), y_sweep.norm_pt1_offset_y(idx_y,j),...
            x,y,dx,dy);
        
        val_pt2 = evaluateInteriorInterpolation(array_in,...
            y_sweep.norm_pt2_loc_x(idx_y,j), y_sweep.norm_pt2_loc_y(idx_y,j),...
            y_sweep.norm_pt2_ind_x(idx_y,j), y_sweep.norm_pt2_ind_y(idx_y,j),...
            y_sweep.norm_pt2_offset_x(idx_y,j), y_sweep.norm_pt2_offset_y(idx_y,j),...
            x,y,dx,dy);
        
        array_out(idx_y,j) = evaluateBoundaryInterpolant(y_sweep.ext_pt_dist(idx_y,j),...
            y_sweep.norm_pt1_dist(idx_y,j),y_sweep.norm_pt2_dist(idx_y,j),...
            val_pt1,val_pt2);
        
        
        %Upper boundary
        idx_y = y_sweep.end_ind(j)+y_sweep.bdry_offset_U(j);
        
        val_pt1 = evaluateInteriorInterpolation(array_in,...
            y_sweep.norm_pt1_loc_x(idx_y,j), y_sweep.norm_pt1_loc_y(idx_y,j),...
            y_sweep.norm_pt1_ind_x(idx_y,j), y_sweep.norm_pt1_ind_y(idx_y,j),...
            y_sweep.norm_pt1_offset_x(idx_y,j), y_sweep.norm_pt1_offset_y(idx_y,j),...
            x,y,dx,dy);
        
        val_pt2 = evaluateInteriorInterpolation(array_in,...
            y_sweep.norm_pt2_loc_x(idx_y,j), y_sweep.norm_pt2_loc_y(idx_y,j),...
            y_sweep.norm_pt2_ind_x(idx_y,j), y_sweep.norm_pt2_ind_y(idx_y,j),...
            y_sweep.norm_pt2_offset_x(idx_y,j), y_sweep.norm_pt2_offset_y(idx_y,j),...
            x,y,dx,dy);
        
        array_out(idx_y,j) = evaluateBoundaryInterpolant(y_sweep.ext_pt_dist(idx_y,j),...
            y_sweep.norm_pt1_dist(idx_y,j),y_sweep.norm_pt2_dist(idx_y,j),...
            val_pt1,val_pt2);
    end
end






end