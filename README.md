# Local-texture-descriptors (With speed optimization)
Matlab implementation, comparision and improvement of Local texture descriptors. This repo demonstrate usage of Local binary pattern (LBP), Local derivative pattern (LDP), Local Tetra pattern (LTrP), Noise Resistant LBP (NR-LBP), Histogram Refinement of Local texture descriptor for Content based image retrieval (CBIR) application.

#### Performance evaluation on COREL and GHIM 10,000 database
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/perf.png)

#### This repo has matlab implementation of paper titled "Histogram refinement for texture descriptor based image retrieval" 
Avalable at https://www.sciencedirect.com/science/article/pii/S0923596517300164.
Cite the above paper if using code/files from this repo.

#### Steps to run CBIR
1) Download COREL 1000 dataset from and extract all images inside "image.orig" folder.
2) Run cbir.m

#### Steps to benchmark your code against LBP, LDP, LTrP, NRLBP
1) Run Run_benchmark.m
2) Use the results generated for benchmarking.

##### The result from Run_benchmark.m is shown below which is very close to the values reported in the paper.<br/>
_Generating Local Skew pattern (LSP); Percentage completed : 1000 / 1000<br/>
benchmarking Local biniary pattern (LBP); Percentage completed : 1000 / 1000<br/>
classification accuracy: LBP (original) is 69.120 <br/>
classification accuracy: LBP (With histogram refinement) is 74.910 <br/>
benchmarking Local derivative pattern (LDP); Percentage completed : 1000 / 1000<br/>
classification accuracy: LDP (original) is 69.600 <br/>
classification accuracy: LDP (With histogram refinement) is 74.380 <br/>
benchmarking Local Tetra pattern (LTrP); Percentage completed : 1000 / 1000<br/>
classification accuracy: LTrP (original) is 65.820 <br/>
classification accuracy: LTrP (With histogram refinement) is 71.000 <br/>
 benchmarking Noise-resistant Local biniary pattern (NRLBP); Percentage completed : 1000 / 1000<br/>
classification accuracy: NRLBP (original) is 67.450 <br/>
classification accuracy: NRLBP (With histogram refinement) is 73.540<br/>_

#### Sample results before and after histogram refinement
The sample results presented below are generated from COREL dataset where the first column is the query/search image and the rest of the column are top matches found (in order) based on L1 similarity measure of local texture histogram.

![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/Sample_cbir_results/152.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/Sample_cbir_results/500.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/Sample_cbir_results/510.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/Sample_cbir_results/513.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/Sample_cbir_results/518.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/Sample_cbir_results/529.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/Sample_cbir_results/530.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/Sample_cbir_results/552.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/Sample_cbir_results/562.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/Sample_cbir_results/578.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/Sample_cbir_results/581.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/Sample_cbir_results/594.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/Sample_cbir_results/60.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/Sample_cbir_results/664.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/Sample_cbir_results/69.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/Sample_cbir_results/725.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/Sample_cbir_results/863.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/Sample_cbir_results/889.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/Sample_cbir_results/902.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/Sample_cbir_results/953.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/Sample_cbir_results/978.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/Sample_cbir_results/983.jpg)
