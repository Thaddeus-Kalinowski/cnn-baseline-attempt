% Dataset: https://huggingface.co/datasets/kostaspic/amfitrite-open-waters-hab-sentinel2

filepath = "C:\Users\thad5\Desktop\dataset\amfitrite-open-waters-hab-sentinel2\data";

function folder = folderFromNum(number, filepath)
    if number < 0 || number > 2981
        error("folderFromNum only accepts numbers 0-2981")
    end
    searchstr = num2str(number) + "_";
    
    % Find folder name in data starting with "0_" or "123_"

    folderList = dir(fullfile(filepath,searchstr+"*"));
    folder = folderList.name;
end

function image = getImage(folder)
    t1  = imread(fullfile(folder,"B01_raw.tif"));
    t2  = imread(fullfile(folder,"B02_raw.tif"));
    t3  = imread(fullfile(folder,"B03_raw.tif"));
    t4  = imread(fullfile(folder,"B04_raw.tif"));
    t5  = imread(fullfile(folder,"B05_raw.tif"));
    t6  = imread(fullfile(folder,"B06_raw.tif"));
    t7  = imread(fullfile(folder,"B07_raw.tif"));
    t8  = imread(fullfile(folder,"B08_raw.tif"));
    t9  = imread(fullfile(folder,"B09_raw.tif"));
    t10 = imread(fullfile(folder,"B8A_raw.tif"));
    t11 = imread(fullfile(folder,"B11_raw.tif"));
    t12 = imread(fullfile(folder,"B12_raw.tif"));

    combinedFiles = cat(3,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12);
    mcube = immulticube(combinedFiles);
    img = colorize(mcube, 4:-1:2);
    image = img;
end

%img1 = getImage(fullfile(filepath,folderFromNum(1234, filepath)));

% For loop that just takes all the full-spectrum images and saves them to
% my computer (takes like 15 minutes btw)
% for i = 0:2981
%     folderName = folderFromNum(i, filepath);
%     img = getImage(fullfile(filepath,folderName));
%     imwrite(img, "C:\Users\thad5\Desktop\sentinel2\" + folderName + ".png");
%     i
% end


% Tutorial: 
% https://www.mathworks.com/help/deeplearning/ug/create-simple-deep-learning-network-for-classification.html
layers = [
    imageInputLayer([256 256 3])

    convolution2dLayer(4,8,Padding="same")
    batchNormalizationLayer
    reluLayer

    maxPooling2dLayer(3,Stride=2)

    convolution2dLayer(3,16,Padding="same")
    batchNormalizationLayer
    reluLayer

    maxPooling2dLayer(3,Stride=2)

    convolution2dLayer(4,32,Padding="same")
    batchNormalizationLayer
    reluLayer

    fullyConnectedLayer(2)
    softmaxLayer
];

imds = imageDatastore("C:\Users\thad5\Desktop\sentinel2", LabelSource="foldernames", IncludeSubfolders=true);

% Don't forget to split the dataset into training and validation sets.
numTrainFiles = 1445;
[imdsTrain,imdsValidation] = splitEachLabel(imds, numTrainFiles, "randomize");


options = trainingOptions("sgdm", InitialLearnRate=0.001, MaxEpochs=10, Shuffle="every-epoch", ...
    Plots="training-progress", Metrics="accuracy", ...
    ValidationData=imdsValidation, ValidationFrequency=10);

% Start the training
net = trainnet(imdsTrain,layers,"crossentropy",options);

% Use network to classify images and then compute those classifications'
% accuracies
scores = minibatchpredict(net, imdsValidation);
YValidation = scores2label(scores, classNames);
TValidation = imdsValidation.Labels;
accuracy = mean(YValidation == TValidation)