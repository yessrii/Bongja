function Name = DogPredict(imPath)

    load('Networks.mat')
    BuffSize = [227 227; 224 224; 224 224];
    
    im = imread(imPath);
    
    imre = imresize(im, [224 224]);
    Entry = string(classify(FirstNet, imre));
    if strcmp(Entry, 'Bichon') == false
        YPred = HierarchyPred(ResNet, GooGleNet, AlexNet, BuffSize, im);
    else
        imre = imresize(im, [224 224]);
        YPred = classify(BongJaNet, imre);
    end
    Name = string(YPred);
end

function YPred = HierarchyPred(net1, net2, net3, Size, im)
    NetGroup = {net3, net2, net1};
    
    for i=1:length(Size)
        imre = imresize(im, Size(i,:));
        RtnVal(i) = classify(NetGroup{i}, imre);
    end
    
    CatTemp = categorical(RtnVal);
    YPred = mode(CatTemp);
end