function [u,currentColor,pass] = AImaxflip(u,currentColor,pass,flag)
%% AIRAND randomly put a stone
%
% This is the simplest move strategy: randomly chose a valid location.
%
% Long Chen 2019. May. 13.
% pos_weight = [4 2 3 3 3 3 2 4;
%             2 0 1 1 1 1 0 2;
%             3 1 2 2 2 2 1 3;
%             3 1 2 2 2 2 1 3;
%             3 1 2 2 2 2 1 3;
%             3 1 2 2 2 2 1 3;
%             2 0 1 1 1 1 0 2;
%             4 2 3 3 3 3 2 4];
% posvlaue = zeros(length(p),1);        
if ~exist('flag','var')  % flag = 0 is used for rollout
    flag = 1;     
end
%% Find all empty space
p = find(u(:) == 0); % find empty space
disp(p)
if isempty(p) % no empty space
    pass = 2;
    return
end
%% Permute location and randomly put a stone
p = p(randperm(length(p)));
pass = pass + 1;

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
%% Pass
% No valid move, pass = 1 and reverse the color
currentColor = - currentColor;