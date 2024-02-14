% Wheelbase = 3.97 m, assume driving in middle of bridge
base = 3;
A = (0.12^2); %m^2
y = ((4.5-3)/2); % m
%length_bars_tot = 42*4.5+12*(sqrt(4.5^2+4.5^2)); % m
front_axle_load = (1.46*-17.8*10^3)/2; % N
rear_axle_load = (1.46*-58.4*10^3)/2; % N
volume_concrete = 4.5*4.5*0.15; % m^3
volume_asphalt = 4.5*4.5*0.05; % m^3
volume_panels = 4.5*4.5*0.025; % m^3
rho_concrete = 2400; % kg/m^3
rho_asphalt = 2243; % kg/m^3
rho_steel = 7850; % kg/m^3
W_asphalt = volume_asphalt*rho_asphalt*-9.81; % N
W_concrete = volume_concrete*rho_concrete*-9.81; % N
W_panels = volume_panels*rho_concrete*-9.81; % N
%W_bars = rho_steel*A*length_bars_tot*-9.81; % N
W_small_bars = rho_steel*A*4.5*-9.81;
W_big_bars = rho_steel*A*(sqrt(4.5^2+4.5^2))*-9.81;
W_floor = W_panels+W_concrete+W_asphalt;

F_max = 367800;

Coord3D=4.5*[0 0 0;0 1 0;1 0 0;1 1 0;2 0 0;2 1 0;3 0 0;3 1 0;4 0 0;4 1 0;5 0 0;5 1 0;6 0 0;6 1 0;1 0 1;1 1 1;2 0 1;2 1 1;3 0 1;3 1 1;4 0 1;4 1 1;5 0 1;5 1 1];
Con3D=[1 3;1 15;3 5;3 15;5 15;5 7;5 17;7 9;7 17;7 19;7 21;9 23;9 11;9 21;11 23;11 13;13 23;15 17;17 19;19 21;21 23;2 4;2 16;4 6;4 16;6 16;6 8;6 18;8 10;8 18;8 20;8 22;10 24;10 12;10 22;12 24;12 14;14 24;16 18;18 20;20 22;22 24;1 2;3 4;5 6;7 8;9 10;11 12;13 14;15 16;17 18;19 20;21 22;23 24;
       1 4;2 3;3 6;4 5;5 8;6 7;7 10;8 9;9 12;10 11;11 14;12 13;15 18;16 17;17 20;18 19;19 22;20 21;21 24;22 23;];
Con2D=[1 2;1 8;2 3;2 8;3 8;3 4;3 9;4 5;4 9;4 10;4 11;5 12;5 6;5 11;6 12;6 7;7 12;8 9;9 10;10 11;11 12];
Coord2D=4.5*[0 0;1 0;2 0;3 0;4 0;5 0;6 0;1 1;2 1;3 1;4 1;5 1];
Re=zeros(size(Coord2D));Re(1,:)=[0 1];Re(7,:)=[1 1];
Load=zeros(size(Coord2D));
E= 210*10^9;
EA = E*A; % pre-calcuating EA


myVideo = VideoWriter('myVideoFile', 'Uncompressed AVI'); %open video file
myVideo.FrameRate = 20;  %can adjust this, 5 - 10 works well for me
open(myVideo)
figure('units','pixels','position',[0 0 1920 1080])
f = figure(1);
%Maxs = zeros(size(Con2D,1),2);
%Maxs(:,1)=1111111111;
%Maxs(:,1) = [184715.062792868;261226.546976272;184715.062792868;60341.6901374999;158853.069867657;297041.145708588;48455.8233083974;297041.145708588;52951.0232892200;7485.22619999889;52951.0232892197;158853.069867658;184715.062792867;48455.8233083974;60341.6901374999;184715.062792867;261226.546976272;297041.145708589;334483.173347163;334483.173347163;297041.145708589];
%Maxs(:,2) = [204432.254644720;289110.867105073;204432.254644720;74866.0945819447;180611.959653300;327812.862745626;59510.3484935826;327870.613856736;68584.4827317035;7485.22620000006;68625.3189339912;180652.795855587;204461.130200275;59539.2240491388;74866.0945819447;204461.130200275;289151.703307361;327812.862745626;367733.375569385;367733.375569386;327870.613856737];
for u = 0:0.1:34
%for u = 0:1:34
%u = -5;
%light('Position',[-10 -1 5],'Style','infinite')
%light('Position',[-0 -1 5],'Style','infinite')
%light('Position',[10 -1 5],'Style','infinite')
%light('Position',[20 -1 5],'Style','infinite')
%light('Position',[30 -1 5],'Style','infinite')

