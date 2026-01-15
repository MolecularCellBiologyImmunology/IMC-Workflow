Standard  Imaging Mass Cytometry Normalization and clustering Protocol  
Author: Xiaofei Yu , Medis ,Tina, Shabnam, Wies
Time : 2026.01.13

Standard Operating Procedure (SOP)
IMC Data Quality Control, Normalization, and Clustering
Step 0. Pre-Normalization Quality Assessment
Step 0.1 Generate Summary Statistics
1.	For each marker, calculate:
o	Maximum
o	Median
o	Mean
o	Standard deviation
2.	Compile results into a summary table.
Step 0.2 Inspect Extreme Values
1.	Identify markers or ROIs with unusually high signal.
2.	Open corresponding images and check for:
o	Artifacts
o	Cell aggregation
3.	If shining or abnormally bright structures are present:
o	Remove aggregate cells.
o	Inspect cells surrounding the removed aggregates to ensure they are not affected.

Step 1. Normalization and Scaling
Step 1.1 Perform Standard Normalization and Scaling
1.	Apply the standard normalization and scaling procedure to all ROIs.

Step 2. Post-Normalization Quality Control
Step 2.1 Check Scanning Quality Using Histograms
1.	Generate histograms of Argon80 and Xenon132 for each ROI.
2.	Evaluate histogram shapes:
o	Normal-like distributions → acceptable.
o	Abnormal distributions (e.g., strong skew or non-normal shape) → proceed to Step 2.1.3.
3.	If abnormalities are observed:
o	Inspect raw images for:
	Bright lines
	Dim lines
o	Determine whether artifacts affect other channels:
	If yes → consider removing the image.
	If no → keep the image.
4.	If necessary, consider using median-based normalization instead of mean.

Step 2.2 Generate Marker × ROI Heatmap
1.	Create a heatmap of markers vs. ROIs:
o	After normalization
o	scale = NULL
2.	Identify abnormal patterns:
o	Abnormal markers across all ROIs
o	Abnormal ROIs with globally high intensities
3.	Interpret abnormalities:
o	Marker-wide abnormalities:
	Background staining
	Staining failure
	True high expression
o	ROI-specific abnormalities:
	Likely technical issues or intrinsic sample characteristics

Step 2.3 Perform PCA (Outlier Detection)
1.	Generate:
o	PCA of markers
o	PCA of ROIs
2.	Identify outlier images.
3.	Determine contributing markers:
o	If only a few markers are problematic → consider threshold adjustment.
o	If most markers are problematic → remove the image.

Step 2.4 Perform UMAP Analysis
1.	Generate UMAPs colored by:
o	ROI
o	Sample ID
o	Treatment group
2.	Evaluate:
o	Batch effects
o	Unexpected or “weird” clusters
3.	If strong batch effects are detected:
o	Perform additional PCA reduction with Harmony correction.
4.	If abnormal clusters are detected:
o	Verify whether they represent real biological signals.
o	If not → remove affected cells or images.

Step 2.5 Marker Distribution Dot Plot
1.	Generate dot plots displaying:
o	10%
o	50%
o	99% quantiles
for a specific marker across images.
2.	Interpretation:
o	If the 10% quantile of one image is close to the 50% quantile of others:
	Indicates high background in that image.
Case A: All Images Affected
1.	Optimize thresholds and percentile cutoffs globally.
2.	If values are far below threshold:
o	Re-inspect images:
	No cells detected → increase threshold.
	Signal too weak → decrease threshold.
Case B: Only Some Images Affected
1.	Decide whether to remove or keep affected images.
2.	If keeping:
o	Lineage markers:
	Adjust thresholds individually.
o	State markers:
	Either exclude from downstream statistics, or
	Avoid scaling for problematic images.

Step 3. Approval Criteria for Normalization
1.	Generate UMAPs colored by:
o	ROI
o	Sample ID
o	Lineage markers
o	All markers
2.	Accept normalization if:
o	ROI and Sample ID distributions are mixed.
o	Lineage markers show clear separation.

Step 4. Clustering Analysis (Phenograph)
Step 4.1 Determine Optimal k
1.	Run Phenograph with multiple candidate k values.
2.	Generate:
o	Cluster tree
o	Heatmaps scaled by:
	Lineage markers
	Cluster
3.	Select k that:
o	Produces biologically interpretable clusters
o	Avoids merging rare and unrelated cell types
o	Does not assign excessive markers to single clusters

Step 4.2 Cluster Annotation
Step 4.2.1 Initial Annotation
1.	Annotate clusters based on biological knowledge.
2.	Record:
o	Positive markers
o	Controversial markers
3.	Label uncertain clusters as:
o	Undefined / Unassigned / Uncertain

Step 4.2.2 Image-Based Validation
1.	Validate annotations using ImageJ.
2.	Confirm:
o	Marker localization
o	Absence of biologically implausible combinations
3.	Add notes for mixed or uncertain clusters.

Step 4.2.3 Resolve Mixed or Uncertain Clusters
Option A: Reclustering
1.	Subset suspected mixed populations (e.g., myeloid cells).
2.	Rerun Phenograph.
3.	Select optimal k.
4.	Merge refined clusters back into the full dataset.
Option B: Cluster Splitting
1.	Generate scatter plots to detect bimodal populations.
2.	Generate UMAPs of the relevant subset.
3.	Map lineage and functional markers.
4.	Define cutoffs in UMAP space.
5.	Validate results in ImageJ.
Important:
After every cutoff adjustment, repeat ImageJ validation.
Iterate until annotation is correct. these can be a loop ,it costs time, be patient

Step 4.2.4  PCA
Perform:
•	PCA of markers
•	PCA of annotations



Step 4.3 Final Quality Control
1.	Generate final:
o	Heatmap
o	UMAP with annotated clusters


Optional question . Address Edge Effects
1.	Inspect UMAPs for clusters driven by edge effects.
2.	Manually inspect affected regions.
3.	Apply correction if necessary (e.g., using CellProfiler).










































   
