function h=stickplot(t,u,v,ax,varargin)
%STICKPLOT plot timeseries of a vector 
% STICKPLOT plots a timeseries of direction vectors on the
% current axes.
%
%  Input: time - time vector
%         u    - east/west component of the vector series
%         v    - north/south component of the vector series
%         ax   - a 4x1 vector indicating the region of the 
%                time series to zoom in on.  This is necessary
%                for the proper scaling of the direction and 
%                magnitude of the vectors.
% Output: h    - handle to the line object drawn            
%            
% NOTE: do not resize the window or axes AFTER STICKPLOT
%       has drawn the vectors.  The east/west north/south
%       magnitudes will no longer be scaled correctly.
%
% PN/PV pairs accepted by STICKPLOT:
%    Voffset - amount to displace the stickplot vertically
%
% Call as: hv=stickplot(time,u,v,ax,pn1,pv1,...);

%
% Written by : Brian O. Blanton
% Fall 1997
% Fall 2002: added varargins

if nargin==0,disp('Call as: hv=stickplot(time,u,v,ax,pn1,pv1,...)');return;end

% Default propertyname values
Voffset=0.;
% Strip off propertyname/value pairs in varargin not related to
% "line" object properties.
k=1;
while k<length(varargin),
  switch lower(varargin{k}),
    case 'voffset',
      Voffset=varargin{k+1};
      varargin([k k+1])=[];
    otherwise
      k=k+2;
   end
end

axis(ax);    
pos = get(gca,'Position');
pap = get(gcf,'PaperPosition');
hwratio = (pos(4)*pap(4))/(pos(3)*pap(3));
             
dt = ax(2)-ax(1);
dv = ax(4)-ax(3);
sf = hwratio*dt/dv;
s = [0; 1; 0];
n = length(t);
us = u*sf;   
vec = zeros( n*3, 2 );
id = (1:3'); 
for i=1:n    
   vec(id,:) = s*[us(i), v(i)];
   vec(id,1) = vec(id,1)+ones(3,1)*t(i);
   id = id+3;
end          
             
h=line(vec(:,1),vec(:,2)+Voffset,varargin{:});
if nargout==1,hstick=h;,end
axis(ax)     

%
%        Brian O. Blanton
%        Department of Marine Sciences
%        12-7 Venable Hall
%        CB# 3300
%        University of North Carolina
%        Chapel Hill, NC
%                 27599-3300
%
%        brian_blanton@unc.edu
%
%        Fall 2002
