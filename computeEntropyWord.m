function H = ComputeEntropyWord(c)
% ### compute word level entropy for cell c of tokenized text (cells of strings)

if (iscell(c) == 1)

l = length(c);
types = unique(c);
lentypes = length(types);
f = zeros(1,lentypes);

% Count the occurence of unique word 
for i = 1:lentypes
    f(i) = length(strmatch(types(i),c,'exact')); %#ok<MATCH3>
end

%  Probabilities for each unique character
p = zeros(1,lentypes);
for i=1:lentypes
    p(i) = f(i)/l;
end

% Calculating the Shannon Entropy
H = 0;
for i = 1:lentypes
    H = H + (-p(i)*log2(p(i)));
end

else
    display('Invalid input');
end
