      subroutine s_fill_dc_target_hist(Abort,err)
*
*     routine to fill histograms with SOS_TARGET varibles
*
*     Author:	D. F. Geesaman
*     Date:     3 May 1994
* $Log$
* Revision 1.2  1994/08/18 04:31:47  cdaq
* (SAW) Indentation changes
*
* Revision 1.1  1994/05/13  03:04:19  cdaq
* Initial revision
*
*-
*--------------------------------------------------------
      IMPLICIT NONE
*
      character*50 here
      parameter (here= 's_fill_dc_target_hist')
*
      logical ABORT
      character*(*) err
      real*4  histval
      integer*4 itrk

*
      include 'gen_data_structures.cmn'
      include 'sos_track_histid.cmn'
*     
      SAVE
*--------------------------------------------------------
*
      ABORT= .FALSE.
      err= ' '
*
* Make sure there is at least 1 track
      if(SNTRACKS_FP .gt. 0 ) then
* Loop over all hits
        do itrk=1,SNTRACKS_FP
          call hf1(sidsx_tar,SX_TAR(itrk),1.)
          call hf1(sidsy_tar,SY_TAR(itrk),1.)
          call hf1(sidsz_tar,SZ_TAR(itrk),1.)
          call hf1(sidsxp_tar,SXP_TAR(itrk),1.)
          call hf1(sidsyp_tar,SYP_TAR(itrk),1.)
          call hf1(sidsdelta_tar,SDELTA_TAR(itrk),1.)
          call hf1(sidsp_tar,SP_TAR(itrk),1.)
*     
* 
        enddo                           ! end loop over hits
      endif                             ! end test on zero hits       
      RETURN
      END
