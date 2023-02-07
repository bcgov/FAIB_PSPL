# v3.0
# set up for missing species check


# Translated from C code used for SIndex

# Aspen At
convert_at_si <- function(inp){
  si <- case_when(
    inp$sw_si > 0 ~ -4.768112309  + 1.253446979 * inp$sw_si,
    inp$sx_si > 0 ~ -4.768112309  + 1.253446979 * inp$sx_si ,
    inp$se_si > 0 ~ -4.768112309  + 1.253446979 * inp$se_si ,
    inp$bl_si > 0 ~ -7.216706405  + 1.457496490 * inp$bl_si ,
    inp$pl_si > 0 ~ -7.452123778  + 1.362442366 * inp$pl_si ,
    inp$fd_si > 0 ~ -12.846637615 + 1.700742166 * inp$fd_si, 
    TRUE ~ inp$at_si )
  
  return(si)
  
}

# Balsam Ba
convert_ba_si <- function(inp){
  si <- case_when(
    inp$hw_si > 0 & inp$bec_zone %in% c('CDF','CWH','MH') ~ -1.977317550 + 0.986193290 * inp$hw_si ,
    inp$ss_si > 0 ~ 1.928007878 + 0.789940825 * inp$ss_si ,
    inp$sx_si > 0 & inp$bec_zone %in% c('CDF','CWH','MH')  ~ 1.928007878 + 0.789940825 * inp$sx_si ,
    inp$cw_si > 0 ~ -0.738658778 + 1.033530568 * inp$cw_si ,
    inp$fd_si > 0 & inp$bec_zone %in% c('CDF','CWH','MH') ~ -2.403353051 + 0.886587768 * inp$fd_si , 
    TRUE ~ inp$ba_si )
  
  return(si)
  
}

# Balsam Bl
convert_bl_si <- function(inp){
  si <- case_when(
    inp$sw_si > 0 ~ 1.680000000 + 0.860000000 * inp$sw_si ,
    inp$sx_si > 0 ~ 1.680000000 + 0.860000000 * inp$sx_si ,
    inp$pl_si > 0 ~ 0.474311930 + 0.917431190 * inp$pl_si ,
    inp$at_si > 0 ~ 4.951440000 + 0.686108000 * inp$at_si ,
    inp$fd_si > 0 ~ -0.221100912 + 0.981651373 * inp$fd_si ,
    inp$lw_si > 0 ~ -1.360550450 + 0.954128438 * inp$lw_si ,
    inp$sb_si > 0 ~ -3.497247692 + 1.436697244 * inp$sb_si ,
    TRUE ~ inp$bl_si )

  return(si)
  
}   

# Cedar Cw
convert_cw_si <- function(inp){
  si <- case_when(
    inp$hw_si > 0 & inp$bec_zone %in% c('CDF','CWH','MH') ~  -1.198473280 + 0.954198470 * inp$hw_si ,
    inp$ba_si > 0 ~  0.714694652 + 0.967557249 * inp$ba_si ,
    inp$ss_si > 0 ~ 2.580152661 + 0.764312974 * inp$ss_si ,
    inp$sx_si > 0 & inp$bec_zone %in% c('CDF','CWH','MH')  ~  2.580152661 + 0.764312974 * inp$sx_si ,
    inp$fd_si > 0 & inp$bec_zone %in% c('CDF','CWH','MH')~  -1.610687019 + 0.857824425 * inp$fd_si  , 
    inp$sw_si > 0 ~ inp$sw_si, 
    TRUE ~ inp$cw_si )
  
  return(si)
  
} 



# Coastal Fir Fdc
convert_fdc_si <- function(inp){
  si <- case_when(
    inp$hw_si > 0 ~ 0.480533930 + 1.112347050 * inp$hw_si ,
    inp$cw_si > 0 ~ 1.877641825 + 1.165739708 * inp$cw_si ,
    inp$ba_si > 0 ~ 2.710789765 + 1.127919909 * inp$ba_si ,
    inp$ss_si > 0 ~ 4.885428248 + 0.890989987 * inp$ss_si ,
    inp$sx_si > 0 ~ 4.885428248 + 0.890989987 * inp$sx_si , 
    TRUE ~ inp$fd_si)
  
  return(si)
  
} 

