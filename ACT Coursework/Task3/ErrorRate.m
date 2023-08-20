function BER=ErrorRate(TransBits,RecBits)
%Claculate Bit error rate
%   Input: Transmitted bit stream, received bit stream
%   Output: BER between them
NumofBitsUnequal=length(find((TransBits-RecBits)~=0));
BER=NumofBitsUnequal/length(TransBits);
end