clear, clc;
load petGT.mat
anchorBoxes = anchorBoxMaker(petGT, 5);

basenet = resnet18;
lgraph = yolov2Layers([224 224 3], 5, anchorBoxes, basenet, ...
    'res5b_relu', 'ReorgLayerSource', 'res3a_rellu');

options = trainingOptions("adam","MiniBatchSize",32,"InitialLearnRate", 1e-3, ...
    "MaxEpochs", 20, "LearnRateSchedule", "piecewise", ...
    "LearnRateDropPeriod",10,"Shuffle","every-epoch")

% YOLO 학습시키기
detector = trainYOLOv2ObjectDetector(petGT, lgraph, options);