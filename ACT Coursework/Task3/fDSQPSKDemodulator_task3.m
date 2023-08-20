function [bitsOut] = fDSQPSKDemodulator_task3(symbolsIn,phi)
%         position_QPSK = [cos(phi) + 1i*sin(phi),cos(phi+pi/2) + 1i*sin(phi+pi/2),cos(phi+pi) + 1i*sin(phi+pi),cos(phi+3*pi/2) + 1i*sin(phi+3*pi/2)];
%     
%     % Demodulate symbols
%         for i = 1:length(symbolsIn)
%             dist = zeros(1,4);
%             % Calculate minimum Euclidean Distance between a symbol and 4
%             % points of QPSK
%             for j = 1:4
%                 dist(j) = abs((real(symbolsIn(i,1)) - real(position_QPSK(j))) + 1i*(imag(symbolsIn(i,1)) - imag(position_QPSK(j))));
%             end
%             [~,dist_min] = min(dist);
%             % Determine output bits through minimum Euclidean Distance
%             if dist_min == 1
%                 bitsOut(2*i-1:2*i ,1) = [0;0];
%             elseif dist_min == 2
%                 bitsOut(2*i-1:2*i ,1) = [0;1];
%             elseif dist_min == 3
%                 bitsOut(2*i-1:2*i ,1) = [1;1];
%             else 
%                 bitsOut(2*i-1:2*i ,1) = [1;0];
%             end
%         end
bitsOut=zeros(2*length(symbolsIn),1);
phi=phi/180*pi; %Change degree to radian
for i=1:4
    Ref(i)=sqrt(2)*(cos(phi+(i-1)*pi/2)+1i*sin(phi+(i-1)*pi/2)); %Calculated 4 reference points in QPSK
end


for i=1:length(symbolsIn)
    for j=1:4
        Norm(j)=norm([real(symbolsIn(i)-Ref(j)), imag(symbolsIn(i)-Ref(j))]);
    end
    Min_pos=find(Norm==min(Norm));
    %Pos(i)=Min_pos;
    %##################可以用IF IF else
    switch(Min_pos(1,1))
        case 1
            bitsOut(2*i-1:2*i)=[0;0];
        case 2
            bitsOut(2*i-1:2*i)=[0;1];
        case 3
            bitsOut(2*i-1:2*i)=[1;1];
        case 4
            bitsOut(2*i-1:2*i)=[1;0];
    end
end

end
