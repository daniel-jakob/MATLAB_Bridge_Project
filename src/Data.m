function D=Data
%  Definition of Data
%  Nodal Coordinates
Coord2D=4.5*[0 0;1 0;2 0;3 0;4 0;5 0;6 0;1 1;2 1;3 1;4 1;5 1];
%  Connectivity
Con2D=[1 2;1 8;2 3;2 8;3 8;3 4;3 9;4 5;4 9;4 10;4 11;5 12;5 6;5 11;6 12;6 7;7 12;8 9;9 10;10 11;11 12];
%Coord3D=4.5*[0 0 0;0 1 0;1 0 0;1 1 0;2 0 0;2 1 0;3 0 0;3 1 0;4 0 0;4 1 0;5 0 0;5 1 0;6 0 0;6 1 0;1 0 1;1 1 1;2 0 1;2 1 1;3 0 1;3 1 1;4 0 1;4 1 1;5 0 1;5 1 1];
%Con3D=[1 2;1 3;1 15;2 4;2 16;3 5;3 4;3 15;4 6;4 16;5 7;5 6;5 17;5 15;6 8;6 18;6 16;7 17;7 19;7 21; 7 9;7 8;8 10;8 18;8 20;8 22;9 11;9 21;9 23;9 10;10 12;10 22;10 24;11 13;11 23;11 12;12 24;12 14;13 14;13 23;14 24;15 16;15 17;17 19;17 18;16 18;18 20;19 20;19 21;20 22;21 22;21 23;22 24;23 24];
%Con3D=[1 3;1 15;3 5;3 15;5 15;5 7;5 17;7 9;7 17;7 19;7 21;9 23;9 11;9 21;11 23;11 13;13 23;15 17;17 19;19 21;21 23;2 4;2 16;4 6;4 16;6 16;6 8;6 18;8 10;8 18;8 20;8 22;10 24;10 12;10 22;12 24;12 14;14 24;16 18;18 20;20 22;22 24;1 2;3 4;5 6;7 8;9 10;11 12;13 14;15 16;17 18;19 20;21 22;23 24];
%size(Con3D)

% Definition of Degree of freedom (free=0 &  fixed=1); for 2-D trusses the last column is equal to 1
Re=zeros(size(Coord2D));Re(1,:)=[0 1];Re(7,:)=[1 1];
% or:   Re=[0 0 0;0 0 0;0 0 0;0 0 0;0 0 0;0 0 0;1 1 1;1 1 1;1 1 1;1 1 1];
% Definition of Nodal loads 
Load=ones(size(Coord2D));Load([4:6,6],:)=[1 -10000;0 -10;0.5 0;0.6 0];
% or:   Load=1e3*[1 -10 -10;0 -10 -10;0.5 0 0;0 0 0;0 0 0;0.6 0 0;0 0 0;0 0 0;0 0 0;0 0 0];
% Definition of Modulus of Elasticity
E= 210*10^9; % GPa
% or:   E=[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]*1e7;
% Definition of Area
A = (0.12^2); % m^2

% Convert to structure array
%D=struct('Coord',Coord2D','Con',Con2D','Re',Re','Load',Load','E',E','A',A');
%Coord(3,1) = 4.5  Coord(1,3) = 0

%hold on
%for i = 1:size(Coord3D)
%plot3(Coord3D(:,1),Coord3D(:,2),Coord3D(:,3),'.')
%text(Coord3D(i,1),Coord3D(i,2),Coord3D(i,3),sprintf('%d',i),'Color','red','FontSize',14);
%end
%hold off
%for i = 1:size(Con3D)
    %x1 = Coord3D(Con3D(i,1),1);
    %y1 = Coord3D(Con3D(i,1),2);
    %z1 = Coord3D(Con3D(i,1),3);
    %x2 = Coord3D(Con3D(i,2),1) - Coord3D(Con3D(i,1),1);
    %y2 = Coord3D(Con3D(i,2),2) - Coord3D(Con3D(i,1),2);
    %z2 = Coord3D(Con3D(i,2),3) - Coord3D(Con3D(i,1),3);
    %makelink(x1, y1, z1, x2, y2, z2, 0.2, [1 0 1])
%end
%axis equal
%view(3)
%xlabel('$x$','Interpreter','latex')
%ylabel('$y$','Interpreter','latex')
%zlabel('$z$','Interpreter','latex')
end