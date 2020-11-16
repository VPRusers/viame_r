# sort validation images into automated categories to get an idea of how the model performs


# load in detections
detfn <- 'D:/image_classification_software/VIAME_proj4/scoring/detections.csv'

dets <- read.csv(detfn)

# column names
detcol <- c('Detection or Track-id', 'Video or Image Identifier'	,
            'Unique Frame Identifier'	 , 'TL_x',	'TL_y',	'BR_x',	'BR_y'	 ,
            'Detection or Length Confidence'	, 'Target Length (0 or -1 if invalid)',
            'Species_predicted'	, 'Confidence Pairs or Attributes')

names(dets) <- detcol

sp_list <- unique(dets$Species_predicted)

for(i in 1:length(sp_list)){
  out_dir <- file.path('D:/image_classification_software/VIAME_proj4/validation_sorted', sp_list[[i]])
  dir.create(out_dir, recursive = TRUE)

  det_sp <- dets[dets$Species_predicted == sp_list[[i]],]
  
  sp_fn <- file.path('D:/image_classification_software/VIAME_proj4/validation_data', det_sp$`Video or Image Identifier`)
  out_fn <- file.path(out_dir, det_sp$`Video or Image Identifier`)
  
  for(ii in 1:length(sp_fn)){
  file.copy(from = sp_fn[[ii]], to = out_fn[[ii]])
  }
  
  
}
