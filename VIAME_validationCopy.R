# pull validation images

vallist <- 'D:/image_classification_software/VIAME_proj4/scoring_input_list.txt'

valread <- read.table(vallist)


# validation folder
valdir <-  'D:/image_classification_software/VIAME_proj4/validation_data/'
dir.create(valdir)
# pull images into new folder (copy)

for(i in 1:length(valread[[1]])){
file.copy(from = valread[[1]][i], to = valdir)
}
