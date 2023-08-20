function S=spv(array,direction,mainlobe);
%....................................................
% S=spv(array,direction,mainlobe);
% Source Position Vectors:
% NB:if f and c are given then use array*2*f/c;
% written by Dr A.Manikas
%....................................................
if nargin<=2, mainlobe=[]; end;
SOURCES=frad(direction);  %transfer degrees to rad 
N=length(array(:,1)); %number of sensors in array
M=length(SOURCES(:,1)); %number of sources
if nargin<=2 | isempty(mainlobe)
   U0=zeros(N,M);
else
   saz=frad(mainlobe(1));sel=frad(mainlobe(2)); %azimuth elevation
   k0 = fki(saz,sel); % k0 is the wavenumber vector of the signal emitted by the sources
   U0=  repc(array*k0,M);
end;
KI = fki(SOURCES(:,1),SOURCES(:,2));
S = exp(-j*(array*KI -U0));