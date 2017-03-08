function [to, vocabfull, docstokens, filename, tfcw, tfdw, bi] = tdmVanilla(datapath)

% generate term-document matrix for plain vanilla files
% input:
%   path for corpus folder
% output
%   to: term occurrences (raw frequencies), i.e. number of times that term t occurs in document d
%   vocabfull: corpus vocabulary/types
%   tfcw: term frequency weigthed by total number of tokens in corpus
%   tfdw: term frequency weigthed by total number of tokens in each document
%   bi: boolean term occurences

% example
    % filepath = 'C:\Users\KLN\Documents\textAnalysis\kingJamesBibleExample';
    % [to,vocabulary] = tdmVanilla(filepath);

filename = getAllFiles(datapath);
fileN = length(filename);
[docs,docstokens] = deal(cell(fileN,1));
for i = 1:fileN;
    disp(i)
    docs{i} = fileread(filename{i});
    temp = strtrim(regexprep(docs{i},'([^\D]+)',' '));% remove numbers
    temp = strtrim(regexprep(temp,'([^\w]+)',' '));% non-alphabetic characters
    temp = regexprep(['''',temp,''''],' ',''','''); % insert '' and , around alphabetic sequence
    evalc(['tokens = {',temp,'}']); % assign tokens
    docstokens{i} = lower(tokens);
end
[vocab,void,index,frequencies] = deal(cell(fileN,1));
[words,vocabwords] = deal(zeros(fileN,1));
for i = 1:fileN
    words(i) = length(docstokens{i});
    [vocab{i},void{i},index{i}] = unique(docstokens{i});
    vocabwords(i) = length(vocab{i});
    frequencies{i} = hist(index{i},vocabwords(i));
end
vocabfull = unique([vocab{:}]);
vocabfullN = length(vocabfull);
to = zeros(fileN,vocabfullN);
for i = 1:fileN
    for ii = 1:vocabfullN
        to(i,ii) = sum(strcmp(vocabfull(ii),docstokens{i}));
    end
end
bi = to~=0;
tokenN = sum(sum(to));
tfcw = to./tokenN;
tfdw = zeros(size(to));
for i = 1:fileN;
    tfdw(i,:) = to(i,:)./length(vocab{i});
end
% remove path from filename
for i = 1:length(filename)
    index = find(filename{i} == '\', 1, 'last' );
    filename{i} = filename{i}(index+1:end);
end
