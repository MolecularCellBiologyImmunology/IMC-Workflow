Standard  Imaging Mass Cytometry Normalization and clustering Protocol  
Author: Xiaofei Yu , Medis ,Tina, Wies, Shabnam
Time : 2026.01.13

00--Before running normalization and scaling code,we made a table including max, median,mean and sd intensity of each makers to get a general idea about dataset.<code> if there is ridiculous high signal ,checking images to see if it is artifacts or aggragation.
Consider : if there is shining shape in the image ,after removing the aggregate cells, also checking the cells around the removed cells. 

01-- Usual Normalizationa and scaling step : <code>
  -- Usual checking after Normalizationa and scaling: 
  -- Plot need to be made : 
  011  Histogram: Argon 80 and  Xenon132  of each ROI.
              --> For checking the scanning quality. <code> and exmaple images
              --> If argon 80 or Xenon 132 shows wired pattern (obvious non-normal distribution)，checking the images if there are bright or dim lines in  images,whether it influce other channel,if yes, consider remove,if not ,keep .
              (consider use Median instead of mean for nomalization)
  012.	Heatmap : each marker vs ROI (scale by=NULL, after normalization)<code> and exmaple images --> recognize the abnormal values from each ROI 
  --> Abnormal markers in all ROI --> if it is background ,or staining problem ,or just high expression marker. 
  --> Abnormal regions --> high intensity of all markers (perhaps will also show in PCA and UMAP) -->technology problem or sample nature. 
  013.	PCA  : markers and ROI :<code> and exmaple images -- outlier image , what markers leading the problem?
  --> Remove images or it :  if only few channels have high intensity --> perhaps checking threshold ,but if most of the channels have problem, remove that image .
  014.  UMAP :checkinng the batch effect, weired clusters (colour by ROI/sample_ID/treatment)
              --> if high batch effect :  additional PCA reduction with Harmony correction <code> and example images
              --> if weired clusters:   check if it is real signal, otherwise remove
  015.  Dot plot to display the 10% value and 50% and 99% value of a specific maker of each images (x axis images and y axis is values ) -->
  For example:if the 10% value of image A is very close to 50% value of other images , which guide a high background in  imageA.
  Situation A: all iamges have same problem 
  Optimal the threshold and percentage according to the values..
  --> if the value is much lower than the threshold, go back to images -->1 no cells (increase threshold), 2 values are low (decrease the threshold).

  Situation B : only few images have problems ,remove, or keep,if keep:
  --> if the marker is lineage marker --. changing the threshold seperately  ,will not influence the result
  --> if the makrer is state marker -->  Maybe make a note and not include in later statistics. / OR not scale for the problematic images.

 02 Rules for approving the normalization: Umaps (colour by ROI/sample_ID/lineage markers/all makers) --> ROI and  sample_ID : mixed acceptable.   markers: lineage markers should be seperate.

 03 CLustering:  Here we use Phenograph analysis to create clusters:
   --031 -	Cluster tree and heatmap(scale by lineage marker and scale by cluster) to determine appropriate k value for clustering 
            --Roughly checking the cluster tree and select few k value , making the heatmap with these k value.. 
            --if any K value is easier to annotate important cluster, a good k value should not have many markers per celltype or many celly types (rare) are clustered together.
  --032 -   Annotate the clusters.
          --032.A quickly annotate cell type accrording to your biology acknowlege.and add some notes about positive, controversial markers. if not sure, Undefine /Unassigned/Uncertain 
          --032.B Check annotation with Image J <code and 5D notebook> --> checking the clusters with approperate lineage markers, also if wired combination . make notes for uncertain and mixed clusters
          --032.C Deal with uncertain cluster and mixed cluster : either recluster or find optimal cutoff to split the clusters
          ---> Recluster:  myeloid cells sometimes can mix together especially for DC and Mac and Monocytes.   <code>   substract possible myeloid cluster and rerun the Phenograph ,set optimal K as before.. and merge back
          ---> Split :  1 scatter plot to see if the cells ara divided into two population .  (Tregs always come from CD4 population)
                        2 Umap with annotation : For example: umap only include myeloid cells,map myeloid markers to the umap,map subclusters in umap 
                        3 set cutoff on umap
                        4 ImageJ -cross checking
                        Notes :After changing the cutoff based on umap/scatter plot,always do cross-checking  in imageJ. if not correct, change the cutoff again .these can be a loop ,it costs time,be patient
 --032  -	PCA of markers and PCA of annotations (check outliers)
 --033  Heatmap and umap with the annotated cluster : final check.
        

 Extra Problem : Edge effect , perhaps shows in umap in a cluster.  manually maybe.  Cellprofiler?
    
  


   
