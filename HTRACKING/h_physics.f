      SUBROUTINE H_PHYSICS(ABORT,err)
*--------------------------------------------------------
*-
*-   Purpose and Methods : Do final HMS physics analysis on HMS only part of
*-                            event.
*-                              
*-                                to decoded information 
*-
*-      Required Input BANKS     HMS_FOCAL_PLANE
*-                               HMS_TARGET
*-                               HMS_TRACK_TESTS
*-
*-      Output BANKS             HMS_PHYSICS_R4
*-                               HMS_PHYSICS_I4
*-
*-   Output: ABORT           - success or failure
*-         : err             - reason for failure, if any
*- 
*-   Created 19-JAN-1994   D. F. Geesaman
*-                           Dummy Shell routine
* $Log$
* Revision 1.5  1995/01/27 20:24:14  cdaq
* (JRA) Add some useful physics quantities
*
* Revision 1.4  1995/01/18  16:29:26  cdaq
* (SAW) Correct some trig and check for negative arg in elastic kin calculation
*
* Revision 1.3  1994/09/13  19:51:03  cdaq
* (JRA) Add HBETA_CHISQ
*
* Revision 1.2  1994/06/14  03:49:49  cdaq
* (DFG) Calculate physics quantities
*
* Revision 1.1  1994/02/19  06:16:08  cdaq
* Initial revision
*
*-
*-
*--------------------------------------------------------
      IMPLICIT NONE
      SAVE
*
      character*50 here
      parameter (here= 'H_PHYSICS')
*
      logical ABORT
      character*(*) err
      integer*4 ierr
*
      INCLUDE 'gen_data_structures.cmn'
      INCLUDE 'gen_routines.dec'
      INCLUDE 'gen_constants.par'
      INCLUDE 'gen_units.par'
      INCLUDE 'hms_physics_sing.cmn'
      INCLUDE 'mc_structures.cmn'
      INCLUDE 'hms_calorimeter.cmn'
      INCLUDE 'hms_scin_tof.cmn'
      INCLUDE 'hms_scin_parms.cmn'
*
*     local variables 
      integer*4 goodtrack,track,i,ip
      real*4    COSGAMMA,COSHSTHETA,SINHSTHETA,TANDELPHI,SINHPHI
      real*4    p3, t1,ta,t3,hminv2,chi2min,chi2perdeg
*--------------------------------------------------------
*
      ABORT= .FALSE.
      err= ' '
*     Need to test to chose the best track
      if( HNTRACKS_FP.GT. 0) then
         chi2min= 1e10
         goodtrack = 0
         do track = 1, HNTRACKS_FP

            if( HNFREE_FP(track).ge. hsel_ndegreesmin) then
               chi2perdeg = HCHI2_FP(track)/FLOAT(HNFREE_FP(track))
               if(chi2perdeg .lt. chi2min) then
*     simple particle id tests
                  if( ( HDEDX(track,1) .gt. hsel_dedx1min)  .and.
     &                 ( HDEDX(track,1) .lt. hsel_dedx1max)  .and.
     &                 ( HBETA(track)   .gt. hsel_betamin)   .and.
     &                 ( HBETA(track)   .lt. hsel_betamax)   .and.
     &                 ( HTRACK_ET(track) .gt. hsel_etmin)   .and.
     &                 ( HTRACK_ET(track) .lt. hsel_etmax)) then
                     goodtrack = track
                  endif                 ! end test on track id
               endif                    ! end test on lower chisq
            endif                       ! end test on minimum number of degrees of freedom
         enddo                          ! end loop on track
         HSNUM_TARTRACK = goodtrack
         HSNUM_FPTRACK  = goodtrack
         if(goodtrack.eq.0) return      ! return if no valid tracks

*     ! with zero set in HSNUM_...
         HSP = HP_TAR(HSNUM_TARTRACK)
         HSENERGY = SQRT(HSP*HSP+HPARTMASS*HPARTMASS)
*     Copy variables for ntuple so we can test on them
         HSDELTA  = HDELTA_TAR(HSNUM_TARTRACK)
         HSX_TAR  = HX_TAR(HSNUM_TARTRACK)
         HSY_TAR  = HY_TAR(HSNUM_TARTRACK)
         HSXP_TAR  = HXP_TAR(HSNUM_TARTRACK)
         HSYP_TAR  = HYP_TAR(HSNUM_TARTRACK)
         HSDEDX1   = HDEDX(HSNUM_FPTRACK,1)
         HSDEDX2   = HDEDX(HSNUM_FPTRACK,2)
         HSDEDX3   = HDEDX(HSNUM_FPTRACK,3)
         HSDEDX4   = HDEDX(HSNUM_FPTRACK,4)
         HSBETA   = HBETA(HSNUM_FPTRACK)
         HSBETA_CHISQ = HBETA_CHISQ(HSNUM_FPTRACK)
         HSTRACK_ET   = HTRACK_ET(HSNUM_FPTRACK)
         HSTRACK_PRESHOWER_E   = HTRACK_PRESHOWER_E(HSNUM_FPTRACK)
         HSTIME_AT_FP   = HTIME_AT_FP(HSNUM_FPTRACK)
         HSX_FP   = HX_FP(HSNUM_FPTRACK)
         HSY_FP   = HY_FP(HSNUM_FPTRACK)
         HSXP_FP   = HXP_FP(HSNUM_FPTRACK)
         HSYP_FP   = HYP_FP(HSNUM_FPTRACK)

