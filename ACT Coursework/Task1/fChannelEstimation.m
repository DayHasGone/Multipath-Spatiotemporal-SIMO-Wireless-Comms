%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Performs channel estimation for the desired source using the received signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% symbolsIn (Fx1 Complex) = R channel symbol chips received
% goldseq (Wx1 Integers) = W bits of 1's and 0's representing the gold
% sequence of the desired source used in the modulation process
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% delay_estimate = Vector of estimates of the delays of each path of the
% desired signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [delay_estimate]=fChannelEstimation(symbolsIn,goldseq)
goldseq = 1 - 2 * goldseq; %Change goldseq to -1s and 1s (0 - 1, 1 - -1)
Len_gold=length(goldseq);
MaxDelay=Len_gold-1;
RepeatTime=ceil(length(symbolsIn)/Len_gold); %Reapt goldseq N times to let it as long as Symbols
symbolsIn(RepeatTime*Len_gold)=0; %Let length of symbolsIn be multiply of length(goldseq)
%Make it convenient to calculate correlation
delay_estimate=0; %Initialize output
Max_corr=0; %Used to find max correaltion delay
Sum=zeros(MaxDelay,1); %initialize sum for the following calculation

%Calculate for correlation
for nDelay=1:MaxDelay %Delay form 0 to Len_gold-1
    goldseq_shift=circshift(goldseq,nDelay-1);
    Ex_Goldseq=repmat(goldseq_shift,RepeatTime,1); %Extend goldseq
    Temp=Ex_Goldseq.*symbolsIn;
    for n=1:RepeatTime
        start=(n-1)*Len_gold+1;
        finish=n*Len_gold;
        Sum(nDelay)=Sum(nDelay)+abs(sum(Temp(start:finish))); %Calcualtion for correlation
    end
    if Sum(nDelay)>Max_corr  %Find Delay with Max Correlation
        delay_estimate=nDelay-1;
        Max_corr=Sum(nDelay);
    end
end
end

   