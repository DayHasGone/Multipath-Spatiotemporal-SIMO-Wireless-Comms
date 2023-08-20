function goldseq=fGoldSeq(mseq1,mseq2,shift);
%Use given two m sequence and shifte bits to genenate gold-sequence
%   Input: two m sequences and a delay bits
%   Output: corrseponding gold sequence of 0s and 1s
%mseq is a period code, as a result we can use circshift for delay code
mseq2_shif=circshift(mseq2,shift); %Calculate for mseq2 after shift
goldseq=mod(mseq1+mseq2_shif,2);
end