# Interior Fir Fdi
convert_fdi_si <- function(inp){
  
  si <- case_when(
    inp$pl_si > 0 ~ 0.708411210 + 0.934579440 * inp$pl_si ,
    inp$bl_si > 0 ~ 0.225233640 + 1.018691590 * inp$bl_si ,
    inp$hw_si > 0 ~ 4.560000000 + 0.887000000 * inp$hw_si ,
    inp$sw_si > 0 ~ 4.750000000 + 0.737000000 * inp$sw_si ,
    inp$sx_si > 0 ~ 4.750000000 + 0.737000000 * inp$sx_si ,
    inp$at_si > 0 ~ 7.553548000 + 0.587978600 * inp$at_si ,
    inp$lw_si > 0 ~ -0.690000000 + 0.983000000 * inp$lw_si ,
    inp$sb_si > 0 ~ -3.337383186 + 1.463551403 * inp$sb_si ,
    TRUE ~ inp$fd_si )
  
  return(si)
  
} 

# Coastal Hemlock Hwc
convert_hwc_si <- function(inp){
  si <- case_when(
    inp$cw_si > 0 ~ 1.256000000 + 1.048000000 * inp$cw_si ,
    inp$ba_si > 0 ~ 2.005000000 + 1.014000000 * inp$ba_si ,
    inp$ss_si > 0 ~ 3.960000000 + 0.801000000 * inp$ss_si ,
    inp$sx_si > 0 ~ 3.960000000 + 0.801000000 * inp$sx_si ,
    inp$fd_si > 0 ~ -0.432000000 + 0.899000000 * inp$fd_si , 
    TRUE ~ inp$hw_si )
  
  return(si)
  
} 

# Interior Hemlock Hwi
convert_hwi_si <- function(inp){
  si <- case_when(
    inp$fd_si > 0 ~ -5.140924460 + 1.127395720 * inp$fd_si ,
    inp$sw_si > 0 ~ 0.214205210 + 0.830890646 * inp$sw_si ,
    inp$sx_si > 0 ~ 0.214205210 + 0.830890646 * inp$sx_si ,
    inp$pl_si > 0 ~ -4.342264694 + 1.053640861 * inp$pl_si ,
    inp$lw_si > 0 ~ -5.918827507 + 1.108229993 * inp$lw_si , 
    TRUE ~ inp$hw_si)
  
  return(si)
  
}

# Larch Lw
convert_lw_si <- function(inp){
  si <- case_when(
    inp$fd_si > 0 & !inp$bec_zone %in% c('CDF','CWH','MH') ~ 0.701932860 + 1.017294000 * inp$fd_si ,
    inp$bl_si > 0  ~ 1.425961536 + 1.048076921 * inp$bl_si ,
    inp$pl_si > 0 ~  1.923076920 + 0.961538460 * inp$pl_si ,
    inp$sw_si > 0 ~ 3.817307686 + 0.884615383 * inp$sw_si ,
    inp$sx_si > 0 ~ 3.817307686 + 0.884615383 * inp$sx_si ,
    inp$hw_si > 0 & !inp$bec_zone %in% c('CDF','CWH','MH') ~  5.340793500 + 0.902339778 * inp$hw_si ,
    inp$sb_si > 0 ~ -2.239423073 + 1.505769228 * inp$sb_si ,
    TRUE ~ inp$lw_si )

  return(si)
  
}

# Pine Pli
convert_pl_si <- function(inp){
  si <- case_when(
    inp$sw_si > 0 ~  1.970000000 + 0.920000000 * inp$sw_si ,
    inp$sx_si > 0 ~ 1.970000000 + 0.920000000 * inp$sx_si ,
    inp$hw_si > 0 & !inp$bec_zone %in% c('CDF','CWH','MH') ~  4.121200000 + 0.949090000 * inp$hw_si ,
    inp$at_si > 0 ~ 5.469680000 + 0.733976000 * inp$at_si ,
    inp$bl_si > 0 ~ -0.517000000 + 1.090000000 * inp$bl_si ,
    inp$fd_si > 0 & !inp$bec_zone %in% c('CDF','CWH','MH') ~ -0.758000000 + 1.070000000 * inp$fd_si ,
    inp$lw_si > 0 ~ -2.000000000 + 1.040000000 * inp$lw_si ,
    inp$sb_si > 0 ~ -4.329000000 + 1.566000000 * inp$sb_si ,
    inp$ss_si > 0 & !inp$bec_zone %in% c('CDF','CWH','MH') ~ inp$sb_si ,  # assumed to be shore pine
    TRUE ~inp$pl_si )
  
  return(si)
  
}

convert_sb_si <- function(inp){
  si <- case_when(
    inp$pl_si > 0 ~ 2.764367820 + 0.638569600 * inp$pl_si ,
    inp$lw_si > 0 ~ 1.487228620 + 0.664112384 * inp$lw_si ,
    inp$fd_si > 0 & !inp$bec_zone %in% c('CDF','CWH','MH') ~ 2.280332063 + 0.683269472 * inp$fd_si ,
    inp$bl_si > 0 ~ 2.434227337 + 0.696040864 * inp$bl_si ,
    inp$sw_si > 0 ~ 4.022349932 + 0.587484032 * inp$sw_si ,
    inp$sx_si > 0 ~ 4.022349932 + 0.587484032 * inp$sx_si , 
    TRUE ~ inp$sb_si )
  
  return(si)
  
}