c         hsx_dc1 = hsx_fp + hsxp_fp * hdc_zpos(1)
c         hsy_dc1 = hsy_fp + hsyp_fp * hdc_zpos(1)
c         hsx_dc2 = hsx_fp + hsxp_fp * hdc_zpos(2)
c         hsy_dc2 = hsy_fp + hsyp_fp * hdc_zpos(2)
         hsx_s1 = hsx_fp + hsxp_fp * hscin_1x_zpos
         hsy_s1 = hsy_fp + hsyp_fp * hscin_1x_zpos
         hsx_s2 = hsx_fp + hsxp_fp * hscin_2x_zpos
         hsy_s2 = hsy_fp + hsyp_fp * hscin_2x_zpos
         hsx_cal = hsx_fp + hsxp_fp * hcal_1pr_zpos
         hsy_cal = hsy_fp + hsyp_fp * hcal_1pr_zpos
         htrue_x_fp = hsx_fp / sind(85.0) / (1/tand(85.0) - hsxp_fp)

         do ip=1,4
           hsscin_elem_hit(ip)=0
         enddo
         do i=1,hnum_scin_hit(hsnum_fptrack)
           ip=hscin_plane_num(hscin_hit(hsnum_fptrack,i))
           if (hsscin_elem_hit(ip).eq.0) then
             hsscin_elem_hit(ip)=hscin_counter_num(hscin_hit(hsnum_fptrack,i))
           else                      ! more than 1 hit in plane
             hsscin_elem_hit(ip)=18
           endif
         enddo                             

         HSCHI2PERDEG  = HCHI2_FP(HSNUM_FPTRACK)
     $        /FLOAT(HNFREE_FP(HSNUM_FPTRACK))
         HSNFREE_FP = HNFREE_FP(HSNUM_FPTRACK)
         cosgamma = 1.0/sqrt(1.0 + hsxp_tar**2 - hsyp_tar**2)
         coshstheta = cosgamma*(sinhthetas * hsyp_tar + coshthetas)
ccc         if( ABS(COSHSTHETA) .LT. 1.) then
            HSTHETA = ACOS(COSHSTHETA)
ccc         else
ccc            HSTHETA = 0.
ccc         endif
         SINHSTHETA = SIN(HSTHETA)
         tandelphi = hsxp_tar /
     &        ( sinhthetas - coshthetas*hsyp_tar )
         HSPHI = HPHI_LAB + TANDELPHI   ! HPHI_LAB must be multiple of
         SINHPHI = SIN(HSPHI)           ! pi/2, or above is crap
*     Calculate elastic scattering kinematics
         t1  = 2.*HPHYSICSA*CPBEAM*COSHSTHETA      
         ta  = 4*CPBEAM**2*COSHSTHETA**2 - HPHYSICSB**2
ccc SAW 1/17/95.  Add the stuff after the or.
         if(ta.eq.0.0 .or. ( HPHYSICAB2 + HPHYSICSM3B * ta).lt.0.0) then
            p3=0.       
         else
            t3  = ta-HPHYSICSB**2
            p3  = (t1 - SQRT( HPHYSICAB2 + HPHYSICSM3B * ta)) / ta
         endif
*     This is the difference in the momentum obtained by tracking
*     and the momentum from elastic kinematics
         HSELAS_COR = HSP - p3
*     INVARIANT MASS OF THE REMAINING PARTICLES
         hminv2 =   ( (CEBEAM+TMASS_TARGET-HSENERGY)**2
     &        - (CPBEAM - HSP * COSHSTHETA)**2
     &        - ( HSP * SINHSTHETA)**2  )       
         if(hminv2.ge.0 ) then
            HSMINV = SQRT(hminv2)
         else
            HSMINV = 0.
         endif                          ! end test on positive arg of SQRT
*     HSZBEAM is the intersection of the beam ray with the spectrometer
*     as measured along the z axis.
         if( SINHSTHETA .eq. 0.) then
            HSZBEAM = 0.
         else
            HSZBEAM = SINHPHI * ( -HSY_TAR + CYRAST * COSHSTHETA) /
     $           SINHSTHETA 
         endif                          ! end test on SINHSTHETA=0
*     
         
*     execute physics singles tests
         ierr=thtstexeb('hms_physics_sing')     
*
*     calculate physics statistics and wire chamber efficencies
         call h_physics_stat(ABORT,err)
         ABORT= ierr.ne.0 .or. ABORT
         IF(ABORT) THEN
            call G_add_path(here,err)
         ENDIF
      endif                             ! end test on zero tracks
      RETURN
      END
