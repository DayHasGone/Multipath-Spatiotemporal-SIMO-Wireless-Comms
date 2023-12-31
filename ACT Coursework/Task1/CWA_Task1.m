%% Task1
x=26; % alphabetical orders of names
y=19;

%Generate two m-sequence
coeffs1=[1,0,0,1,1];
coeffs2=[1,1,0,0,1];
seq_length=2^(length(coeffs1)-1)-1;
mseq1=fMSeqGen(coeffs1);
mseq2=fMSeqGen(coeffs2);

%% Generate gold-sequence  sequence of 0s and 1s
init_d=1+mod(x+y,12); %initialize d (shift bits of mseq2)
d=0; %delay for gold balance
for i=init_d:seq_length-1  %Find "balanced" gold-sequence
    goldseq1=fGoldSeq(mseq1,mseq2,i);

    if(sum(goldseq1)==(length(goldseq1)+1)/2)
        d=i;
        break;
    end 
end

%Only one balance goldseq should exist
while(sum(fGoldSeq(mseq1,mseq2,d+1))==(length(goldseq1)+1)/2)
    d=d+1;
end
goldseq1=fGoldSeq(mseq1,mseq2,d);
goldseq2=fGoldSeq(mseq1,mseq2,d+1);
goldseq3=fGoldSeq(mseq1,mseq2,d+2);


%% Generate Image Bit Streams And Output Original Desired Image
BitMax=160*112*3*8; %Max bits of data stream
[BitStream1,xPixels1,yPixels1]=fImageSource("Images/Image1.jpg",BitMax);
[BitStream2,xPixels2,yPixels2]=fImageSource("Images/Image2.jpg",BitMax);
[BitStream3,xPixels3,yPixels3]=fImageSource("Images/Image3.jpg",BitMax);

%Output orignal image1
fImageSink(BitStream1,xPixels1,yPixels1,"Original Desired Image");

%% QPSK Demodulator
phi=x+2*y; %in degree
Symbols1=fDSQPSKModulator(BitStream1,goldseq1,phi); %Symbols generated by DS-QPSK
Symbols2=fDSQPSKModulator(BitStream2,goldseq2,phi);
Symbols3=fDSQPSKModulator(BitStream3,goldseq3,phi);


%% Recover Transmitted Image with Environment SNR=0dB and 40dB
symbolsIn=fChannel([1;1;1],[Symbols1,Symbols2,Symbols3],[5;7;12],[0.4;0.7;0.2],[30,0;90,0;150,0],0,[0 0 0]); %Symbols pass channel
delay_estimate_0dB=fChannelEstimation(symbolsIn,goldseq1);
bitsOut_0dB=fDSQPSKDemodulator(symbolsIn,goldseq1,phi,delay_estimate_0dB); %Convert Symbols into bit stream
fImageSink(bitsOut_0dB,xPixels1,yPixels1,"Received Desired Signal with SNR=0dB"); %Output received image

%Similar with SNR=0dB, but substitue SNR for 0dB to 40dB
symbolsIn=fChannel([1;1;1],[Symbols1,Symbols2,Symbols3],[5;7;12],[0.4;0.7;0.2],[30,0;90,0;150,0],40,[0 0 0]);
delay_estimate_40dB=fChannelEstimation(symbolsIn,goldseq1);
bitsOut_40dB=fDSQPSKDemodulator(symbolsIn,goldseq1,phi,delay_estimate_40dB);
fImageSink(bitsOut_40dB,xPixels1,yPixels1,"Received Desired Signal with SNR=40dB");

%% Calculate for BER
BER_0dB=ErrorRate(BitStream1,bitsOut_0dB); %Calculate for Bit Error Rate for SNR=0dB
fprintf('The BER for SNR= 0dB is %10f\n',BER_0dB)

BER_40dB=ErrorRate(BitStream1,bitsOut_40dB); %Calculate for Bit Error Rate for SNR=40dB
fprintf('The BER for SNR= 40 dB is %10f\n',BER_40dB)