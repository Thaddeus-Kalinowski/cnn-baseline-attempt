% Dataset: 
% https://huggingface.co/datasets/kostaspic/amfitrite-open-waters-hab-sentinel2

filepath = ".\1816_nonHAB"

t1  = imread(fullfile(filepath,"B01_raw.tif"));
t2  = imread(fullfile(filepath,"B02_raw.tif"));
t3  = imread(fullfile(filepath,"B03_raw.tif"));
t4  = imread(fullfile(filepath,"B04_raw.tif"));
t5  = imread(fullfile(filepath,"B05_raw.tif"));
t6  = imread(fullfile(filepath,"B06_raw.tif"));
t7  = imread(fullfile(filepath,"B07_raw.tif"));
t8  = imread(fullfile(filepath,"B08_raw.tif"));
t10 = imread(fullfile(filepath,"B8A_raw.tif"));
t9  = imread(fullfile(filepath,"B09_raw.tif"));
t11 = imread(fullfile(filepath,"B11_raw.tif"));
t12 = imread(fullfile(filepath,"B12_raw.tif"));
%t13 = imread(fullfile(filepath,"AOT_raw.tif"));
%t14 = imread(fullfile(filepath,"SCL_raw.tif"));
%t15 = imread(fullfile(filepath,"WVP_raw.tif"));

%combinedImages = cat(3,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15);
combinedImages = cat(3,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12);

% Bands' central wavelengths taken from this Sentinel 2 article
% https://gisgeography.com/sentinel-2-bands-combinations/

% Making a multispectral imagery cube out of 12 2D images
mcube = immulticube(combinedImages,[443,490,560,665,705,740,783,842,865, ...
   940,1610,2190]);

% Colorize the multispectral cube and show the image to the user
img = colorize(mcube);
imageshow(img);

% TODO: Fix all the dataset data before we train our Neural Network

% CNN Tutorial: https://www.mathworks.com/help/deeplearning/ug/create-simple-deep-learning-network-for-classification.html
% layers = [
%     imageInputLayer([256 256 3])
% 
%     convolution2dLayer(3,8,Padding="same")
%     batchNormalizationLayer
%     reluLayer
% 
%     maxPooling2dLayer(2,Stride=2)
% 
%     convolution2dLayer(3,16,Padding="same")
%     batchNormalizationLayer
%     reluLayer
% 
%     maxPooling2dLayer(2,Stride=2)
% 
%     convolution2dLayer(3,32,Padding="same")
%     batchNormalizationLayer
%     reluLayer
% 
%     fullyConnectedLayer(10)
%     softmaxLayer
% ];

% Don't forget to split the dataset into training and validation sets.
%numTrainFiles = 750;
%[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,"randomize");


%ValidationData=imdsValidation, ValidationFrequency=30,
% options = trainingOptions("sgdm", InitialLearnRate=0.01, MaxEpochs=4, Shuffle="every-epoch", ...
%     Plots="training-progress", Metrics="accuracy");

% Start the training
%net = trainnet(imdsTrain,layers,"crossentropy",options);

% Use network to classify images and then compute those classifications'
% accuracies
%scores = minibatchpredict(net, imdsValidation);
%YValidation = scores2label(scores, classNames);
%TValidation = imdsValidation.Labels;
%accuracy = mean(YValidation == TValidation)
