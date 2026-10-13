% https://www.mathworks.com/help/deeplearning/ug/create-simple-deep-learning-network-for-classification.html
layers = [
    imageInputLayer([256 256 1])

    convolution2dLayer(3,5,Padding="same")
    batchNormalizationLayer
    reluLayer

    averagePooling2dLayer(3,Stride=2)

    convolution2dLayer(4,6,Padding="same")
    batchNormalizationLayer
    reluLayer

    averagePooling2dLayer(3,Stride=2)

    convolution2dLayer(4,7,Padding="same")
    batchNormalizationLayer
    reluLayer

    fullyConnectedLayer(2)
    sigmoidLayer
];

imds = imageDatastore("C:\Users\thad5\Documents\MATLAB\rearranged_data\data", ... 
    IncludeSubfolders=true, LabelSource="foldernames", FileExtensions=".tif");

classNames = categories(imds.Labels);
labelCount = countEachLabel(imds)

% Don't forget to split the dataset into training and validation sets.
[imdsTrain, imdsValidation] = splitEachLabel(imds, 0.6, 0.4);

options = trainingOptions("sgdm", InitialLearnRate=0.001, MaxEpochs=1, Shuffle="every-epoch", ...
    Plots="training-progress", Metrics="accuracy", ...
    ValidationData=imdsValidation, ValidationFrequency=5);

% Start the training
net = trainnet(imdsTrain,layers,"binary-crossentropy",options);

% Use network to classify images and then compute those classifications'
% accuracies
valScores = minibatchpredict(net, imdsValidation)

ValValidation = scores2label(valScores, classNames);
TrainValidation = imdsValidation.Labels;

accuracy = mean(ValValidation == TrainValidation)