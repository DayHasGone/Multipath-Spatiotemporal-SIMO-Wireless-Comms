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
    SymbolsRx=SymbolsOfPath*RxGains(:,Precount:Count-1)';  %Each column represents the bit stream received by each antenna
    %Calculate and add noise to ipath
    P_Signal=sum(sum(abs(SymbolsRx).^2))/size(SymbolsRx,1)/size(SymbolsRx,2); %Power of Signal
    P_Noise=P_Signal/SNR_de; %Power of Noise
    noise=sqrt(P_Noise/2)*(randn(size(symbolsIn,1), length(array(:,1))) + 1i * randn(size(symbolsIn,1), length(array(:,1))));
    symbolsOut=symbolsOut+SymbolsRx+noise; %Add Signal and noise from different paths 
    Precount=Count;
end
end

% function [symbolsOut]=fChannel(paths,symbolsIn,delay,beta,DOA,SNR,array,maxdelay)
% 
% Pn = 10 .^ (SNR / 10);
% % number of signals
% Signals = length(paths);
% 
% % expand the symbol streams by maximum possible relative delay
% symbolsIn(length(symbolsIn) + maxdelay, Signals) = 0;
% % symbol streams of signals
% symbolsSignal = zeros(size(symbolsIn));
% 
% % path counters
% pathCounter = 1; 
% 
% npathcounter=1;
% 
% % gain Source Position Vector
% 
% for i = 1: Signals
%     % symbol streams of paths of the current signal
%     symbolsSub = zeros(length(symbolsIn), paths(i));
%     for numpath = 1: paths(i)
%         S = spv(array, DOA(npathcounter,:));
%         npathcounter=npathcounter + 1;
%         % obtain the current path stream by delay and scaling
%         symbolsSub(:, numpath) = S*beta(pathCounter) * circshift(symbolsIn(:, i), delay(pathCounter));
%         % update the path counter
%         pathCounter = pathCounter + 1;
%     end
%      % sum the path streams to get signal stream
%     symbolsSignal(:, i) = sum(symbolsSub, 2);
%     
% end
%     % assume the 30 degree signal as desired 
%     Desiredsignal = symbolsIn(:,1);
%     % calculate the desired signal power
%     powerSignal = sum(abs(Desiredsignal).^2) / length(Desiredsignal);
%     % hence the noise power
%     powerNoise = powerSignal / Pn;
%     % then generate noise accordingly
%     noise = sqrt(powerNoise / 2) * (randn(length(symbolsIn), 1) + 1i * randn(length(symbolsIn), 1));
%     totalSignal=sum(symbolsSignal, 2);
%     % produces multiple output symbol streams with noise level based on
%     symbolsOut = totalSignal + noise;
%  
%     
% end


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            