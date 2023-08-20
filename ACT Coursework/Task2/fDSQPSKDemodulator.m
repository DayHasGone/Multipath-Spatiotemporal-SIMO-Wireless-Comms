% Inputs
% symbolsIn (Fx1 Integers) = R channel symbol chips received
% goldseq (Wx1 Integers) = W bits of 1's and 0's representing the gold
% sequence of the desired signal to be used in the demodulation process
% phi (Integer) = Angle index in degrees of the QPSK constellation points
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% bitsOut (Px1 Integers) = P demodulated bits of 1's and 0's
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%For DSQOSK Demodulator for SISO
function [bitsOut]=fDSQPSKDemodulator(symbolsIn,GoldSeq,phi)
GoldSeq = 1 - 2 * GoldSeq;
DesSymbols=zeros(fix(length(symbolsIn)/length(GoldSeq)),1); %Despread symbols

bitsOut=zeros(2*length(DesSymbols),1);
DeLen_symbolsIn=fix(length(symbolsIn)/length(GoldSeq))*length(GoldSeq); %Desired length of symbolsIn should be 15*N
symbolsIn=symbolsIn(1:DeLen_symbolsIn);
DesSymbols=reshape(symbolsIn,length(GoldSeq),[]).'*GoldSeq/length(GoldSeq); %Calculate for Despread Symbols

phi=phi/180*pi; %Change degree to radian
for i=1:4
    Ref(i)=sqrt(2)*(cos(phi+(i-1)*pi/2)+1i*sin(phi+(i-1)*pi/2)); %Calculated 4 reference points in QPSK
end

%Using Euclidean distance demodulation
for i=1:length(DesSymbols)
    for j=1:4
        Norm(j)=norm([real(DesSymbols(i)-Ref(j)), imag(DesSymbols(i)-Ref(j))]);
    end
    Min_pos=find(Norm==min(Norm));
    switch(Min_pos(1,1))
        case 1
            bitsOut(2*i-1:2*i)=[0;0];
        case 2
            bitsOut(2*i-1:2*i)=[0;1];
        case 3
            bitsOut(2*i-1:2*i)=[1;1];
        case 4
            bitsOut(2*i-1:2*i)=[1;0];
    end
end

end

