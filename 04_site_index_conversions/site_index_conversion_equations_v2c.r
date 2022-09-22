# translate if_else cascades to case_when for readability

# Version 2a
# 1:1 conversion applied at end


# Translated from C code used for SIndex

# Aspen At
convert_at_si <- function(x){
  # if (spec_si[col_at ] == 0)  
  inp <- x
  si <- case_when(
    inp$sw_si > 0 ~ -4.768112309 + 1.253446979 * inp$sw_si,
    inp$sx_si > 0 & inp$se_ss_sw == 'SW' ~ -4.768112309 + 1.253446979 * inp$sx_si ,
    inp$se_si > 0 ~ -4.768112309 + 1.253446979 * inp$se_si ,
    inp$bl_si > 0 ~  -7.216706405 + 1.457496490 * inp$bl_si ,
    inp$pl_si > 0~ -7.452123778 + 1.362442366 * inp$pl_si ,
    inp$fd_si > 0 & inp$c_i == 'I' ~ -12.846637615 + 1.700742166 * inp$fd_si, 
    TRUE ~ inp$at_si )
  
  return(si)
  
}

# Balsam Ba
convert_ba_si <- function(x){
  #if (spec_si[col_ba ] == 0)  
  inp <- x
  si <- case_when(
    inp$hw_si > 0 & inp$c_i == 'C' ~ -1.977317550 + 0.986193290 * inp$hw_si ,
    inp$ss_si > 0 ~ 1.928007878 + 0.789940825 * inp$ss_si ,
    inp$sx_si > 0 & inp$se_ss_sw == 'SS' ~ 1.928007878 + 0.789940825 * inp$sx_si ,
    inp$cw_si > 0 ~ -0.738658778 + 1.033530568 * inp$cw_si ,
    inp$fd_si > 0 & inp$c_i == 'C' ~ -2.403353051 + 0.886587768 * inp$fd_si , 
    TRUE ~ inp$ba_si )
  
  return(si)
  
}

# Balsam Bl
convert_bl_si <- function(x){
  #if (spec_si[col_bl ] == 0)  
  inp <- x
  si <- case_when(
    inp$sw_si > 0 ~ 1.680000000 + 0.860000000 * inp$sw_si ,
    inp$sx_si > 0 & inp$se_ss_sw == 'SW' ~  1.680000000 + 0.860000000 * inp$sx_si ,
    inp$pl_si > 0 ~  0.474311930 + 0.917431190 * inp$pl_si ,
    inp$at_si > 0 ~ 4.951440000 + 0.686108000 * inp$at_si ,
    inp$fd_si > 0 & inp$c_i == 'I' ~ -0.221100912 + 0.981651373 * inp$fd_si ,
    inp$lw_si > 0 ~ -1.360550450 + 0.954128438 * inp$lw_si ,
    inp$sb_si > 0 ~  -3.497247692 + 1.436697244 * inp$sb_si ,
    TRUE ~ inp$bl_si )

  return(si)
  
}   

# Cedar Cw
convert_cw_si <- function(x){
  #if (spec_si[col_cwc] == 0)  
  inp <- x
  si <- case_when(
    inp$hw_si > 0 & inp$c_i == 'C' ~  -1.198473280 + 0.954198470 * inp$hw_si ,
    inp$ba_si > 0 ~  0.714694652 + 0.967557249 * inp$ba_si ,
    inp$ss_si > 0 ~ 2.580152661 + 0.764312974 * inp$ss_si ,
    inp$sx_si > 0 & inp$se_ss_sw == 'SS' ~  2.580152661 + 0.764312974 * inp$sx_si ,
    inp$fd_si > 0 & inp$c_i == 'C'~  -1.610687019 + 0.857824425 * inp$fd_si  , 
    TRUE ~ inp$cw_si )
  
  return(si)
  
} 

