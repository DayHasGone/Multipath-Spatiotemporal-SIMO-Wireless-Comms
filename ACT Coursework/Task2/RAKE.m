function Optsymbols= RAKE(symbolsIn,beta,delay_estimate)
%Find the Optimized symbols using RAKE receiver
%   Input: received symbols, fading coefficients of n paths used by desired
%   signal,delay of n paths used by desired
%
%   Output: Optimized symbols
NumofPath=length(delay_estimate); %Number of Path uUed by Desired Signal
Optsymbols=zeros(size(symbolsIn));
delay_estimate=sort(delay_estimate,'ascend'); %delay order from smallest to largest

for i=1:NumofPath
    Optsymbols=Optsymbols+circshift(symbolsIn, -delay_estimate(i))*conj(beta(i));
end
end