Load=zeros(size(Coord2D));

Load(1,2) = 0.5*W_small_bars + 0.5*W_big_bars + 0.25*W_floor;
Load(2,2) = 3*0.5*W_small_bars + 0.5*W_floor;
Load(3,2) = 3*0.5*W_small_bars + 0.5*W_big_bars + 0.5*W_floor;
Load(4,2) = 3*0.5*W_small_bars + 2*0.5*W_big_bars + 0.5*W_floor;
Load(5,2) = 3*0.5*W_small_bars + 0.5*W_big_bars + 0.5*W_floor ;
Load(6,2) = 3*0.5*W_small_bars + 0.5*W_floor;
Load(7,2) = 0.5*W_small_bars + 0.5*W_big_bars + 0.25*W_floor;

Load(8,2) = 2*0.5*W_small_bars + 2*0.5*W_big_bars;
Load(9,2) = 3*0.5*W_small_bars + 0.5*W_big_bars;
Load(10,2) = 3*0.5*W_small_bars;
Load(11,2) = 3*0.5*W_small_bars + 0.5*W_big_bars;
Load(12,2) = 2*0.5*W_small_bars + 2*0.5*W_big_bars;

if u >= 1 && u <= 28  
Load(floor(((u-1)/4.5))+1,2) = Load(floor(((u-1)/4.5))+1,2)+(1-(((u-1)/4.5)-floor((u-1)/4.5)))*front_axle_load;
Load(floor(((u-1)/4.5))+2,2) = Load(floor(((u-1)/4.5))+2,2)+((((u-1)/4.5)-floor((u-1)/4.5)))*front_axle_load;
end
if u >= 4.97 && u <= 31.97
Load(floor(((u-4.97)/4.5))+1,2) = Load(floor(((u-4.97)/4.5))+1,2)+(1-(((u-4.97)/4.5)-floor((u-4.97)/4.5)))*front_axle_load;
Load(floor(((u-4.97)/4.5))+2,2) = Load(floor(((u-4.97)/4.5))+2,2)+((((u-4.97)/4.5)-floor((u-4.97)/4.5)))*front_axle_load;
end
hold on

[F,U]=ST(Coord2D', Con2D', Re', Load', EA);
vertex_matrix_link = [-7+u y 0.8; -7+u y+base 0.8; -2+u y 0.8; -2+u y+base 0.8;-7+u y 3.8; -7+u y+base 3.8; -2+u y 3.8; -2+u y+base 3.8];
face_matrix_link = [1 2 4 3; 1 3 7 5; 1 2 6 5;2 4 8 6;3 4 8 7;5 6 8 7];
patch('Vertices',vertex_matrix_link, 'Faces',face_matrix_link, 'FaceColor', [0.8 0.8 0.8]);

vertex_matrix_link2 = [-2+u y 0.8; -2+u y+base 0.8; 0+u y 0.8; 0+u y+base 0.8;-2+u y 3; -2+u y+base 3;0+u y 3;0+u y+base 3];
face_matrix_link2 = [1 2 4 3; 1 3 7 5; 1 2 6 5;2 4 8 6;3 4 8 7;5 6 8 7];
patch('Vertices',vertex_matrix_link2, 'Faces',face_matrix_link2, 'FaceColor', [0 0.5 0.5]);

% window
vertices = [-1.8+u y 1.5; -0.4+u y 1.5; -1.8+u y 2.6; -0.4+u y 2.6;];
face_matrix_link = [1 2 4 3];
patch('Vertices',vertices, 'Faces',face_matrix_link, 'FaceColor', [0.9 0.9 0.9]);

% floor panels
vertices = [0.06 0.06 -0; 4.5-0.06 0.06 0; 4.5-0.06 4.5-0.06 0; 0.06 4.5-0.06 0];
face_matrix_link = [1 2 3 4];
patch('Vertices',vertices, 'Faces',face_matrix_link, 'FaceColor', [0.5 0.5 0.5]);

vertices = [4.5+0.06 0.06 -0; 9-0.06 0.06 0; 9-0.06 4.5-0.06 0; 4.5+0.06 4.5-0.06 0];
face_matrix_link = [1 2 3 4];
patch('Vertices',vertices, 'Faces',face_matrix_link, 'FaceColor', [0.5 0.5 0.5]);

