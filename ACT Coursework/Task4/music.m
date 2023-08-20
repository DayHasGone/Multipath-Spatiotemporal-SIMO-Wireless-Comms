function [DOA_estimate,delay_estimate] = music(array, Rxx,goldseq,N_ext)
% Find desired siganls delay, DOA and noise subspace En using PN-code of
% desired signal and N_extend
%
%   Input: array matrix, covariance matrix of vactorised symbols
%   matrix,PN-code used by desired signal,N_extend
%
%   Output:estimated DOA, estimated delay and environment noise subspace


%eigenvalue decomposition
[EV,D]=eig(Rxx);% EV:Eigen vector; D:eigen value
EVA=diag(D);
[EVA,Index]=sort(EVA); %Order the eigenvalues from smallest to largest

%Form noise subspace
for i=1:max(find(EVA<=0.1)) %The threshold 0.1 is got from EVA_0dB, to see the noise power
    En(:,i)=EV(:,Index(i)); %Noise subspace
end

% Go through each Angle and calculate the spv then ST manifold
len=length(goldseq);
for az = 1:361 
    for delay = 1:len
        S=spv(array,[az-1,0]); %Since elevation is zero
        h=S2H(S,goldseq,N_ext,delay);
        MUSIC(az,delay)=1/(h'*En*En'*h);
    end
end
Abs_music=abs(MUSIC);
Z(:,1)=Abs_music(:,len); %Since delay 15=delay 0
Z=[Z Abs_music(:,1:len-1)];

figure
surf(0:len-1,0:360,Z,'EdgeColor','flat'); %Show 3D figure to find peaks
xlabel('Delay') ;
ylabel('Direction of Arrival');
zlabel('Z') ;

%Find DOA and delay for each path
for iPath=1:3 %From figure we know there are 3 paths used by desired signal
[DOA_estimate(iPath),delay_estimate(iPath)]=find(Z==max(Z(:)));
DOA_estimate(iPath)=DOA_estimate(iPath)-1; %DOA estimation
Z(:,delay_estimate(iPath))=0; %Aimed to find the next delay
delay_estimate(iPath)=delay_estimate(iPath)-1; %Delay estimation
end

end

