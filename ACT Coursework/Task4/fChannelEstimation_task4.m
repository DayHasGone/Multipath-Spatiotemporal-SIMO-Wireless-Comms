function [DOA_estimate,delay_estimate,symbolsOut]=fChannelEstimation_task4(symbolsIn,goldseq,array,Beta)
% Estimate DOA and Delay for desired signal and output desired received symbols using a RAKE receiver 
%   Input: Received Symbols by Array, goldseq used by desired user, array
%   position, fading coeffieients
%
%   Output:Estimated DOA, Estimated Delay, Desired Received Symbols

symbols=symbolsIn;
% map the result to (-1)'s and 1's
goldseq = 1 - 2 * goldseq;
%extender symbolsIn
q=1; %Oversampling factor
Nc=length(goldseq);  %Symbols period is the length of Goldseq
N_ext=2*q*Nc; %Let at least one symbol can be completely sampled
%Increase the length of symbols to a multiple of length(goldseq)
ExLen=ceil(length(symbols)/Nc)*Nc;
symbols(ExLen,:)=0;
[LenofSym,N]=size(symbols); %Length of symbols, Number of antenna
NumofCol=LenofSym/Nc-1; %Number of Columns in vectorised symbols matrix
symbols_vectorise=zeros(N*N_ext,NumofCol);
for i=0:NumofCol-1
    symbols_vectorise(:,i+1)=reshape(symbols(i*Nc+1:i*Nc+N_ext,:),[],1);
end

% Covariance matrix of vectorised symbols matrix
R_symbols_vectorise=(symbols_vectorise*symbols_vectorise')/size(symbols_vectorise,1);
%Estimate DOA, delay of desired signals using specific goldseq, estimate
%noise subspace
[DOA_estimate,delay_estimate]=music(array, R_symbols_vectorise, goldseq,N_ext); %Estimate DOA and Delay
symbolsOut=zeros(NumofCol,1);

%RAKE Receiver to get desired received symbols
for i=1:length(DOA_estimate)
    S=spv(array,[DOA_estimate(i),0]);
    h=S2H(S,goldseq,N_ext,delay_estimate(i));
    symbolsOut=symbolsOut+(h'*conj(Beta(i))*symbols_vectorise).'; %Calculate for Dessymbols
end
end