# Coastal Fir Fdc
convert_fdc_si <- function(x){
  #if (spec_si[col_fdc] == 0 & c_i == CI_COAST)  
  inp <- x
  si <- case_when(
    inp$hw_si > 0 ~ 0.480533930 + 1.112347050 * inp$hw_si ,
    inp$cw_si > 0 ~ 1.877641825 + 1.165739708 * inp$cw_si ,
    inp$ba_si > 0 ~ 2.710789765 + 1.127919909 * inp$ba_si ,
    inp$ss_si > 0 ~ 4.885428248 + 0.890989987 * inp$ss_si ,
    inp$sx_si > 0 & inp$se_ss_sw == 'SS' ~ 4.885428248 + 0.890989987 * inp$sx_si , 
    TRUE ~ inp$fd_si)
  
  return(si)
  
} 

# Interior Fir Fdi
convert_fdi_si <- function(x){
  #if (spec_si[col_fdi] == 0 & c_i == CI_INTERIOR)  
  inp <- x
  si <- case_when(
    inp$pl_si > 0 ~ 0.708411210 + 0.934579440 * inp$pl_si ,
    inp$bl_si > 0 ~ 0.225233640 + 1.018691590 * inp$bl_si ,
    inp$hw_si > 0 ~ 4.560000000 + 0.887000000 * inp$hw_si ,
    inp$sw_si > 0 ~ 4.750000000 + 0.737000000 * inp$sw_si ,
    inp$sx_si > 0 & inp$se_ss_sw == 'SW' ~ 4.750000000 + 0.737000000 * inp$sx_si ,
    inp$at_si > 0 ~ 7.553548000 + 0.587978600 * inp$at_si ,
    inp$lw_si > 0 ~ -0.690000000 + 0.983000000 * inp$lw_si ,
    inp$sb_si > 0 ~ -3.337383186 + 1.463551403 * inp$sb_si ,
    TRUE ~ inp$fd_si )
  
  return(si)
  
} 

# Coastal Hemlock Hwc
convert_hwc_si <- function(x){
  #if (spec_si[col_hwc] == 0 & c_i == CI_COAST)  
  inp <- x
  si <- case_when(
    inp$cw_si > 0 ~ 1.256000000 + 1.048000000 * inp$cw_si ,
    inp$ba_si > 0 ~  2.005000000 + 1.014000000 * inp$ba_si ,
    inp$ss_si > 0 ~ 3.960000000 + 0.801000000 * inp$ss_si ,
    inp$sx_si > 0 & inp$se_ss_sw == 'SS' ~ 3.960000000 + 0.801000000 * inp$sx_si ,
    inp$fd_si > 0 ~ -0.432000000 + 0.899000000 * inp$fd_si , 
    TRUE ~ inp$hw_si )
  
  return(si)
  
} 

# Interior Hemlock Hwi
convert_hwi_si <- function(x){
  #if (spec_si[col_hwi] == 0 & c_i == CI_INTERIOR)  
  inp <- x
  si <- case_when(
    inp$fd_si > 0 ~ -5.140924460 + 1.127395720 * inp$fd_si ,
    inp$sw_si > 0 ~ 0.214205210 + 0.830890646 * inp$sw_si ,
    inp$sx_si > 0 & inp$se_ss_sw == 'SW' ~ 0.214205210 + 0.830890646 * inp$sx_si ,
    inp$pl_si > 0 ~ -4.342264694 + 1.053640861 * inp$pl_si ,
    inp$lw_si > 0 ~ -5.918827507 + 1.108229993 * inp$lw_si , 
    TRUE ~ inp$hw_si)
  
  return(si)
  
}

