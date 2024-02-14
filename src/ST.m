%function [F,U]=ST(D) 
% Analyize a Truss using the direct stiffness method
%
% Input  D  defines the Truss structure as follows
%       D.Coord  -- N x 3  array of node coordinates
%       D.Con    -- N x 2  array of connector or member mapping           
%       D.Re     -- N x 3  array of node freedom  1 = fixed 0 = free                 
%       D.Load   -- N x 3  array of load force vectors  
%       D.A      -- M x 1  array of member cross section areas
%       D.E      -- M x 1  array of member Elasticity ( Youngs Modulous) 
% 
% Ouput  F       -- M x 1 array of force along members
%        U       -- N x 3 array of Node displacement vectors 
%        R       -- N x 3 array of Reaction force vectors 

% Original code by  Hossein Rahami 
% 17 Mar 2007 (Updated 13 Apr 2007)  
% Reformatted and comments added by 
% Frank McHugh  06 Sep 2012
function [F,U]=ST(Coord, Con, Re, Load, EA)
w=size(Re);      % 3 x number of nodes
S=zeros(2*w(2));   % stiffness matrix is 3*(number of nodes) square matrix
U=1-Re;   % U is displacement  matrix  [
            % column index by node 
            % x , y , z by rows 
            % initialize U to 1 for non fixed nodes 0 for fixed
f=[1 3 4 5 6 7 8 9 10 11 12 15 16 17 18 19 20 21 22 23 24]'; 
            % f index in U of free nodes 
Tj = zeros(size(Con)); % initializing Tj to be a fixed size. 
for i=1:size(Con,2)     % Loop through Connectors (members)
   H=Con(:,i);
   C=Coord(:,H(2))-Coord(:,H(1));  % C is vector for connector i
   Le=norm(C);                         % Le length of connector i
   T=C/Le;                          % T is unit vector for connector i
   s=T*T';       %   Member Siffness matrix is of form 
                 %   k * |  s  -s |
                 %       |  -s  s | in global truss coordinates  
   G=EA/Le;     % G aka k stiffness constant of member = E*A/L
   Tj(:,i)=G*T;            % Stiffness vector of this member
   e=[2*H(1)-1:2*H(1),2*H(2)-1:2*H(2)];
               % indexes into Global Stiffness matrix S for this member 
   S(e,e)=S(e,e)+G*[s -s;-s s];
               % add this members stiffness to stiffness matrix
end
U(f)=Gauss_Elim(S(f,f), Load(f));   % solve for displacements of free nodes 
                         %  ie solve F = S * U  for U where S is stiffness
                         %  matrix. 
F=sum(Tj.*(U(:,Con(2,:))-U(:,Con(1,:))));
                 %project displacement of each node pair on to member
                 % between f = Tj dot ( U2j - U1j ).  
                 %Then sum over all contributing node pairs.   
 
