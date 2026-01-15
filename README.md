Standard  Imaging Mass Cytometry Normalization and clustering Protocol  
Author: Xiaofei Yu , Medis ,Tina, Wies, Shabnam
Time : 2026.01.13

00--Before running normalization and scaling code,we made a table including max, median,mean and sd intensity of each makers to get a general idea about dataset.<code> if there is ridiculous high signal ,checking images to see if it is artifacts or aggragation.
Consider : if there is shining shape in the image ,after removing the main cells, also checking the cells around the removed cells. 

01-- Usual Normalizationa and scaling step : <code>
  -- Usual checking after Normalizationa and scaling: 
  -- Plot need to be made : 
  011  Histogram: Argon 80 and  Xenon132  of each ROI.
              --> For checking the scanning quality. <code> and exmaple images
              --> If argon 80 or Xenon 132 shows wired pattern (obvious non-normal distribution)，checking the images if there are bright or dim lines in  images,whether it influce other channel,if yes, consider remove,if not ,keep . (consider use Median instead of mean for nomalization,or select safe region for mean)
  012.	Heatmap : each marker vs ROI (scale by=NULL, after normalization)<code> and exmaple images --> recognize the abnormal values from each ROI 
  --> Abnormal markers in all ROI --> if it is background ,or staining problem ,or just high expression marker. 
  --> Abnormal regions --> high intensity of all markers (perhaps will also show in PCA and UMAP) -->technology problem or sample nature. 
  013.	PCA  : markers and ROI :<code> and exmaple images -- outlier image , what markers leading the problem?
  --> Remove images or it :  if only few channels have high intensity --> perhaps checking threshold ,but if most of the channels have problem, remove that image .
  014.  UMAP :checkinng the batch effect, weired clusters (colour by ROI/sample_ID/treatment)
              --> if high batch effect :  additional PCA reduction with Harmony correction <code> and example images
  015.  Dot plot to display the 10% value and 50% and 99% value of a specific maker of each images (x axis images and y axis is values ) -->
  For example:if the 10% value of image A is very close to 50% value of other images , which guide a high background in  imageA.
  Situation A: all iamges have same problem 
  Optimal the threshold and percentage according to the values..
  --> if the value is much lower than the threshold, go back to images -->1 no cells (increase threshold), 2 values are low (decrease the threshold).

  Situation B : only few images have problems 
  --> if the marker is lineage marker --. changing the threshold seperately  ,will not influence the result
  --> if the makrer is state marker -->  Maybe make a note and not include in later statistics. / OR not scale for the problematic images.