# Larch Lw
convert_lw_si <- function(x){
  #if (spec_si[col_lw ] == 0)  
  inp <- x
  si <- case_when(
    inp$fd_si > 0 & inp$c_i == 'I'~ 0.701932860 + 1.017294000 * inp$fd_si ,
    inp$bl_si > 0  ~ 1.425961536 + 1.048076921 * inp$bl_si ,
    inp$pl_si > 0 ~  1.923076920 + 0.961538460 * inp$pl_si ,
    inp$sw_si > 0 ~ 3.817307686 + 0.884615383 * inp$sw_si ,
    inp$sx_si > 0 & inp$se_ss_sw == 'SW'  ~ 3.817307686 + 0.884615383 * inp$sx_si ,
    inp$hw_si > 0 & inp$c_i == 'I' ~  5.340793500 + 0.902339778 * inp$hw_si ,
    inp$sb_si > 0 ~ -2.239423073 + 1.505769228 * inp$sb_si ,
    TRUE ~ inp$lw_si )

  return(si)
  
}

# Pine Pli
convert_pl_si <- function(x){
  #if (spec_si[col_pli] == 0)  
  inp <- x
  si <- case_when(
    inp$sw_si > 0 ~  1.970000000 + 0.920000000 * inp$sw_si ,
    inp$sx_si > 0 & inp$se_ss_sw == 'SW' ~ 1.970000000 + 0.920000000 * inp$sx_si ,
    inp$hw_si > 0 & inp$c_i == 'I' ~  4.121200000 + 0.949090000 * inp$hw_si ,
    inp$at_si > 0 ~ 5.469680000 + 0.733976000 * inp$at_si ,
    inp$bl_si > 0 ~ -0.517000000 + 1.090000000 * inp$bl_si ,
    inp$fd_si > 0 & inp$c_i == 'I' ~ -0.758000000 + 1.070000000 * inp$fd_si ,
    inp$lw_si > 0 ~ -2.000000000 + 1.040000000 * inp$lw_si ,
    inp$sb_si > 0 ~ -4.329000000 + 1.566000000 * inp$sb_si ,
    TRUE ~inp$pl_si )
  
  return(si)
  
}

# Black Spruce Sb
convert_sb_si <- function(x){
  #if (spec_si[col_sb ] == 0)  
  inp <- x
  si <- case_when(
    inp$pl_si > 0 ~ 2.764367820 + 0.638569600 * inp$pl_si ,
    inp$lw_si > 0 ~ 1.487228620 + 0.664112384 * inp$lw_si ,
    inp$fd_si > 0 & inp$c_i == 'I' ~ 2.280332063 + 0.683269472 * inp$fd_si ,
    inp$bl_si > 0 ~ 2.434227337 + 0.696040864 * inp$bl_si ,
    inp$sw_si > 0 ~ 4.022349932 + 0.587484032 * inp$sw_si ,
    inp$sx_si > 0 & inp$se_ss_sw == 'SW' ~ 4.022349932 + 0.587484032 * inp$sx_si , 
    TRUE ~ inp$sb_si )
  
  return(si)
  
}

# Sitka Spruce Ss
convert_ss_si <- function(x){
  #if (spec_si[col_ss ] == 0)  
  inp <- x
  si <- case_when(
    inp$hw_si > 0 & inp$c_i == 'C' ~ -4.943820220 + 1.248439450 * inp$hw_si ,
    inp$ba_si > 0 ~ -2.440699123 + 1.265917602 * inp$ba_si ,
    inp$cw_si > 0 ~ -3.375780271 + 1.308364544 * inp$cw_si ,
    inp$fd_si > 0 & inp$c_i == 'C' ~ -5.483146062 + 1.122347066 * inp$fd_si , 
    TRUE ~ inp$ss_si )
  
  return(si)
  
}

# White Spruce Sw
convert_sw_si <- function(x){
  #if (spec_si[col_sw ] == 0)  
  inp <- x
  si <- case_when(
    inp$pl_si > 0 ~ -2.141304350 + 1.086956520 * inp$pl_si ,
    inp$at_si > 0 ~ 3.804000000 + 0.797800000 * inp$at_si ,
    inp$hw_si > 0 & inp$c_i == 'I' ~ -0.257801914 + 1.203527813 * inp$hw_si ,
    inp$bl_si > 0 ~ -1.953488370 + 1.162790700 * inp$bl_si , 
    inp$lw_si > 0 ~ -4.315217390 + 1.130434781 * inp$lw_si ,
    inp$fd_si > 0 & inp$c_i == 'I' ~ -6.445047490 + 1.356852100 * inp$fd_si ,
    inp$sb_si > 0 ~ -6.846739125 + 1.702173910 * inp$sb_si , 
    TRUE ~ inp$sw_si )
  
  return(si)
  
}

