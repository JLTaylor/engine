      subroutine h_fill_dc_dec_hist(Abort,err)
*
*     routine to fill histograms with hms_decoded_dc varibles
*     In the future ID numbers are stored in hms_histid
*
*     Author:	D. F. Geesaman
*     Date:     30 March 1994
*     Modified:  9 April 1994     D. F. Geesaman
*                                 Put id's in hms_tracking_histid
*                                 implement flag to turn block off
* $Log$
* Revision 1.2  1994/08/18 04:26:03  cdaq
* (SAW) Indentation changes
*
* Revision 1.1  1994/04/13  15:38:24  cdaq
* Initial revision
*
*-
*--------------------------------------------------------
      IMPLICIT NONE
*
      character*50 here
      parameter (here= 'h_fill_dc_dec_hist_')
*
      logical ABORT
      character*(*) err
      real*4  histval
      integer*4 planeoff,ihit
*
      include 'gen_data_structures.cmn'
      include 'hms_tracking.cmn'
      include 'hms_track_histid.cmn'          
*
      SAVE
*--------------------------------------------------------
*
      ABORT= .FALSE.
      err= ' '
*
* Is histogramming flag set
      if(hturnon_decoded_dc_hist.ne.0 ) then
* Make sure there is at least 1 hit
        if(HDC_TOT_HITS .gt. 0 ) then
* Loop over all hits
          do ihit=1,HDC_TOT_HITS 
            planeoff=HDC_PLANE_NUM(ihit)
            histval=HDC_WIRE_NUM(ihit)
* Is plane number valid
            if( (planeoff .gt. 0) .and. (planeoff.le. hdc_num_planes)) then
              call hf1(hiddcwiremap(planeoff),histval,1.)
              call hf1(hiddcwirecent(planeoff),HDC_WIRE_CENTER(ihit),1.)
              call hf1(hiddcdriftdis(planeoff),HDC_DRIFT_DIS(ihit),1.)
              call hf1(hiddcdrifttime(planeoff),HDC_DRIFT_TIME(ihit),1.)
            endif                       ! end test on valid plane number
          enddo                         ! end loop over hits
        endif                           ! end test on zero hits       
      endif                             ! end test on histogram block turned on.
      RETURN
      END

