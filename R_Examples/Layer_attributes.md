## get layer names within a GDB

    library(sf)

    ## Linking to GEOS 3.9.1, GDAL 3.2.1, PROJ 7.2.1; sf_use_s2() is TRUE

    x <- 'D:/data/data_projects/vri_gdb/VEG_COMP_LYR_R1_POLY_2020.gdb'

    # returns list of layers present within a GDB
    layers <- st_layers(x)$name

    layers

    ## [1] "VEG_COMP_LYR_R1_POLY"

## get list of attributes from GDB

Note that this will only work if there is 1 layer.  
Otherwise, pick the layer of interest.

    qry <- paste0('select * from ',layers,' limit 0')

    l1 <- st_read(x,query=qry)

    ## Reading query `select * from VEG_COMP_LYR_R1_POLY limit 0' from data source `D:\data\data_projects\vri_gdb\VEG_COMP_LYR_R1_POLY_2020.gdb' 
    ##   using driver `OpenFileGDB'
    ## Simple feature collection with 0 features and 192 fields
    ## Bounding box:  xmin: NA ymin: NA xmax: NA ymax: NA
    ## Projected CRS: NAD83 / BC Albers

    l1

    ## Simple feature collection with 0 features and 192 fields
    ## Bounding box:  xmin: NA ymin: NA xmax: NA ymax: NA
    ## Projected CRS: NAD83 / BC Albers
    ##   [1] FEATURE_ID                    MAP_ID                       
    ##   [3] POLYGON_ID                    OPENING_IND                  
    ##   [5] OPENING_SOURCE                OPENING_NUMBER               
    ##   [7] FEATURE_CLASS_SKEY            INVENTORY_STANDARD_CD        
    ##   [9] POLYGON_AREA                  NON_PRODUCTIVE_DESCRIPTOR_CD 
    ##  [11] NON_PRODUCTIVE_CD             INPUT_DATE                   
    ##  [13] COAST_INTERIOR_CD             SURFACE_EXPRESSION           
    ##  [15] MODIFYING_PROCESS             SITE_POSITION_MESO           
    ##  [17] ALPINE_DESIGNATION            SOIL_NUTRIENT_REGIME         
    ##  [19] ECOSYS_CLASS_DATA_SRC_CD      BCLCS_LEVEL_1                
    ##  [21] BCLCS_LEVEL_2                 BCLCS_LEVEL_3                
    ##  [23] BCLCS_LEVEL_4                 BCLCS_LEVEL_5                
    ##  [25] INTERPRETATION_DATE           PROJECT                      
    ##  [27] REFERENCE_YEAR                SPECIAL_CRUISE_NUMBER        
    ##  [29] SPECIAL_CRUISE_NUMBER_CD      INVENTORY_REGION             
    ##  [31] COMPARTMENT                   COMPARTMENT_LETTER           
    ##  [33] FIZ_CD                        FOR_MGMT_LAND_BASE_IND       
    ##  [35] ATTRIBUTION_BASE_DATE         PROJECTED_DATE               
    ##  [37] SHRUB_HEIGHT                  SHRUB_CROWN_CLOSURE          
    ##  [39] SHRUB_COVER_PATTERN           HERB_COVER_TYPE              
    ##  [41] HERB_COVER_PATTERN            HERB_COVER_PCT               
    ##  [43] BRYOID_COVER_PCT              NON_VEG_COVER_PATTERN_1      
    ##  [45] NON_VEG_COVER_PCT_1           NON_VEG_COVER_TYPE_1         
    ##  [47] NON_VEG_COVER_PATTERN_2       NON_VEG_COVER_PCT_2          
    ##  [49] NON_VEG_COVER_TYPE_2          NON_VEG_COVER_PATTERN_3      
    ##  [51] NON_VEG_COVER_PCT_3           NON_VEG_COVER_TYPE_3         
    ##  [53] LAND_COVER_CLASS_CD_1         EST_COVERAGE_PCT_1           
    ##  [55] SOIL_MOISTURE_REGIME_1        LAND_COVER_CLASS_CD_2        
    ##  [57] EST_COVERAGE_PCT_2            SOIL_MOISTURE_REGIME_2       
    ##  [59] LAND_COVER_CLASS_CD_3         EST_COVERAGE_PCT_3           
    ##  [61] SOIL_MOISTURE_REGIME_3        AVAIL_LABEL_HEIGHT           
    ##  [63] AVAIL_LABEL_WIDTH             FULL_LABEL                   
    ##  [65] LABEL_CENTRE_X                LABEL_CENTRE_Y               
    ##  [67] LABEL_HEIGHT                  LABEL_WIDTH                  
    ##  [69] LINE_1_OPENING_NUMBER         LINE_1_OPENING_SYMBOL_CD     
    ##  [71] LINE_2_POLYGON_ID             LINE_3_TREE_SPECIES          
    ##  [73] LINE_4_CLASSES_INDEXES        LINE_5_VEGETATION_COVER      
    ##  [75] LINE_6_SITE_PREP_HISTORY      LINE_7_ACTIVITY_HIST_SYMBOL  
    ##  [77] LINE_7A_STAND_TENDING_HISTORY LINE_7B_DISTURBANCE_HISTORY  
    ##  [79] LINE_8_PLANTING_HISTORY       PRINTABLE_IND                
    ##  [81] SMALL_LABEL                   OPENING_ID                   
    ##  [83] ORG_UNIT_NO                   ORG_UNIT_CODE                
    ##  [85] ADJUSTED_IND                  BEC_ZONE_CODE                
    ##  [87] BEC_SUBZONE                   BEC_VARIANT                  
    ##  [89] BEC_PHASE                     CFS_ECOZONE                  
    ##  [91] EARLIEST_NONLOGGING_DIST_TYPE EARLIEST_NONLOGGING_DIST_DATE
    ##  [93] STAND_PERCENTAGE_DEAD         FREE_TO_GROW_IND             
    ##  [95] HARVEST_DATE                  LAYER_ID                     
    ##  [97] FOR_COVER_RANK_CD             NON_FOREST_DESCRIPTOR        
    ##  [99] INTERPRETED_DATA_SRC_CD       QUAD_DIAM_125                
    ## [101] QUAD_DIAM_175                 QUAD_DIAM_225                
    ## [103] EST_SITE_INDEX_SPECIES_CD     EST_SITE_INDEX               
    ## [105] EST_SITE_INDEX_SOURCE_CD      CROWN_CLOSURE                
    ## [107] CROWN_CLOSURE_CLASS_CD        REFERENCE_DATE               
    ## [109] SITE_INDEX                    DBH_LIMIT                    
    ## [111] BASAL_AREA                    DATA_SOURCE_BASAL_AREA_CD    
    ## [113] VRI_LIVE_STEMS_PER_HA         DATA_SRC_VRI_LIVE_STEM_HA_CD 
    ## [115] VRI_DEAD_STEMS_PER_HA         TREE_COVER_PATTERN           
    ## [117] VERTICAL_COMPLEXITY           SPECIES_CD_1                 
    ## [119] SPECIES_PCT_1                 SPECIES_CD_2                 
    ## [121] SPECIES_PCT_2                 SPECIES_CD_3                 
    ## [123] SPECIES_PCT_3                 SPECIES_CD_4                 
    ## [125] SPECIES_PCT_4                 SPECIES_CD_5                 
    ## [127] SPECIES_PCT_5                 SPECIES_CD_6                 
    ## [129] SPECIES_PCT_6                 PROJ_AGE_1                   
    ## [131] PROJ_AGE_CLASS_CD_1           PROJ_AGE_2                   
    ## [133] PROJ_AGE_CLASS_CD_2           DATA_SOURCE_AGE_CD           
    ## [135] PROJ_HEIGHT_1                 PROJ_HEIGHT_CLASS_CD_1       
    ## [137] PROJ_HEIGHT_2                 PROJ_HEIGHT_CLASS_CD_2       
    ## [139] DATA_SOURCE_HEIGHT_CD         LIVE_VOL_PER_HA_SPP1_125     
    ## [141] LIVE_VOL_PER_HA_SPP1_175      LIVE_VOL_PER_HA_SPP1_225     
    ## [143] LIVE_VOL_PER_HA_SPP2_125      LIVE_VOL_PER_HA_SPP2_175     
    ## [145] LIVE_VOL_PER_HA_SPP2_225      LIVE_VOL_PER_HA_SPP3_125     
    ## [147] LIVE_VOL_PER_HA_SPP3_175      LIVE_VOL_PER_HA_SPP3_225     
    ## [149] LIVE_VOL_PER_HA_SPP4_125      LIVE_VOL_PER_HA_SPP4_175     
    ## [151] LIVE_VOL_PER_HA_SPP4_225      LIVE_VOL_PER_HA_SPP5_125     
    ## [153] LIVE_VOL_PER_HA_SPP5_175      LIVE_VOL_PER_HA_SPP5_225     
    ## [155] LIVE_VOL_PER_HA_SPP6_125      LIVE_VOL_PER_HA_SPP6_175     
    ## [157] LIVE_VOL_PER_HA_SPP6_225      DEAD_VOL_PER_HA_SPP1_125     
    ## [159] DEAD_VOL_PER_HA_SPP1_175      DEAD_VOL_PER_HA_SPP1_225     
    ## [161] DEAD_VOL_PER_HA_SPP2_125      DEAD_VOL_PER_HA_SPP2_175     
    ## [163] DEAD_VOL_PER_HA_SPP2_225      DEAD_VOL_PER_HA_SPP3_125     
    ## [165] DEAD_VOL_PER_HA_SPP3_175      DEAD_VOL_PER_HA_SPP3_225     
    ## [167] DEAD_VOL_PER_HA_SPP4_125      DEAD_VOL_PER_HA_SPP4_175     
    ## [169] DEAD_VOL_PER_HA_SPP4_225      DEAD_VOL_PER_HA_SPP5_125     
    ## [171] DEAD_VOL_PER_HA_SPP5_175      DEAD_VOL_PER_HA_SPP5_225     
    ## [173] DEAD_VOL_PER_HA_SPP6_125      DEAD_VOL_PER_HA_SPP6_175     
    ## [175] DEAD_VOL_PER_HA_SPP6_225      LIVE_STAND_VOLUME_125        
    ## [177] LIVE_STAND_VOLUME_175         LIVE_STAND_VOLUME_225        
    ## [179] DEAD_STAND_VOLUME_125         DEAD_STAND_VOLUME_175        
    ## [181] DEAD_STAND_VOLUME_225         WHOLE_STEM_BIOMASS_PER_HA    
    ## [183] BRANCH_BIOMASS_PER_HA         FOLIAGE_BIOMASS_PER_HA       
    ## [185] BARK_BIOMASS_PER_HA           FEATURE_AREA_SQM             
    ## [187] FEATURE_LENGTH_M              GEOMETRY_AREA                
    ## [189] GEOMETRY_LEN                  Shape_Length                 
    ## [191] Shape_Area                    SE_ANNO_CAD_DATA             
    ## [193] Shape                        
    ## <0 rows> (or 0-length row.names)