# Hybrid Coastal Spruce Sx
convert_sxc_si <- function(x){
  #if (spec_si[col_sx ] == 0 & c_i == CI_COAST)  
  #if (inp$sx_si == 0 & c_i == 'C')
  inp <- x
  si <- case_when(
    inp$hw_si > 0 ~ -4.943820220 + 1.248439450 * inp$hw_si ,
    inp$ba_si > 0 ~ -2.440699123 + 1.265917602 * inp$ba_si , 
    inp$cw_si > 0 ~ -3.375780271 + 1.308364544 * inp$cw_si ,
    inp$fd_si > 0 ~ -5.483146062 + 1.122347066 * inp$fd_si , 
    TRUE ~ inp$sx_si )
  
  return(si)
  
}

# Hybrid  Spruce Sx
convert_sx_si <- function(x){
  #if (spec_si[col_sx ] == 0 & se_ss_sw == SPEC_SW)  
  #if (inp$sx_si == 0 & se_ss_sw == 'SW')
  inp <- x
  si <- case_when(
    inp$pl_si > 0 ~ -2.141304350 + 1.086956520 * inp$pl_si , 
    inp$at_si > 0 ~ 3.804000000 + 0.797800000 * inp$at_si ,
    inp$hw_si > 0 & inp$c_i == 'I' ~ -0.257801914 + 1.203527813 * inp$hw_si ,
    inp$bl_si > 0 ~ -1.953488370 + 1.162790700 * inp$bl_si ,
    inp$lw_si > 0 ~ -4.315217390 + 1.130434781 * inp$lw_si ,
    inp$fd_si > 0 & inp$c_i == 'I' ~ -6.445047490 + 1.356852100 * inp$fd_si ,
    inp$sb_si > 0 ~ -6.846739125 + 1.702173910 * inp$sb_si , 
    TRUE ~ inp$sx_si )
  
  return(si)
  
}

###########################################################################
# one to one conversions
# vetted by Gord Nigh


# Spruce : Se & Sw

convert_sw_from_se <- function(x) {
  # use Se
  # sw/se/sx all interchangeable
  #if (inp$sw_si == 0)
  inp <- x
  si <- case_when(
    inp$se_si != 0 ~ inp$se_si ,
    TRUE ~ inp$sw_si)
  
  return(si)
  
}

convert_sw_from_sx <- function(x) {
  # use sx
  # if (inp$sw_si == 0)
  inp <- x
  si <- case_when(
    inp$sx_si != 0 ~ inp$sx_si , 
    TRUE ~ inp$sw_si)
  
  return(si)
  
}

convert_ss_from_sx <- function(x) {
  # use sx
  # if (inp$sw_si == 0)
  inp <- x
  si <- case_when(
    inp$sx_si != 0 ~ inp$sx_si , 
    TRUE ~ inp$ss_si)
  
  return(si)
  
}

convert_se_from_sw <- function(x) {
  #if (inp$se_si == 0 & 
  inp <- x
  si <- case_when(
    inp$sw_si != 0 ~ inp$sw_si , 
    TRUE ~ inp$se_si)
  
  return(si)
}

convert_sx <- function(x){
  #  if (inp$sx_si == 0 & inp$sw_si != 0)
  inp <- x
  si <- case_when(
    inp$sw_si != 0 ~ inp$sw_si, 
    TRUE ~ inp$sx_si)
  
  return(si)
}

