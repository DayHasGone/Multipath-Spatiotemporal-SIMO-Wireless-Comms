%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Models the channel effects in the system
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% paths (Mx1 Integers) = Number of paths for each source in the system.
% For example, if 3 sources with 1, 3 and 2 paths respectively then
% paths=[1;3;2]
% symbolsIn (MxR Complex) = Signals being transmitted in the channel, R is
% the number of the sources
% delay (Cx1 Integers) = Delay for each path in the system starting with
% source 1
% beta (Cx1 Integers) = Fading Coefficient for each path in the system
% starting with source 1
% DOA = Direction of Arrival for each source in the system in the form
% [Azimuth, Elevation]
% SNR = Signal to Noise Ratio in dB
% array = Array locations in half unit wavelength. If no array then should
% be [0,0,0]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% symbolsOut (FxN Complex) = F channel symbol chips received from each antenna
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [symbolsOut]=fChannel(paths,symbolsIn,delay,beta,DOA,SNR,array)
NumofSources=length(paths);
symbolsIn(end+max(delay),:)=0; %extend the symbol streams because of delay
RxGains=spv(array,DOA); %Receiver gain for each paths of each attenna, assume the attennas all have equal weight
Count=1; %Take fading coefficient or delay in sequence
symbolsOut=zeros(size(symbolsIn,1),length(array(:,1))); %Initialize output
SNR_de=10^(SNR/10); %Convert SNR form dB to decimal
Precount=1;
for iSignal=1:NumofSources %Calclulate for Output
    SymbolsOfPath=zeros(length(symbolsIn),paths(iSignal));
    for iPath=1:paths(iSignal) %Calculated symbol streams of each path for iSignal
        %Calculate iPath's symbols of iSignal without noise
        SymbolsOfPath(:,iPath)=beta(Count)*circshift(symbolsIn(:,iSignal),delay(Count)); 
        Count=Count+1;
    end
    SymbolsRx=SymbolsOfPath*RxGains(:,Precount:Count-1).';  %Each column represents the bit stream received by each antenna
    %Calculate and add noise to ipath
    P_Signal=sum(sum(abs(SymbolsRx).^2))/size(SymbolsRx,1)/size(SymbolsRx,2); %Power of Signal
    P_Noise=P_Signal/SNR_de;
    noise=sqrt(P_Noise/2)*(randn(size(symbolsIn,1), length(array(:,1))) + 1i * randn(size(symbolsIn,1), length(array(:,1))));
    symbolsOut=symbolsOut+SymbolsRx+noise;
    Precount=Count;
end
end

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            