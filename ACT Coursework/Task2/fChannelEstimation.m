%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Performs channel estimation for the desired source using the received signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% symbolsIn (Fx1 Complex) = R channel symbol chips received
% goldseq (Wx1 Integers) = W bits of 1's and 0's representing the gold
% sequence of the desired source used in the modulation process
% Number of paths Desired signal uses
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% delay_estimate = Vector of estimates of the delays of each path of the
% desired signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [delay_estimate]=fChannelEstimation(symbolsIn,goldseq,NumofDesignalPath)
goldseq = 1 - 2 * goldseq; %Change goldseq to -1s and 1s
Len_gold=length(goldseq);
MaxDelay=Len_gold-1;
RepeatTime=ceil(length(symbolsIn)/Len_gold); %Reapt goldseq N times to let it as long as Symbols
symbolsIn(RepeatTime*Len_gold)=0; %Let length of symbolsIn be multiply of length(goldseq)
%Make it convenient to calculate correlation
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

end
[~, DelayIndex] = sort(Sum, 'descend'); %Rank the most relevant delays from highest to lowest
delay_estimate=zeros(NumofDesignalPath,1);
count=1; %Count nth Delay with max correlation
for i=1:NumofDesignalPath
    delay_estimate(i)=DelayIndex(count)-1;
    count=count+1;
end
end

   