# grab random selection of image files for scoring VIAME

# all 15000 test images
testpath <- 'D:/image_classification_software/VIAME_proj3/testing_data/'

# get all file names
testfn <- list.files(testpath)

# get random subset of 100 images
valfn_index <- runif(100, min = 1, max = length(testfn))

valfn <- testfn[valfn_index]


# get correct subset of model predictions

detfn <- 'C:/Users/chisholme/Documents/image_classification_software/VIAME_proj5/output/input_list_detections.csv'

alldet <- read.csv(detfn, header = FALSE, skip = 2 )

# column names
colnamesdet <- c('Detection or Track-id', 'Video or Image Identifier'	,
'Unique Frame Identifier'	 , 'TL_x',	'TL_y',	'BR_x',	'BR_y'	 ,
'Detection or Length Confidence'	, 'Target Length (0 or -1 if invalid)',
 'Species_1'	, 'Confidence Pairs or Attributes_1', 'Species_2'	, 'Confidence Pairs or Attributes_2',
'Species_3'	, 'Confidence Pairs or Attributes_3', 'Species_4'	, 'Confidence Pairs or Attributes_4', 
'Species_5'	, 'Confidence Pairs or Attributes_5', 'Species_6'	, 'Confidence Pairs or Attributes_6'
,'Species_7'	, 'Confidence Pairs or Attributes_7')											


names(alldet) <- colnamesdet


# subset data based on random 100 images

subdet <- alldet[alldet$`Video or Image Identifier` %in% valfn,]

subdet2 <- subdet[,1:11]

# renumber images 0-100

subdet2$`Detection or Track-id` <- c(0:(length(subdet2[[1]])-1))
names(subdet2) <- NULL

#write out file for scoring
outpath <- 'C:/Users/chisholme/Documents/image_classification_software/VIAME_proj5/scoring/'


write.csv(subdet2, file = file.path(outpath, 'detections.csv'), col.names = FALSE, row.names = FALSE)

# output 100 image subset list for groundtruth

valfn_full <- list.files(testpath, full.names = TRUE)
valfn_full <- valfn_full[valfn_index]

sink(file.path(outpath, 'scoring_input_list.txt'))
for(i in 1:length(valfn_full)){
  cat(valfn_full[[i]], '\n')
}
sink()