convert_cwi <- function(x){
  #  if (inp$cw_si == 0 & inp$sw_si != 0)
  inp <- x
  si <- case_when(
    inp$sw_si != 0 ~ inp$sw_si, 
    TRUE ~ inp$cw_si)
  
  return(si)
}

##########################################

## ba/bl/bg all interchangeable

convert_ba <- function(x){
  # if (inp$ba_si == 0)
  inp <- x
  si <- case_when(
    inp$bl_si != 0 ~ inp$bl_si , 
    inp$bg_si != 0 ~ inp$bg_si , 
    TRUE ~ inp$ba_si)
  
  return(si)
}

convert_bl <- function(x) {
  #  if (inp$bl_si == 0 & 
  inp <- x
  si <- case_when(
    inp$ba_si != 0 ~ inp$ba_si, 
    TRUE ~ inp$bl_si)
  
  return(si)
}

convert_bg <- function(x) { 
  #  if (inp$bg_si == 0 & inp$ba_si != 0)
  inp <- x
  si <- case_when(
    inp$ba_si != 0 ~ inp$ba_si , 
    TRUE ~ inp$bg_si)
  
  return(si) 
}


#####################################
# Pw Ss

convert_pw <- function(x){
  #if (inp$pw_si == 0 & inp$ss_si != 0)
  inp <- x
  si <- case_when(
    inp$ss_si != 0 ~ inp$ss_si , 
    TRUE ~ inp$pw_si)
  
  return(si)
}

convert_ss <- function(x){
  #if (inp$ss_si == 0 & inp$pw_si != 0)
  inp <- x
  si <- case_when(
    inp$pw_si != 0 ~ inp$pw_si, 
    TRUE ~ inp$ss_si)
  
  return(si)
}

##########################################

# Lt /  Lw
convert_lt <- function(x){
  ## lt/lw interchangeable
  #if (inp$lt_si == 0 & inp$lw_si != 0)  
  inp <- x
  si <- case_when(
    inp$lw_si != 0 ~ inp$lw_si , 
    TRUE ~ inp$lt_si )
  
  return(si)
}

convert_lw <- function(x){
  #if (inp$lw_si == 0 & inp$lt_si != 0)
  inp <- x
  si <- case_when(
    inp$lt_si != 0 ~ inp$lt_si, 
    TRUE ~ inp$lw_si)
  
  return(si)
} 

###############################################################
# hm/hw interchangeable

convert_hm <- function(x){
  #if (inp$hm_si == 0 & inp$hw_si != 0)
  inp <- x
  si <- case_when(
    inp$hw_si != 0 ~  inp$hw_si, 
    TRUE ~ inp$hm_si)
  
  return(si)
} 

convert_hw <- function(x){
  #if (inp$hw_si == 0 & inp$hm_si != 0)
  inp <- x
  si <- case_when(
    inp$hm_si != 0 ~ inp$hm_si, 
    TRUE ~ inp$hw_si)
  
  return(si)
}   

##########################################################
# Pa / Pl

convert_pa <- function(x){
  # pa/pl interchangeable
  #if (inp$pa_si == 0 & inp$pl_si != 0)
  inp <- x
  si <- case_when(
    inp$pl_si != 0 ~ inp$pl_si, 
    TRUE ~ inp$pa_si)
  
  return(si)
}

convert_pl <- function(x){
  #if (inp$pl_si == 0 & inp$pa_si != 0)
  inp <- x
  si <- case_when(
    inp$pa_si != 0 ~ inp$pa_si, 
    TRUE ~ inp$pl_si)
  
  return(si)
}  

###########################################################
# alder conversion
# dr is special
convert_dr <- function(x){
  #if (inp$dr_si == 0 & inp$fd_si != 0 & c_i == 'C')
  inp <- x
  #inp$dr_si = inp$fd_si 
  si <- case_when(
    inp$bec_zone %in% c('CWH','CDF','MH') & inp$bec_subzone %in% c('ds','db','xm') ~ inp$fd_si * 0.55,
    inp$bec_zone %in% c('CWH','CDF','MH') ~ inp$fd_si * 0.73,
    TRUE ~ inp$fd_si *0.73
  )
}