vertices = [9+0.06 0.06 -0; 13.5-0.06 0.06 0; 13.5-0.06 4.5-0.06 0; 9+0.06 4.5-0.06 0];
face_matrix_link = [1 2 3 4];
patch('Vertices',vertices, 'Faces',face_matrix_link, 'FaceColor', [0.5 0.5 0.5]);

vertices = [13.5+0.06 0.06 -0; 18-0.06 0.06 0; 18-0.06 4.5-0.06 0; 13.5+0.06 4.5-0.06 0];
face_matrix_link = [1 2 3 4];
patch('Vertices',vertices, 'Faces',face_matrix_link, 'FaceColor', [0.5 0.5 0.5]);

vertices = [18+0.06 0.06 -0; 22.5-0.06 0.06 0; 22.5-0.06 4.5-0.06 0; 18+0.06 4.5-0.06 0];
face_matrix_link = [1 2 3 4];
patch('Vertices',vertices, 'Faces',face_matrix_link, 'FaceColor', [0.5 0.5 0.5]);

vertices = [22.5+0.06 0.06 -0; 27-0.06 0.06 0; 27-0.06 4.5-0.06 0; 22.5+0.06 4.5-0.06 0];
face_matrix_link = [1 2 3 4];
patch('Vertices',vertices, 'Faces',face_matrix_link, 'FaceColor', [0.5 0.5 0.5]);

% wheels
theta = [0:2*pi/16:(2*pi)-(2*pi/16)]';
vertices_bottom = [0.6*sin(theta)-1+u ones(16,1)+0.1 0.6*cos(theta)+0.7];
vertices_top = [0.6*sin(theta)-1+u 0.5*ones(16,1)+0.3 0.6*cos(theta)+0.7];
vertex_matrix_link = [vertices_bottom; vertices_top];
face_matrix_link= [[1:16];[1:16]' [[2:16] 1]' [(16+[2:16]) 17]' ((16+[1:16])')*ones(1,13);16+[1:16]];
patch('Vertices',vertex_matrix_link, 'Faces',face_matrix_link, 'FaceColor',[0.1 0.1 0.1]);

vertices_bottom = [0.3*sin(theta)-1+u ones(16,1)+0.1 0.3*cos(theta)+0.7];
vertices_top = [0.3*sin(theta)-1+u 0.5*ones(16,1)+0.3 0.3*cos(theta)+0.7];
vertex_matrix_link= [vertices_bottom; vertices_top];
face_matrix_link= [[1:16];[1:16]' [[2:16] 1]' [(16+[2:16]) 17]' ((16+[1:16])')*ones(1,13);16+[1:16]];
patch('Vertices',vertex_matrix_link, 'Faces',face_matrix_link, 'FaceColor',[1 1 1]);



vertices_bottom = [0.6*sin(theta)-4.97+u ones(16,1)+0.1 0.6*cos(theta)+0.7];
vertices_top = [0.6*sin(theta)-4.97+u 0.5*ones(16,1)+0.3 0.6*cos(theta)+0.7];
vertex_matrix_link= [vertices_bottom; vertices_top];
face_matrix_link= [[1:16];[1:16]' [[2:16] 1]' [(16+[2:16]) 17]' ((16+[1:16])')*ones(1,13);16+[1:16]];  
patch('Vertices',vertex_matrix_link, 'Faces',face_matrix_link, 'FaceColor',[0.1 0.1 0.1]);

vertices_bottom = [0.3*sin(theta)-4.97+u ones(16,1)+0.1 0.3*cos(theta)+0.7];
vertices_top = [0.3*sin(theta)-4.97+u 0.5*ones(16,1)+0.3 0.3*cos(theta)+0.7];
vertex_matrix_link= [vertices_bottom; vertices_top];
face_matrix_link= [[1:16];[1:16]' [[2:16] 1]' [(16+[2:16]) 17]' ((16+[1:16])')*ones(1,13);16+[1:16]];  
patch('Vertices',vertex_matrix_link, 'Faces',face_matrix_link, 'FaceColor',[1 1 1]);


vertices_bottom = [0.6*sin(theta)-1+u ones(16,1)+2.7 0.6*cos(theta)+0.7];
vertices_top = [0.6*sin(theta)-1+u 0.5*ones(16,1)+2.9 0.6*cos(theta)+0.7];
vertex_matrix_link= [vertices_bottom; vertices_top];
face_matrix_link= [[1:16];[1:16]' [[2:16] 1]' [(16+[2:16]) 17]' ((16+[1:16])')*ones(1,13);16+[1:16]];
patch('Vertices',vertex_matrix_link, 'Faces',face_matrix_link, 'FaceColor',[0.1 0.1 0.1]);

