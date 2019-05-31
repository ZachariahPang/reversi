function [validPosition,value,tempPass] = mypositionvalue(u,currentColor,~)
% flipNum and position weight are both taken in consideration.

% if two valid positions have same weight value,
% the algorithm choose the one with more flip number.

% 8 spots with the weight of 2 are generally vulnerable since the 
% opponent could take the corner.

% those spots have the least priority,
% unless the flipNum >= 5 so that the line can't be flipped back.

% flipNum==5 means 7 spots will be occupied by our stone leaving only
% one free spot, but 2 free spots needed for opponent's stone for flipping back.

pos_weight = 10*[90 2 6 6 6 6 2 90;
                 2 1 3 3 3 3 1 2;
                 6 3 5 4 4 5 3 6;
                 6 3 4 0 0 4 3 6;
                 6 3 4 0 0 4 3 6;
                 6 3 5 4 4 5 3 6;
                 2 1 3 3 3 3 1 2;
                 90 2 6 6 6 6 2 90];
             
             
          

validPosition = find(u(:)==0);
value = zeros(length(validPosition),1);


if isempty(validPosition) 
    tempPass = 1;
    return
end
validPosition = validPosition(randperm(length(validPosition)));
for i = 1:length(validPosition)
    [~,~,flipNum] = putstone(u,validPosition(i),currentColor,0);
    if flipNum
        value(i) = pos_weight(validPosition(i))+flipNum;
        if flipNum >= 5 %  this line cannot be flipped back.
            value(i) = value(i)+40;
        end
    end
end

if max(value) == 0 % nothing can be flipped.
    tempPass = 1;
    return
end

% disp(value);
tempPass = 0;