####################################################################
# py is special
convert_py <- function(x){
  #if (inp$py_si == 0 & inp$fd_si != 0 & stricmp (bec, "sbs") == 0 & stricmp (subzone, "dk") == 0)
  inp <- x
  si <- case_when(
    inp$fd_si != 0 ~ inp$fd_si ,  
    TRUE ~ inp$py_si)
  
  return(si)
}  

##########################################################
# Pw seems to be missing a lot

convert_pw_from_fd <- function(x){
  # pw/fd interchangeable (checking on this)
  #if (inp$pw_si == 0 & inp$fd_si != 0)
  inp <- x
  si <- case_when(
    inp$fd_si != 0 ~ inp$fd_si, 
    TRUE ~ inp$pw_si)
  
  return(si)
}

##########################################################
# Ss in CWH sometimes missing
# since Ss can use Pw and Pw can use Fd
# if Pw is missing, use Fd

convert_ss_from_fd <- function(x){
  # ss/fd interchangeable (checking on this)
  #if (inp$ss_si == 0 & inp$fd_si != 0)
  inp <- x
  si <- case_when(
    inp$fd_si != 0 ~ inp$fd_si, 
    TRUE ~ inp$ss_si)
  
  return(si)
}

########################################################################################################

# END individual functions


#########################################################################################################
## here is how the site index conversion gets called