# Sitka Spruce Ss
convert_ss_si <- function(inp){
  si <- case_when(
    inp$hw_si > 0 & inp$bec_zone %in% c('CDF','CWH','MH') ~ -4.943820220 + 1.248439450 * inp$hw_si ,
    inp$ba_si > 0 ~ -2.440699123 + 1.265917602 * inp$ba_si ,
    inp$cw_si > 0 ~ -3.375780271 + 1.308364544 * inp$cw_si ,
    inp$fd_si > 0 & inp$bec_zone %in% c('CDF','CWH','MH') ~ -5.483146062 + 1.122347066 * inp$fd_si , 
    TRUE ~ inp$ss_si )
  
  return(si)
  
}

# White Spruce Sw
convert_sw_si <- function(inp){
  si <- case_when(
    inp$pl_si > 0 ~ -2.141304350 + 1.086956520 * inp$pl_si ,
    inp$at_si > 0 ~ 3.804000000 + 0.797800000 * inp$at_si ,
    inp$hw_si > 0 & !inp$bec_zone %in% c('CDF','CWH','MH') ~ -0.257801914 + 1.203527813 * inp$hw_si ,
    inp$bl_si > 0 ~ -1.953488370 + 1.162790700 * inp$bl_si , 
    inp$lw_si > 0 ~ -4.315217390 + 1.130434781 * inp$lw_si ,
    inp$fd_si > 0 & !inp$bec_zone %in% c('CDF','CWH','MH') ~ -6.445047490 + 1.356852100 * inp$fd_si ,
    inp$sb_si > 0 ~ -6.846739125 + 1.702173910 * inp$sb_si , 
    TRUE ~ inp$sw_si )
  
  return(si)
  
}

# Hybrid Coastal Spruce Sx
convert_sxc_si <- function(inp){
  si <- case_when(
    inp$hw_si > 0 ~ -4.943820220 + 1.248439450 * inp$hw_si ,
    inp$ba_si > 0 ~ -2.440699123 + 1.265917602 * inp$ba_si , 
    inp$cw_si > 0 ~ -3.375780271 + 1.308364544 * inp$cw_si ,
    inp$fd_si > 0 ~ -5.483146062 + 1.122347066 * inp$fd_si , 
    TRUE ~ inp$sx_si )
  
  return(si)
  
}

# Hybrid  Spruce Sx
convert_sx_si <- function(inp){
  si <- case_when(
    inp$pl_si > 0 ~ -2.141304350 + 1.086956520 * inp$pl_si , 
    inp$at_si > 0 ~ 3.804000000 + 0.797800000 * inp$at_si ,
    inp$hw_si > 0 & !inp$bec_zone %in% c('CDF','CWH','MH') ~ -0.257801914 + 1.203527813 * inp$hw_si ,
    inp$bl_si > 0 ~ -1.953488370 + 1.162790700 * inp$bl_si ,
    inp$lw_si > 0 ~ -4.315217390 + 1.130434781 * inp$lw_si ,
    inp$fd_si > 0 & !inp$bec_zone %in% c('CDF','CWH','MH') ~ -6.445047490 + 1.356852100 * inp$fd_si ,
    inp$sb_si > 0 ~ -6.846739125 + 1.702173910 * inp$sb_si , 
    TRUE ~ inp$sx_si )
  
  return(si)
  
}

###########################################################################
# one to one conversions
# vetted by Gord Nigh


# Spruce : Se & Sw

convert_sw_from_se <- function(inp) {
  # use Se
  # sw/se/sx all interchangeable
  #if (inp$sw_si == 0)
  
  si <- case_when(
    inp$se_si > 0 ~ inp$se_si ,
    TRUE ~ inp$sw_si)
  
  return(si)
  
}

convert_sw_from_sx <- function(inp) {
  # use sx
  
  si <- case_when(
    inp$sx_si > 0 ~ inp$sx_si , 
    TRUE ~ inp$sw_si)
  
  return(si)
  
}

convert_ss_from_sx <- function(inp) {
  # use sx
  
  si <- case_when(
    inp$sx_si > 0 & inp$bec_zone %in% c('CDF','CWH','MH') ~ inp$sx_si ,  # only convert for Coastal
    TRUE ~ inp$ss_si)
  
  return(si)
  
}