vertices_bottom = [0.6*sin(theta)-4.97+u ones(16,1)+2.7 0.6*cos(theta)+0.7];
vertices_top = [0.6*sin(theta)-4.97+u 0.5*ones(16,1)+2.9 0.6*cos(theta)+0.7];
vertex_matrix_link= [vertices_bottom; vertices_top];
face_matrix_link= [[1:16];[1:16]' [[2:16] 1]' [(16+[2:16]) 17]' ((16+[1:16])')*ones(1,13);16+[1:16]];  
patch('Vertices',vertex_matrix_link, 'Faces',face_matrix_link, 'FaceColor',[0.1 0.1 0.1]); 
view(3)
axis equal

for i = 1:12
    text(Coord2D(i,1),-0.5,Coord2D(i,2),sprintf('%.3f mm',U(2,i)*10^3),'Color','green','FontSize',14,'FontWeight','bold');
end
%for i = 13:24
%    text(Coord2D(i-12,1),4.0,Coord2D(i-12,2),sprintf('%.3f mm',U(2,i-12)*10^3),'Color','red','FontSize',14);
%end

for i = 1:21
    x1 = Coord3D(Con3D(i,1),1);
    y1 = Coord3D(Con3D(i,1),2);
    z1 = Coord3D(Con3D(i,1),3); 
    x2 = Coord3D(Con3D(i,2),1);
    y2 = Coord3D(Con3D(i,2),2);
    z2 = Coord3D(Con3D(i,2),3);
    %x = abs((F(i)))/(F_max)
    %if Maxs(i,1) > abs(F(i))
    %Maxs(i,1) = abs(F(i));
    %end
    %if Maxs(i,2) < abs(F(i))
    %Maxs(i,2) = abs(F(i));
    %end
    %F_max = Maxs(i);
    %Maxs(i,1);
    %Maxs(i,2);
    x = (abs(F(i))-Maxs(i,1))/(Maxs(i,2)-Maxs(i,1)+1);
    %x=0.5;
    %x = (abs(F(i)))/(F_max);
    makelink(x1, y1, z1, x2, y2, z2, 0.2, [x 0 1-x])
end
for i = 22:42
    x1 = Coord3D(Con3D(i,1),1);
    y1 = Coord3D(Con3D(i,1),2);
    z1 = Coord3D(Con3D(i,1),3);
    x2 = Coord3D(Con3D(i,2),1);
    y2 = Coord3D(Con3D(i,2),2);
    z2 = Coord3D(Con3D(i,2),3);
    %x = abs((F(i-21)))/(F_max)
    %F_max = Maxs(i-21);
    %x = abs((F(i-21)))/(F_max);
    %x = (abs(F(i-21)))/(F_max);
    x = (abs(F(i-21))-Maxs(i-21,1))/(Maxs(i-21,2)-Maxs(i-21,1)+1);
    %x=0.5;
    makelink(x1, y1, z1, x2, y2, z2, 0.2, [x 0 1-x])
end
for i = 43:54
    x1 = Coord3D(Con3D(i,1),1);
    y1 = Coord3D(Con3D(i,1),2);
    z1 = Coord3D(Con3D(i,1),3);
    x2 = Coord3D(Con3D(i,2),1);
    y2 = Coord3D(Con3D(i,2),2);
    z2 = Coord3D(Con3D(i,2),3);
    makelink(x1, y1, z1, x2, y2, z2, 0.2, [1 1 1])
end
for i = 55:74
    x1 = Coord3D(Con3D(i,1),1);
    y1 = Coord3D(Con3D(i,1),2);
    z1 = Coord3D(Con3D(i,1),3);
    x2 = Coord3D(Con3D(i,2),1);
    y2 = Coord3D(Con3D(i,2),2);
    z2 = Coord3D(Con3D(i,2),3);
    makelink(x1, y1, z1, x2, y2, z2, 0.02, [0.2 0.2 0.2])
end

%for i = 1:size(Coord3D)
%plot3(Coord3D(:,1),Coord3D(:,2),Coord3D(:,3),'.')
%text(Coord3D(i,1),Coord3D(i,2),Coord3D(i,3),sprintf('%d',i),'Color','red','FontSize',14);
%end
xlabel('$x$','Interpreter','latex')
ylabel('$y$','Interpreter','latex')
zlabel('$z$','Interpreter','latex')
view(3)
axis equal

frame = getframe(gcf); %get frame
writeVideo(myVideo, frame);
set(0,'defaultfigurecolor',[1 1 1])
%break
clf
end 
close(myVideo)
hold on