      subroutine s_fill_dc_dec_hist(Abort,err)
*
*     routine to fill histograms with sos_decoded_dc varibles
*
*     Author:	D. F. Geesaman
*     Date:     30 March 1994
*     Modified:  9 April 1994     D. F. Geesaman
*                                 Put id's in sos_tracking_histid
*                                 implement flag to turn block off
* $Log$
* Revision 1.2  1994/08/18 04:33:13  cdaq
* (SAW) Indentation changes
*
* Revision 1.1  1994/04/13  18:10:22  cdaq
* Initial revision
*
*--------------------------------------------------------
      IMPLICIT NONE
*
      character*50 here
      parameter (here= 's_fill_dc_dec_hist_')
*
      logical ABORT
      character*(*) err
      real*4  histval
      integer*4 planeoff,ihit
*
      include 'gen_data_structures.cmn'
      include 'sos_tracking.cmn'
      include 'sos_track_histid.cmn'          
*
      SAVE
*--------------------------------------------------------
*
      ABORT= .FALSE.
      err= ' '
*
* Is histogramming flag set
      if(sturnon_decoded_dc_hist.ne.0 ) then
* Make sure there is at least 1 hit
        if(SDC_TOT_HITS .gt. 0 ) then
* Loop over all hits
          do ihit=1,SDC_TOT_HITS 
            planeoff=SDC_PLANE_NUM(ihit)
            histval=SDC_WIRE_NUM(ihit)
* Is plane number valid
            if( (planeoff .gt. 0) .and. (planeoff.le. sdc_num_planes)) then
              call hf1(siddcwiremap(planeoff),histval,1.)
              call hf1(siddcwirecent(planeoff),SDC_WIRE_CENTER(ihit),1.)
              call hf1(siddcdriftdis(planeoff),SDC_DRIFT_DIS(ihit),1.)
              call hf1(siddcdrifttime(planeoff),SDC_DRIFT_TIME(ihit),1.)
            endif                       ! end test on valid plane number
          enddo                         ! end loop over hits
        endif                           ! end test on zero hits       
      endif                             ! end test on histogram block turned on.
      RETURN
      END

