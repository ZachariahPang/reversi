function [u,currentColor,pass] = AImaxpos(u,currentColor,pass,flag)
%% AIRAND randomly put a stone
%
% This is the simplest move strategy: randomly chose a valid location.
%
% Long Chen 2019. May. 13.
pos_weight=[9 1 7 7 7 7 1 9;
            1 1 3 3 3 3 1 1;
            7 3 6 4 4 6 3 7;
            7 3 4 2 2 4 3 7;
            7 3 4 2 2 4 3 7;
            7 3 6 4 4 6 3 7;
            1 1 3 3 3 3 1 1;
            9 1 7 7 7 7 1 9];
      
if ~exist('flag','var')  % flag = 0 is used for rollout
    flag = 1;     
end
%% Find all empty space
p = find(u(:) == 0); % find empty space
posvalue = zeros(length(p),1);  
posflip = zeros(length(p),1);
if isempty(p) % no empty space
    pass = 2;
    return
end
p = p(randperm(length(p)));
pass = pass + 1;
if length(p) <= 0
    flipNum = 0;
    for i = 1:length(p)
        [~,~,flipNum_new] = putstone(u,p(i),currentColor,0); 
        if flipNum_new > flipNum
            pos = p(i);
            flipNum = flipNum_new;
        end
    end
    if flipNum
        [u,currentColor,flipNum] = putstone(u,pos,currentColor,flag); 
        pass = 0;
        return
    end
    
    
else   
    for i = 1:length(p)
        [~,~,flipNum] = putstone(u,p(i),currentColor,0); 
        if flipNum
            posvalue(i) = pos_weight(p(i));
            posflip(i) = flipNum;
        end
    end
    [maxvalue,idx] = max(posvalue);
    flipNum = posflip(idx);
    pos = p(idx);
    for i = 1:length(p)
        if posvalue(i) == maxvalue
            if posflip(i) > flipNum
                flipNum = posflip(i);
                pos = p(i);
            end
        end
    end

    if flipNum
        [u,currentColor,flipNum] = putstone(u,pos,currentColor,flag); 
        pass = 0;
    end
    return
end
%% Pass
% No valid move, pass = 1 and reverse the color
currentColor = - currentColor;