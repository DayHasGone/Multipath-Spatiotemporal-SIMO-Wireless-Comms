%% Task4
load 'sz2022.mat'
message=Xmatrix.'; %Received message vector
Beta_vec=Beta_1;


%Generate two m-sequence
coeffs1=[1,0,0,1,0,1];
coeffs2=[1,0,1,1,1,1];
seq_length=2^(length(coeffs1)-1)-1;
mseq1=fMSeqGen(coeffs1);
mseq2=fMSeqGen(coeffs2);

%Generate gold-sequence of 0s and 1s
goldseq=fGoldSeq(mseq1,mseq2,phase_shift);

%Generate Array
NumofAnt=5;
Array=zeros(NumofAnt,3);
Phaseof1stAnt=30/180*pi; %Change phase for 1st antenna from degree into radian
ChangeInRadian=360/NumofAnt/180*pi; %The radian interval between each antenna
for i=1:NumofAnt
    Array(i,:)=1*[cos(Phaseof1stAnt+(i-1)*ChangeInRadian) sin(Phaseof1stAnt+(i-1)*ChangeInRadian) 0];
end
%% Estimate DOA and delay for our desired received symbols
[DOA_estimate,delay_estimate,SymbolsOut] = fChannelEstimation_task4(message, goldseq,Array,Beta_vec); 

%% DSQPSK Demodulator to get received bit stream and recover Image.
bitsOut=fDSQPSKDemodulator_task4(SymbolsOut,phi_mod);

%% Convert Bits to Str and Display String
Bit2StrAndDisplay(bitsOut);