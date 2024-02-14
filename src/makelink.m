function [] = makelink(x1, y1, z1, x2, y2, z2, t, c)
%function [] = makelink(x1, y1, z1, x2, y2, z2, thickness)
%   MAKELINK takes 8 inputs:
%   x1, y2, z1 are the 3D coordinates of the start of the link
%   x2, y2, z2 are the 3D coordinates of the end of the link
%   t is the thickness of the bar, c is the colour (RGB array) of the bar

% Author: Daniel Jakob (18409686), 06/03/2021, Version 1.2

t = t/2; % bar thickness halved, centering bar

if z1 == z2 % flat members 
    if y1 == y2 % going in x-direction
        vertices =  [x1 y1+t z1-t;
                     x1 y1+t z1+t;    
                     x1 y1-t z1+t;
                     x1 y1-t z1-t;
                     x2 y2+t z2-t;
                     x2 y2+t z2+t;
                     x2 y2-t z2+t;
                     x2 y2-t z2-t;];
    else % going in y-direction (must rotate by 90 deg)
        vertices =  [x1+t y1 z1-t;
                     x1+t y1 z1+t;    
                     x1-t y1 z1+t;
                     x1-t y1 z1-t;
                     x2+t y2 z2-t;
                     x2+t y2 z2+t;
                     x2-t y2 z2+t;
                     x2-t y2 z2-t;];
    end
else % non-flat members
    vertices =  [x1+t y1-t z1;
                 x1+t y1+t z1;    
                 x1-t y1+t z1;
                 x1-t y1-t z1;
                 x2+t y2-t z2;
                 x2+t y2+t z2;
                 x2-t y2+t z2;
                 x2-t y2-t z2;];
end
faces = [1 2 3 4;
         1 2 6 5;
         2 3 7 6;
         3 4 8 7;
         4 1 5 8;
         5 6 7 8];
patch('Vertices', vertices, 'Faces', faces, 'FaceColor', c);
view(3)
axis equal
xlabel('$x$','Interpreter','latex')
ylabel('$y$','Interpreter','latex')
zlabel('$z$','Interpreter','latex')
view([-15 25]);
end