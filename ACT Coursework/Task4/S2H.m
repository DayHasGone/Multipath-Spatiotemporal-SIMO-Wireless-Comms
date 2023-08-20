function [h] = S2H(S,goldseq,N_ext,delay)
%Transform manifold s to extend manifold (ST manifold) h 
%   Input: manifold S,PN-code used by desired signals,N_extend, delay of
%   desired signal
%
%   Output: ST manifold h

%Form shifting matrix
J=zeros(N_ext,N_ext);
I=eye(N_ext-1);
J(2:N_ext,1:(N_ext-1))=I;

c=[ goldseq ; zeros(length(goldseq),1)]; %Extend goldseq with 0s
h=kron(S,J^delay*c);%Calculate extended manifold

end