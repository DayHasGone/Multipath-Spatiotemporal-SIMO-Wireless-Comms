% function [Str_ASCII]=Bit2Str(BitsIn)
% %Convert Bits to String and output it
% Str_ASCII=zeros(length(BitsIn)/8,1);
% count=1;
% Bits=reshape()
% for i=1:8:length(BitsIn)
%     Str_ASCII(count)=bi2de(BitsIn(i:i+7)'); %Convert binear to Decimal
%     count=count+1;
% end
% end

% function Bit2StrAndDisplay(bitsOut)
% 
%         part=length(bitsOut)/8;
%         bit=zeros(1,part);
%         for i=1: part
%                 String="";
%             for j=1:8
%                 String=String+num2str(bitsOut((i-1)*8+j));
%             end
%             bit(i)=bin2dec(String);
%            
%         end
% disp(char(bit))
% end
function Bit2StrAndDisplay(bitsOut)
% Function:
%   - convert the demodulated bits to text
%
% InputArg(s):
%   - bitsOut: demodulated bit stream
%   - nChars: number of characters of the text
%
% OutputArg(s):
%   - none (display the text in the command window)
%
% Comments:
%   - text size should be known
%
% Author & Date: Yang (i@snowztail.com) - 1 Jan 19

%convert the bits to desired class and reshape
bitsText = reshape(bitsOut, 8, length(bitsOut)/8);
% then to decimal
bitsText = bi2de(bitsText.', 'left-msb')';

% display the text
disp(char(bitsText));

end