# Local-texture-descriptors (With speed optimization)
Matlab implementation, comparision and improvement of Local texture descriptors. This repo demonstrate usage of Local binary pattern (LBP), Local derivative pattern (LDP), Local Tetra pattern (LTrP), Noise Resistant LBP (NR-LBP), Histogram Refinement of Local texture descriptor for Content based image retrieval (CBIR) application.

# Performance evaluation on COREL and GHIM 10,000 database
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/perf.png)

# This repo has matlab implementation of paper titled "Histogram refinement for texture descriptor based image retrieval" 
Avalable at https://www.sciencedirect.com/science/article/pii/S0923596517300164.
Cite the above paper if using code/files from this repo.

# Steps to run CBIR
1) Download COREL 1000 dataset from and extract all images inside "image.orig" folder.
2) Run cbir.m

# Steps to benchmark your code against LBP, LDP, LTrP, NRLBP
1) Run Run_benchmark.m
2) Use the results generated for benchmarking.

# Sample results before and after histogram refinement
The sample results presented below are generated from COREL dataset where the first column is the query/search image and the rest of the column are top matches found (in order) based on L1 similarity measure of local texture histogram.

![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/152.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/500.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/510.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/513.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/518.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/529.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/530.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/552.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/562.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/578.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/581.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/594.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/60.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/664.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/69.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/725.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/863.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/889.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/902.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/953.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/978.jpg)
![Alt Text](https://github.com/Ashwani21/Local-texture-descriptors/blob/master/983.jpg)
