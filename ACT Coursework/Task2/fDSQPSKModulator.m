function [symbolsOut]=fDSQPSKModulator(bitsIn,goldseq,phi)
%   Input: bitsIn:Stream of 0s and 1s, goldseq used for DSSS, phi
%   Output: symbols vector 
phi=phi/180*pi; %Change degree to radian

%Sart QPSK
count=1; % Count for number of symbol
symbols=zeros(length(bitsIn)/2,1);
for i=1:2:length(bitsIn)
    Pair=[bitsIn(i),bitsIn(i+1)];
    if isequal(Pair,[0,0])
        symbols(count) = sqrt(2) * (cos(phi) + 1i * sin(phi));
    elseif isequal(Pair,[0,1])
        symbols(count) = sqrt(2) * (cos(phi+pi/2) + 1i * sin(phi+pi/2));
    elseif isequal(Pair,[1,1])
        symbols(count) = sqrt(2) * (cos(phi+pi) + 1i * sin(phi+pi));
    elseif isequal(Pair,[1,0])
        symbols(count) = sqrt(2) * (cos(phi+3/2*pi) + 1i * sin(phi+3/2*pi));
    end
    count=count+1;
end
goldseq = 1 - 2 * goldseq; %Change goldseq to -1s and 1s
DSsymbols=symbols*goldseq';
symbolsOut=reshape(DSsymbols.',[],1);
end
