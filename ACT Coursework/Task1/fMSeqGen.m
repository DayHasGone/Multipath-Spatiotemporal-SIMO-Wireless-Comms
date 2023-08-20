function mseq=fMSeqGen(coeffs)
%Use given polynomial to genenate m-sequence with 0s and 1s
% %   Input: coefficients of a ploynomial for example [1,0,0,1,1] represents
% %          D^4+D+1
% %  Output: m sequence of 0s and 1s (Wx1 Intergers)
    coe_length=length(coeffs)-1;
    d_length=2^(length(coeffs)-1)-1; % desired m sequence length 
    mseq=zeros(d_length,1);
    seq=ones(1,coe_length); %Initial state of the shift register be all ones
    for i=1:d_length
        mseq(i)=seq(coe_length);%Assign the last bit of the cascade register to mseq
        temp=mod(sum(coeffs(2:end).*seq),2); %Iterat
        seq(2:coe_length)=seq(1:coe_length-1);
        seq(1)=temp;
    end
end
   