convert_se_from_sw <- function(inp) {
  si <- case_when(
    inp$sw_si > 0 ~ inp$sw_si , 
    TRUE ~ inp$se_si)
  
  return(si)
}

convert_sx <- function(inp){
  
  si <- case_when(
    inp$sw_si > 0 ~ inp$sw_si, 
    TRUE ~ inp$sx_si)
  
  return(si)
}



##########################################

## ba/bl/bg all interchangeable

convert_ba <- function(inp){
    si <- case_when(
    inp$bg_si > 0 ~ inp$bg_si ,   # use BG first as Ba = Bg
    inp$bl_si > 0 ~ inp$bl_si ,   # use BL , but it will be much lower
    TRUE ~ inp$ba_si)
  
  return(si)
}

convert_bl <- function(inp) {
  si <- case_when(
    inp$ba_si > 0 ~ inp$ba_si,
    inp$bg_si > 0 ~ inp$bg_si, 
    TRUE ~ inp$bl_si)
  
  return(si)
}

convert_bg <- function(inp) { 
  
  si <- case_when(
    inp$ba_si > 0 ~ inp$ba_si , 
    TRUE ~ inp$bg_si)
  
  return(si) 
}


#####################################
# Pw Ss

convert_pw <- function(inp){
  si <- case_when(
    inp$ss_si > 0 ~ inp$ss_si , # coastal
    inp$sw_si >0 ~ inp$sw_si,
    TRUE ~ inp$pw_si)
  
  return(si)
}

convert_ss <- function(inp){
  
  si <- case_when(
    inp$pw_si > 0 ~ inp$pw_si, 
    TRUE ~ inp$ss_si)
  
  return(si)
}

##########################################

# Lt /  Lw
convert_lt_from_lw <- function(inp){
  ## lt/lw interchangeable
  
  si <- case_when(
    inp$lw_si > 0 ~ inp$lw_si , 
    TRUE ~ inp$lt_si )
  
  return(si)
}

convert_lw <- function(inp){

  
  si <- case_when(
    inp$lt_si > 0 ~ inp$lt_si, 
    TRUE ~ inp$lw_si)
  
  return(si)
} 

###############################################################
# hm/hw interchangeable

convert_hm <- function(inp){
  si <- case_when(
    inp$hw_si > 0 ~  inp$hw_si, 
    TRUE ~ inp$hm_si)
  
  return(si)
} 

convert_hw <- function(inp){
  si <- case_when(
    inp$hm_si > 0 ~ inp$hm_si, 
    TRUE ~ inp$hw_si)
  
  return(si)
}   

##########################################################
# Pa / Pl

convert_pa <- function(inp){
  # pa/pl interchangeable
  
  si <- case_when(
    inp$pl_si > 0 ~ inp$pl_si, 
    TRUE ~ inp$pa_si)
  
  return(si)
}

convert_pl <- function(inp){
    si <- case_when(
    inp$pa_si > 0 ~ inp$pa_si, 
    TRUE ~ inp$pl_si)
  
  return(si)
}  

###########################################################
# alder conversion
# dr is special
# there are certain cases where Fd is missing, therefore use Hw
convert_dr <- function(inp){
    si <- case_when(
    inp$fd_si > 0 & inp$bec_zone %in% c('CWH','CDF','MH') & inp$bec_subzone %in% c('ds','db','xm') ~ inp$fd_si * 0.55,
    inp$fd_si > 0 & inp$bec_zone %in% c('CWH','CDF','MH') ~ inp$fd_si * 0.73,
    inp$hw_si > 0 & inp$bec_zone %in% c('CWH','CDF','MH') ~ inp$hw_si * 0.73,
    TRUE ~ inp$fd_si *0.73
  )
}

####################################################################
# py is special
convert_py <- function(inp){
  si <- case_when(
    inp$fd_si > 0 ~ inp$fd_si ,  
    TRUE ~ inp$py_si)
  
  return(si)
}  

##########################################################
# Pw seems to be missing a lot

convert_pw_from_fd <- function(inp){
  # pw/fd interchangeable (checking on this)
  si <- case_when(
    inp$fd_si > 0 ~ inp$fd_si, 
    TRUE ~ inp$pw_si)
  
  return(si)
}

##########################################################
# Ss in CWH sometimes missing
# since Ss can use Pw and Pw can use Fd
# if Pw is missing, use Fd

convert_ss_from_fd <- function(inp){
  # ss/fd interchangeable (checking on this)
  si <- case_when(
    inp$fd_si > 0 ~ inp$fd_si, 
    TRUE ~ inp$ss_si)
  
  return(si)
}

########################################################################################################


