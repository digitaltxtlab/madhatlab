function tfidf = tfidfVanilla(to)
% calculates tfidf from raw occurrences
% input: output from tdmVanilla
% output: Term frequency�Inverse document frequency term document matrix
% TF raw frequency f_t,d

tfraw = to;
% IDF weight
N = size(tfraw,1)*ones(1,size(tfraw,2));
docN =  sum(tfraw ~= 0,1);
idf = log(N./docN);% natural logarithm
% tfidf
tfidf = zeros(size(tfraw));
for i = 1:size(tfraw,2)
    tfidf(:,i) = tfraw(:,i)*idf(i);
end
