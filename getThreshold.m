function threshold = getThreshold(method,Data,p)
% get threshold
% method=1  return p(0-100) percent of maximum of Data as threshold;
% method=2  accumulate down from maximum of Data, return the value when cumulant add up to p(0-100) percent of sum of Data。

maxValue = max(max(Data));

if method == 1
    threshold = p * maxValue;
end

if method == 2
    S = sum(sum(Data));
    s = 0;
   while (s<= p*S)
        s = s + max(max(Data));
        [xm,ym] = find(Data == max(max(Data)) );
        Data(xm,ym) = 0;  
   end
    threshold = max(max(Data));
end
end

