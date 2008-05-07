*******************************************************************************
*     This file (r_sane_ntuple.f) was generated from sane_ntuple.cmn by makereg v1.01
*     This file was created on Mon Apr 14 11:00:57 2008
*
*     The command used to create this file was:
*     /w/work5403/sane/bhovik/sanetest/Analyzer/SANE/O.Linux/../../../Linux/bin/makereg sane_ntuple.cmn -o r_sane_ntuple.f -e /dev/null 
*
*     Do not edit this file.
*******************************************************************************

      subroutine r_sane_ntuple

      implicit none


*     Registered, but did not occur in a common block:
*     
*     Occurred in a common block, but were not registered:

      include 'sane_ntuple.cmn'

c      integer regparmint
c      external regparmint
c      integer regparmstring
c      external regparmstring
c      integer regparmstringarray
c      external regparmstringarray
c      integer regeventint
c      external regeventint
c      integer regeventintarray
c      external regeventintarray
c      integer regeventreal
c      external regeventreal
c      integer regeventrealarray
c      external regeventrealarray

      call regparmint('sane_Ntuple_exists',sane_Ntuple_exists,0)
      call regparmint('sane_Ntuple_ID',sane_Ntuple_ID,0)
      call regparmint('sane_Ntuple_size',sane_Ntuple_size,0)
      call regparmint('sane_Ntuple_IOchannel',sane_Ntuple_IOchannel,0)
      call regparmint('sane_ntuple_type',sane_ntuple_type,0)
      call regparmstring('sane_Ntuple_name',sane_Ntuple_name,0)
      call regparmstring('sane_Ntuple_title',sane_Ntuple_title,0)
      call regparmstring('sane_Ntuple_directory',sane_Ntuple_directory,0)
      call regparmstring('sane_Ntuple_file',sane_Ntuple_file,0)
      call regparmstringarray('sane_Ntuple_tag',sane_Ntuple_tag,(SANEMAX_Ntuple_size),0)
      call regparmint('sane_Ntuple_max_segmentevents',sane_Ntuple_max_segmentevents,0)
      call regeventint('sane_Ntuple_segmentevents',sane_Ntuple_segmentevents,0)
      call regeventint('sane_Ntuple_filesegments',sane_Ntuple_filesegments,0)
      call regeventint('sane_ntuple_auxsegments',sane_ntuple_auxsegments,0)
      call regeventrealarray('sane_Ntuple_contents',sane_Ntuple_contents,(SANEMAX_Ntuple_size),0)
      call regeventint('y1t_hit',y1t_hit,0)
      call regeventintarray('y1t_row',y1t_row,(TRACKER_MAX_HITS),0)
      call regeventintarray('y1t_tdc',y1t_tdc,(TRACKER_MAX_HITS),0)
      call regeventrealarray('y1t_y',y1t_y,(TRACKER_MAX_HITS),0)
      call regeventint('y2t_hit',y2t_hit,0)
      call regeventintarray('y2t_row',y2t_row,(TRACKER_MAX_HITS),0)
      call regeventintarray('y2t_tdc',y2t_tdc,(TRACKER_MAX_HITS),0)
      call regeventrealarray('y2t_y',y2t_y,(TRACKER_MAX_HITS),0)
      call regeventint('y3t_hit',y3t_hit,0)
      call regeventintarray('y3t_row',y3t_row,(TRACKER_MAX_HITS),0)
      call regeventintarray('y3t_tdc',y3t_tdc,(TRACKER_MAX_HITS),0)
      call regeventrealarray('y3t_y',y3t_y,(TRACKER_MAX_HITS),0)
      call regeventint('x1t_hit',x1t_hit,0)
      call regeventintarray('x1t_row',x1t_row,(TRACKER_MAX_HITS),0)
      call regeventintarray('x1t_tdc',x1t_tdc,(TRACKER_MAX_HITS),0)
      call regeventrealarray('x1t_x',x1t_x,(TRACKER_MAX_HITS),0)
      call regeventint('cer_hit',cer_hit,0)
      call regeventintarray('cer_num',cer_num,(50),0)
      call regeventintarray('cer_tdc',cer_tdc,(50),0)
      call regeventintarray('cer_adc',cer_adc,(50),0)
      call regeventint('luc_hit',luc_hit,0)
      call regeventintarray('luc_row',luc_row,(50),0)
      call regeventintarray('ladc_pos',ladc_pos,(50),0)
      call regeventintarray('ladc_neg',ladc_neg,(50),0)
      call regeventintarray('ltdc_pos',ltdc_pos,(50),0)
      call regeventintarray('ltdc_neg',ltdc_neg,(50),0)
      call regeventrealarray('luc_y',luc_y,(50),0)
      call regeventreal('hms_p',hms_p,0)
      call regeventreal('hms_e',hms_e,0)
      call regeventreal('hms_theta',hms_theta,0)
      call regeventreal('hms_phi',hms_phi,0)
      call regeventreal('hms_ytar',hms_ytar,0)
      call regeventreal('hms_yptar',hms_yptar,0)
      call regeventreal('hms_xptar',hms_xptar,0)
      call regeventreal('hms_delta',hms_delta,0)
      call regeventreal('hms_start',hms_start,0)

      return
      end
