## March Madness Prediction

Using a model built from historical, season level stats to help me fill out my bracket for the 2019 tournament. 

### About the Data

The data has three components:

- Season level stats, for NCAA teams from 1995 to 2019. This is scraped from sports-reference.com. Sadly there is a bias here, sports reference includes data from the post-season each year as well. So I limited the features in my model to only included percentage columns, not any with absolute quantities.

- Tournament-game data from 1995 to 2019. This is from [mmclaughlin87][1] github repository for the years 1995 to 2018. For 2017 and 2018, I dug further into the original source in [this pdf][2]. This data is the source of my dependent variable, which is the sum of the total winnings margin for each team for each year.

- The 2019 [kenpom.com ratings][3].


### My Session Info

  R version 3.5.2 (2018-12-20)
  Platform: x86_64-apple-darwin15.6.0 (64-bit)
  Running under: macOS High Sierra 10.13.4
  
  Matrix products: default
  BLAS: /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libBLAS.dylib
  LAPACK: /Library/Frameworks/R.framework/Versions/3.5/Resources/lib/libRlapack.dylib
  
  locale:
  [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
  
  attached base packages:
  [1] stats     graphics  grDevices utils     datasets  methods   base     
  
  other attached packages:
   [1] tictoc_1.0      ranger_0.11.1   lme4_1.1-17     Matrix_1.2-15   bindrcpp_0.2.2  lubridate_1.7.4 rvest_0.3.2     xml2_1.2.0      forcats_0.3.0  
  [10] stringr_1.3.1   dplyr_0.7.8     purrr_0.2.5     readr_1.1.1     tidyr_0.8.2     tibble_2.0.1    ggplot2_3.1.0   tidyverse_1.2.1
  
  loaded via a namespace (and not attached):
   [1] progress_1.2.0     tidyselect_0.2.5   reshape2_1.4.3     splines_3.5.2      haven_1.1.1        lattice_0.20-38    colorspace_1.4-0  
   [8] yaml_2.2.0         utf8_1.1.4         rlang_0.3.1.9000   nloptr_1.0.4       pillar_1.3.1       glue_1.3.0         withr_2.1.2       
  [15] selectr_0.4-1      RColorBrewer_1.1-2 modelr_0.1.1       readxl_1.1.0       bindr_0.1.1        plyr_1.8.4         munsell_0.5.0     
  [22] gtable_0.2.0       cellranger_1.1.0   labeling_0.3       GGally_1.4.0       curl_3.2           fansi_0.4.0        broom_0.5.0       
  [29] Rcpp_1.0.0         scales_1.0.0       backports_1.1.3    jsonlite_1.6       digest_0.6.18      hms_0.4.2          stringi_1.2.4     
  [36] grid_3.5.2         cli_1.0.1          tools_3.5.2        magrittr_1.5       lazyeval_0.2.1     crayon_1.3.4       pkgconfig_2.0.2   
  [43] MASS_7.3-51.1      prettyunits_1.0.2  minqa_1.2.4        assertthat_0.2.0   reshape_0.8.7      httr_1.3.1         rstudioapi_0.7    
  [50] R6_2.3.0           nlme_3.1-137       compiler_3.5.2

[1]: https://github.com/mmclaughlin87/march-madness-historical-perfomance
[2]: http://www.hoopstournament.net/StandardReports/By_Year.pdf
[3]: https://kenpom.com/index.php?y=2019
