function [validPosition,value,tempPass] = mypositionvalue(u,currentColor,depth)

pos_weight=[9 1 7 7 7 7 1 9;
            1 1 3 3 3 3 1 1;
            7 3 6 4 4 6 3 7;
            7 3 4 2 2 4 3 7;
            7 3 4 2 2 4 3 7;
            7 3 6 4 4 6 3 7;
            1 1 3 3 3 3 1 1;
            9 1 7 7 7 7 1 9];
        
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
        value(i) = pos_weight(validPosition(i));
    end
end
tempPass = 0;