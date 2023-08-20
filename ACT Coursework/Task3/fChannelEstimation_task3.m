function [DOA_estimate,delay_estimate,symbolsOut]=fChannelEstimation_task3(symbolsIn,goldseq,array,beta)
% We use Basic STAR which add delay italic-I and Pn-code to change manifold
% vector S to spatiotemporal(ST) manifold vector
%   Input:Symbol Stream,Goldseq of desired signal,Array position, fading
%   coefficiences of desired signal

symbols=symbolsIn;
% map the result to (-1)'s and 1's
goldseq = 1 - 2 * goldseq;
%extender symbolsIn
q=1; %Oversampling factor
Nc=length(goldseq);  %Symbols period is the length of Goldseq
N_ext=2*q*Nc; %Let at least one symbol can be completely sampled
%Increase the length of symbols to a multiple of 15
ExLen=ceil(length(symbols)/Nc)*Nc;
symbols(ExLen,:)=0;
[LenofSym,N]=size(symbols); %Length of symbols, Number of antenna
NumofCol=LenofSym/Nc-1; %Number of Columns in vactorised symbols matrix
symbols_vectorise=zeros(N*N_ext,NumofCol);
for i=0:NumofCol-1
    symbols_vectorise(:,i+1)=reshape(symbols(i*Nc+1:i*Nc+N_ext,:),[],1);
end

% Covariance matrix of vactorised symbols matrix
R_symbols_vectorise=(symbols_vectorise*symbols_vectorise')/size(symbols,1);
%Estimate DOA, delay of desired signals using specific goldseq, estimate
%noise subspace
[DOA_estimate,delay_estimate]=music(array, R_symbols_vectorise, goldseq,N_ext);

%Calculate for weigths
S=spv(array,[DOA_estimate,0]);
h=S2H(S,goldseq,N_ext,delay_estimate);
symbolsOut=(h'*conj(beta)*symbols_vectorise).'; %Calculate for Dessymbols
end