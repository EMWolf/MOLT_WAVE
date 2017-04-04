function Make_Surf(x,y,u)
surf(x,y,u);
axis([x(1,1) x(1,end) y(1,1) y(end,1) -2 2]);
shading flat;
view([15,75]);
% colormap('colorcube');
% colormap('flag');
% colormap('lines');
% colormap('prism');
colormap('jet');

lightangle(-45,30)
% set(gcf,'Renderer','zbuffer')
set(findobj(gca,'type','surface'),...
    'FaceLighting','gouraud',...
    'AmbientStrength',.3,...
    'DiffuseStrength',.8,...
    'SpecularStrength',.9,...
    'SpecularExponent',25,...
    'BackFaceLighting','unlit');