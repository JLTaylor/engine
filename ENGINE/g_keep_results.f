      SUBROUTINE G_keep_results(ABORT,err)
*----------------------------------------------------------------------
*-       Prototype hall C keep_results routine
*- 
*-   Purpose and Methods : Given previously filled data structures,
*-                         keep_results stores the reconstructed info.
*- 
*-   Output: ABORT	- success or failure
*-         : err	- reason for failure, if any
*- 
*-   Created  20-Nov-1993   Kevin B. Beard, HU
*-    $Log$
*-    Revision 1.1  1994/02/04 22:10:48  cdaq
*-    Initial revision
*-
*-
*- All standards are from "Proposal for Hall C Analysis Software
*- Vade Mecum, Draft 1.0" by D.F.Geesamn and S.Wood, 7 May 1993
*-
*--------------------------------------------------------
      IMPLICIT NONE
      SAVE
*
      character*40 here
      parameter (here= 'G_keep_results')
*
      logical ABORT
      character*(*) err
*
      INCLUDE 'gen_data_structures.cmn'
*
      logical HMS_ABORT,SOS_ABORT
      character*1024 HMS_err,SOS_err
*--------------------------------------------------------
*
      err= ' '                                  !erase any old errors
*
*-HMS keep_results
      call H_keep_results(HMS_ABORT,HMS_err)
*
*-SOS keep_results
      call S_keep_results(SOS_ABORT,SOS_err)
*
      IF(.NOT.HMS_ABORT .and. .NOT.SOS_ABORT) THEN
*
*-COIN keep_results
*
         call C_keep_results(ABORT,err)
*     
      ELSEIF(HMS_ABORT) THEN
*
*-HMS only
*
         ABORT= SOS_ABORT                       !nonfatal error?
         err= SOS_err                           !warning about SOS
         call G_log_message('WARNING: '//err)
*
      ELSEIF(SOS_ABORT) THEN
*
*-SOS only
*
         ABORT= HMS_ABORT                       !nonfatal error?
         err= HMS_err                           !warning about HMS
         call G_log_message('WARNING: '//err)
*     
      ELSE
*					error from both HMS and SOS
         ABORT= .TRUE.
         call G_prepend(HMS_err//' & '//SOS_err,err)
*
      ENDIF
*
      IF(ABORT) call G_add_path(here,err)
*
      RETURN
      END
