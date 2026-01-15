library(readr)

# Set all cropping settings here:
# file = "/camp/lab/downwardj/working/IMC_team/EMUG008.1_IDU/data/20200311_KV_HypM_BRAC3371.5a_ROI_001_1.txt"
file = "/mnt/temp/imcyto/runs/Erik_Sahai_data/txtfiles/20210616_TR_HypM_MOC1_MOCAF_1B_2_ROI_001_1.txt"
output_folder = "/mnt/temp/imcyto/runs/Crops/"



df_crop = read.delim(file)
print(paste(file, " has successfully loaded on", Sys.time(), sep = ""))
# names(df_crop)  
crop_no = 0


###############
# Start from this point to make another crop of the same dataset.
###############
crop_no = crop_no+1
# Or manually set the crop number with:
# crop_no = 4

x1 = 540
x2 = 1008
y1 = 1749
y2 = 12169

print( paste("Crop coordinates are set to: X=", x1, "-", x2, " and Y=", y1, "-", y2, sep = ""))

print("now starting crop")
df_crop2 = df_crop[which(df_crop$X>=x1 & df_crop$X<=x2 & df_crop$Y>=y1 & df_crop$Y<=y2),]
print("image successfully cropped")


print("Resetting coordinates to origin")
df_crop2$X = df_crop2$X - x1
df_crop2$Y = df_crop2$Y - y1


print("Modifying column names")
for (n in c(7:length(names(df_crop2)))) {
  nm = names(df_crop2)[n]
  names(df_crop2)[n] = substr(nm, start = 2, stop = nchar(nm))
}

print("done")
filenm = unlist(strsplit(file, "/"))
length(filenm)
output_file = paste(output_folder, filenm[length(filenm)], "_crop", crop_no,".txt", sep = "")
print(paste("Saving file to ", output_file, sep=""))
write_delim(df_crop2, output_file, delim = "\t", col_names = TRUE)
print("Cropping finished")
  
