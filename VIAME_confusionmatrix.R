# VIAME confusion matrix

library(dplyr)
library(ggplot2)

# load in detections
detfn <- 'C:/Users/chisholme/Documents/image_classification_software/VIAME_proj5/scoring/detections.csv'
# load in groundtruth
gtfn <- 'C:/Users/chisholme/Documents/image_classification_software/VIAME_proj5/scoring/groundtruth.csv'


det <- read.csv(detfn, header = FALSE)
gt <- read.csv(gtfn, header = FALSE)

# column names
detcol <- c('Detection or Track-id', 'Video or Image Identifier'	,
            'Unique Frame Identifier'	 , 'TL_x',	'TL_y',	'BR_x',	'BR_y'	 ,
            'Detection or Length Confidence'	, 'Target Length (0 or -1 if invalid)',
            'Species_predicted'	, 'Confidence Pairs or Attributes')

gtcol <- c('Detection or Track-id', 'Video or Image Identifier'	,
           'Unique Frame Identifier'	 , 'TL_x',	'TL_y',	'BR_x',	'BR_y'	 ,
           'Detection or Length Confidence'	, 'Target Length (0 or -1 if invalid)',
           'Species_actual'	, 'Confidence Pairs or Attributes')

names(gt) <- gtcol
names(det) <- detcol


# merge data

dtf <- full_join(gt, det, by = 'Video or Image Identifier') %>%
  dplyr::select(., 'Video or Image Identifier', 'Species_actual', 'Species_predicted')

# create matrix

truth <- factor(dtf$Species_actual, levels = unique(dtf$Species_predicted))
pred <- factor(dtf$Species_predicted, levels = unique(dtf$Species_predicted))

library(caret)
cm <- caret::confusionMatrix(pred, truth)

cmplot <- as.data.frame(cm$table)

# normalize


# plot confusion matrix
ggplot(na.omit(cmplot))+
  geom_tile(aes(x = Reference, y = Prediction, fill = Freq))

p <-  ggplot(cmplot) +geom_tile(aes(x=Reference, y=Prediction, fill=Freq)) +  #adds data fill
  theme(axis.text.x=element_text(angle=45, hjust=1)) + #fixes x axis labels
  scale_x_discrete(name="Actual Class") + #names x axis
  scale_y_discrete(name="Predicted Class") + #names y axis
  #scale_fill_gradient(breaks=seq(from=-.5, to=4, by=.2)) + #creates colour scale
  labs(fill="Frequency") + #legend title
  #theme(legend.position = "none" ) +  #removes legend
  ggtitle(label = paste('Confusion Matrix'))

#acc <- cmplot$Freq[cmplot$Reference == cmplot$Prediction]
#for each taxa
for (i in 1:length(unique(cmplot$Reference))){

  #add text label
    predval <- cmplot$Prediction[i]
    actval <- cmplot$Reference[i]
  p <- p + annotate('text', x = cmplot$Reference, y = cmplot$Prediction, #position 
                    #label with frequency as percent rounded to 2 digits
                    label = cmplot$Freq,
                    #text formatting
                    colour = 'white',
                    size = 3)
  
  }