si_convert <- function(dt){
  
# si_conversions require 0 instead of NA
  dt[is.na(dt)] <- 0
  

# add attribution to match how C handled things  
# coast interior indicator
  
  dt$c_i <- case_when(
    dt$bec_zone == 'CWH' ~ 'C',
    dt$bec_zone == 'CDF' ~ 'C',
    dt$bec_zone == 'MH' ~ 'C',
    TRUE ~ 'I'
  )
  
# Original code uses indicator for Spruce depending on BEC
  
  dt$se_ss_sw <- case_when(
    dt$c_i == 'C' ~ 'SS',
    dt$c_i == 'I' & dt$bec_zone == 'ESSF' ~ 'SE',
    TRUE ~ 'SW'
  )
  
# have to cast as numeric after reading the data in
  dt <- dt %>% mutate_if(is.numeric, round, digits=1)

# make sure that data type is set to table
  setDT(dt)

# *******************************************************************************************
# One to One conversions
# these should be applied first so that we are starting with a better filled matrix of conversions
  

  
# one to one conversions not done
#  dt$ba_si[which(dt$ba_si==0)] <- convert_ba(dt[which(dt$ba_si==0)]) # Ba / Bg / Bl interchangeable
#  dt$bl_si[which(dt$bl_si==0)] <- convert_bl(dt[which(dt$bl_si==0)]) # Ba / Bg / Bl interchangeable
#  dt$bg_si[which(dt$bg_si==0)] <- convert_bg(dt[which(dt$bg_si==0)]) # Ba / Bg / Bl interchangeable
#  dt$pw_si[which(dt$pw_si==0)] <- convert_pw(dt[which(dt$pw_si==0)]) # Pw / Fd interchangeable
#  dt$ss_si[which(dt$ss_si==0)] <- convert_ss(dt[which(dt$ss_si==0)]) # Pw / Ss interchangeable
#  dt$lt_si[which(dt$lt_si==0)] <- convert_lt(dt[which(dt$lt_si==0)]) # Lt / Lw interchangeable
#  dt$lw_si[which(dt$lw_si==0)] <- convert_lw(dt[which(dt$lw_si==0)]) # Lt / Lw interchangeable
#  dt$hm_si[which(dt$hm_si==0)] <- convert_hm(dt[which(dt$hm_si==0)]) # Hm /Hw interchangeable
#  dt$hw_si[which(dt$hw_si==0)] <- convert_hw(dt[which(dt$hw_si==0)]) # Hm /Hw interchangeable
#  dt$pa_si[which(dt$pa_si==0)] <- convert_pa(dt[which(dt$pa_si==0)]) # Pa / Pl interchangeable
#  dt$pl_si[which(dt$pl_si==0)] <- convert_pl(dt[which(dt$pl_si==0)]) # Pa / Pl interchangeable
  

# ********************************************************************
# Spruce   Se Sw Sx all interchange
# set sw = sx
  dt$sw_si[which(dt$sw_si==0)] <- convert_sw_from_sx(dt[which(dt$sw_si==0)]) 
# ***********************************************************************
  
# ********************************************************************
# Pine Pw   interchange for Fd
# set Pw = Fd
dt$pw_si[which(dt$pw_si==0)] <- convert_pw_from_fd(dt[which(dt$pw_si==0)]) 
# ***********************************************************************  
  

# set sw = se 
  dt$sw_si[which(dt$sw_si==0)] <- convert_sw_from_se(dt[which(dt$sw_si==0)]) 
  
# set se = sw
  dt$se_si[which(dt$se_si==0)] <- convert_se_from_sw(dt[which(dt$se_si==0)])
  
# set ss = sx
  dt$ss_si[which(dt$ss_si==0)] <- convert_ss_from_sx(dt[which(dt$se_si==0)]) 
  

# ***************************************************************************
# Sindex Site Index Conversions
  
# Now start regular si conversions based on Sindex conversions

# update individual species site index using which to subset the table
  
  dt$at_si[which(dt$at_si==0)] <- convert_at_si(dt[which(dt$at_si==0)])
  dt$ba_si[which(dt$ba_si==0)] <- convert_ba_si(dt[which(dt$ba_si==0)])
  dt$bl_si[which(dt$bl_si==0)] <- convert_bl_si(dt[which(dt$bl_si==0)])
  dt$cw_si[which(dt$cw_si==0)] <- convert_cw_si(dt[which(dt$cw_si==0)])
  
  
  # for fir, need Coast indicator
  #Coast
  dt$fd_si[which(dt$fd_si==0 & dt$c_i == 'C')] <- convert_fdc_si(dt[which(dt$fd_si==0 & dt$c_i == 'C')])
  # Interior
  dt$fd_si[which(dt$fd_si==0 & dt$c_i == 'I')] <- convert_fdi_si(dt[which(dt$fd_si==0 & dt$c_i == 'I')])
  
  # for hemlock need Coast Interior
  # Coast
  dt$hw_si[which(dt$hw_si==0 & dt$c_i == 'C')] <- convert_hwc_si(dt[which(dt$hw_si==0 & dt$c_i == 'C')])
  # Interior
  dt$hw_si[which(dt$hw_si==0 & dt$c_i == 'I')] <- convert_hwi_si(dt[which(dt$hw_si==0 & dt$c_i == 'I')])
  
  dt$lw_si[which(dt$lw_si==0)] <- convert_lw_si(dt[which(dt$lw_si==0)])
  dt$pl_si[which(dt$pl_si==0)] <- convert_pl_si(dt[which(dt$pl_si==0)])
  dt$sb_si[which(dt$sb_si==0)] <- convert_sb_si(dt[which(dt$sb_si==0)])
  dt$ss_si[which(dt$ss_si==0)] <- convert_ss_si(dt[which(dt$ss_si==0)])
  dt$sw_si[which(dt$sw_si==0)] <- convert_sw_si(dt[which(dt$sw_si==0)])
  
  # for Spruce Hybrid need Coast Interior
  # Coast
  #dt$sx_si[which(dt$sx_si==0 & dt$c_i == 'C')] <- convert_sxc_si(dt[which(dt$sx_si==0 & dt$c_i == 'C')])
  # Interior Sw
  #dt$sx_si[which(dt$sx_si==0 & dt$se_ss_sw == 'SW')] <- convert_sx_si(dt[which(dt$sx_si==0 & dt$se_ss_sw == 'SW')])
  
  
  
  #dr Coast/Interior
  dt$dr_si[which(dt$dr_si==0)] <- convert_dr(dt[which(dt$dr_si==0)])
  
  # Interior cwi
  dt$cw_si[which(dt$cw_si==0 & dt$c_i == 'I')] <- convert_cwi(dt[which(dt$cw_si==0 & dt$c_i == 'I')])
  
  
  # Py in SBS dk 
  # use fd_si
  #dt$py_si[which(dt$py_si==0 & dt$bec=="SBS" & dt$subzone == "dk")] <- convert_py(dt[which(dt$py_si==0 & dt$bec=="SBS" & dt$subzone == "dk")])
  dt$py_si[which(dt$py_si==0) ] <- convert_py(dt[which(dt$py_si==0)])

# **************************************************  
# Final One to One conversions
  # ********************************************************************
  # Spruce   Se Sw Sx all interchange
  # set sw = sx
  dt$sw_si[which(dt$sw_si==0)] <- convert_sw_from_sx(dt[which(dt$sw_si==0)]) 
  # ***********************************************************************
  
  # ********************************************************************
  # Pine Pw   interchange for Fd
  # set Pw = Fd
  dt$pw_si[which(dt$pw_si==0)] <- convert_pw_from_fd(dt[which(dt$pw_si==0)]) 
  # ***********************************************************************  
  
  
  # set sw = se 
  dt$sw_si[which(dt$sw_si==0)] <- convert_sw_from_se(dt[which(dt$sw_si==0)]) 
  
  # set se = sw
  dt$se_si[which(dt$se_si==0)] <- convert_se_from_sw(dt[which(dt$se_si==0)]) 
  
  # set ss = sx
  dt$ss_si[which(dt$ss_si==0)] <- convert_ss_from_sx(dt[which(dt$se_si==0)]) 
  
  
  # ***************************************************************************
  
  # if si < 0 then return 0
  
  # can not do this because opening id can be negative
  #dt[dt <0 ] <- 0.0
  
  dt$at_si[dt$at_si < 0 ] <- 0.0
  dt$ba_si[dt$ba_si < 0 ] <- 0.0
  dt$bg_si[dt$bg_si < 0 ] <- 0.0
  dt$bl_si[dt$bl_si < 0 ] <- 0.0
  dt$cw_si[dt$cw_si < 0 ] <- 0.0
  dt$dr_si[dt$dr_si < 0 ] <- 0.0
  dt$ep_si[dt$ep_si < 0 ] <- 0.0
  dt$fd_si[dt$fd_si < 0 ] <- 0.0
  dt$hm_si[dt$hm_si < 0 ] <- 0.0
  dt$hw_si[dt$hw_si < 0 ] <- 0.0
  dt$lt_si[dt$lt_si < 0 ] <- 0.0
  dt$lw_si[dt$lw_si < 0 ] <- 0.0
  dt$pa_si[dt$pa_si < 0 ] <- 0.0
  dt$pl_si[dt$pl_si < 0 ] <- 0.0
  dt$pw_si[dt$pw_si < 0 ] <- 0.0
  dt$py_si[dt$py_si < 0 ] <- 0.0
  dt$sb_si[dt$sb_si < 0 ] <- 0.0
  dt$se_si[dt$se_si < 0 ] <- 0.0
  dt$ss_si[dt$ss_si < 0 ] <- 0.0
  dt$sw_si[dt$sw_si < 0 ] <- 0.0
  dt$sx_si[dt$sx_si < 0 ] <- 0.0
  dt$yc_si[dt$yc_si < 0 ] <- 0.0
  

  
  #convert to numeric 1
  dt <- dt %>% mutate_if(is.numeric, round, digits=1)
  
  # drop the extra columns
  dt <- dt %>% select(-c_i,-se_ss_sw)
  
  setDT(dt)
  
  return(dt)
}
