      subroutine s_Ntuple_init(ABORT,err)
*----------------------------------------------------------------------
*
*     Creates an SOS Ntuple
*
*     Purpose : Books an SOS Ntuple; defines structure of it
*
*     Output: ABORT      - success or failure
*           : err        - reason for failure, if any
*
*     Created: 8-Apr-1994  K.B.Beard, Hampton Univ.
* $Log$
* Revision 1.2  1994/06/17 02:36:00  cdaq
* (KBB) Upgrade
*
* Revision 1.1  1994/04/12  16:16:18  cdaq
* Initial revision
*
*
*----------------------------------------------------------------------
      implicit none
      save
*
      character*13 here
      parameter (here='s_Ntuple_init')
*
      logical ABORT
      character*(*) err
*
      INCLUDE 's_ntuple.cmn'
      INCLUDE 's_ntuple.dte'
      INCLUDE 'gen_routines.dec'
*
      character*80 default_name
      parameter (default_name= 'SOSntuple')
      integer default_bank,default_recL
      parameter (default_bank= 8000)    !4 bytes/word
      parameter (default_recL= 1024)    !record length
      character*80 title
      character*80 directory,name
      character*256 file
      character*1000 pat,msg
      integer status,size,io,id,bank,recL,iv(10),m
      real rv(10)
*
      logical HEXIST           !CERNLIB function
*
*--------------------------------------------------------
      err= ' '
      ABORT = .FALSE.
*
      IF(s_Ntuple_exists) THEN
        call s_Ntuple_shutdown(ABORT,err)
        If(ABORT) Then
          call G_add_path(here,err)
          RETURN
        EndIf
      ENDIF
*
      call NO_nulls(s_Ntuple_file)     !replace null characters with blanks
*
*-if name blank, just forget it
      IF(s_Ntuple_file.EQ.' ') RETURN   !do nothing
*
*- get any free IO channel
*
      call g_IO_control(s_Ntuple_IOchannel,'ANY',ABORT,err)
      io= s_Ntuple_IOchannel
      s_Ntuple_exists= .NOT.ABORT
      IF(ABORT) THEN
        call G_add_path(here,err)
        RETURN
      ENDIF
*
      s_Ntuple_ID= default_s_Ntuple_ID
      id= s_Ntuple_ID
*
      ABORT= HEXIST(id)
      IF(ABORT) THEN
        call g_IO_control(s_Ntuple_IOchannel,'FREE',ABORT,err)
        call G_build_note(':HBOOK id#$ already in use',
     &                                 '$',id,' ',rv,' ',err)
        call G_add_path(here,err)
        RETURN
      ENDIF
*
      CALL HCDIR(directory,'R')       !CERNLIB read current directory
*
      s_Ntuple_name= default_name
*
      id= s_Ntuple_ID
      name= s_Ntuple_name
      file= s_Ntuple_file
      recL= default_recL
*
*-open New *.rzdat file-
      call HROPEN(io,name,file,'N',recL,status)       !CERNLIB
*                                       !directory set to "//TUPLE"
      ABORT= status.NE.0
      IF(ABORT) THEN
        call g_IO_control(s_Ntuple_IOchannel,'FREE',ABORT,err)
        iv(1)= status
        iv(2)= io
        pat= ':HROPEN error#$ opening IO#$ "'//file//'"'
        call G_build_note(pat,'$',iv,' ',rv,' ',err)
        call G_add_path(here,err)
        RETURN
      ENDIF
*
**********begin insert description of contents of SOS tuple ******
      m= 0
*  
      m= m+1
      s_Ntuple_tag(m)= 'SSP'	! Lab momentum of chosen track in GeV/c
      m= m+1
      s_Ntuple_tag(m)= 'SSENERGY'! Lab total energy of chosen track in GeV
      m= m+1
      s_Ntuple_tag(m)= 'SSDELTA'	! Spectrometer delta of chosen track
      m= m+1
      s_Ntuple_tag(m)= 'SSTHETA'	! Lab Scattering angle in radians
      m= m+1
      s_Ntuple_tag(m)= 'SSPHI'	! Lab Azymuthal angle in radians
      m= m+1
      s_Ntuple_tag(m)= 'SSMINV'	! Invariant Mass of remaing hadronic system
      m= m+1
      s_Ntuple_tag(m)= 'SSZBEAM'! Lab Z coordinate of intersection of beam
                                ! track with spectrometer ray
      m= m+1
      s_Ntuple_tag(m)= 'SSDEDX1'	! DEDX of chosen track in 1st scin plane
      m= m+1
      s_Ntuple_tag(m)= 'SSDEDX2'	! DEDX of chosen track in 2nd scin plane
      m= m+1
      s_Ntuple_tag(m)= 'SSDEDX3'	! DEDX of chosen track in 3rd scin plane
      m= m+1
      s_Ntuple_tag(m)= 'SSDEDX4'	! DEDX of chosen track in 4th scin plane
      m= m+1
      s_Ntuple_tag(m)= 'SSBETA'	! BETA of chosen track
      m= m+1
      s_Ntuple_tag(m)= 'SStrk_ET'! 'SSTRACK_ET'	! Total shower energy of chosen track
      m= m+1
      s_Ntuple_tag(m)= 'SStrk_PRESHOWER_E'!'SSTRACK_PRESHOWER_E' ! preshower of chosen track
      m= m+1
      s_Ntuple_tag(m)= 'SSTIME_AT_FP'
      m= m+1
      s_Ntuple_tag(m)= 'SSX_FP'		! X focal plane position 
      m= m+1
      s_Ntuple_tag(m)= 'SSY_FP'
      m= m+1
      s_Ntuple_tag(m)= 'SSXP_FP'
      m= m+1
      s_Ntuple_tag(m)= 'SSYP_FP'
      m= m+1
      s_Ntuple_tag(m)= 'SSCHI2PERDEG'	! CHI2 per degree of freedom of chosen track.
      m= m+1
      s_Ntuple_tag(m)= 'SSX_TAR'
      m= m+1
      s_Ntuple_tag(m)= 'SSY_TAR'
      m= m+1
      s_Ntuple_tag(m)= 'SSXP_TAR'
      m= m+1
      s_Ntuple_tag(m)= 'SSYP_TAR'
*
      m= m+1
      s_Ntuple_tag(m)= 'SSNUM_FPTRACK'	! Index of focal plane track chosen
      m= m+1
      s_Ntuple_tag(m)= 'SSNUM_TARTRACK'	! Index of target track chosen
      m= m+1
      s_Ntuple_tag(m)= 'SSID_LUND'	! LUND particle ID code -- not yet filled
      m= m+1
      s_Ntuple_tag(m)= 'SSNFREE_FP'
*
      m= m+1
      s_Ntuple_tag(m)= 'eventID'
*
      s_Ntuple_size= m     !total size
***********end insert description of contents of SOS tuple********
*
      title= s_Ntuple_title
      IF(title.EQ.' ') THEN
        msg= name//' '//s_Ntuple_file
        call only_one_blank(msg)
        title= msg   
        s_Ntuple_title= title
      ENDIF
*
      id= s_Ntuple_ID
      title= s_Ntuple_title
      size= s_Ntuple_size
      file= s_Ntuple_file
      bank= default_bank
      call HBOOKN(id,title,size,name,bank,s_Ntuple_tag)      !create Ntuple
*
      call HCDIR(s_Ntuple_directory,'R')      !record Ntuple directory
*
      CALL HCDIR(directory,' ')       !reset CERNLIB directory
*
      s_Ntuple_exists= HEXIST(s_Ntuple_ID)
      ABORT= .NOT.s_Ntuple_exists
*
      iv(1)= id
      iv(2)= io
      pat= 'Ntuple id#$ [' // s_Ntuple_directory // '/]' // 
     &           name // ' IO#$ "' // s_Ntuple_file // '"'
      call G_build_note(pat,'$',iv,' ',rv,' ',msg)
      call sub_string(msg,' /]','/]')
*
      IF(ABORT) THEN
        err= ':unable to create '//msg
        call G_add_path(here,err)
      ELSE
        pat= ':created '//msg
        call G_add_path(here,pat)
        call G_log_message('INFO: '//pat)
      ENDIF
*
      RETURN
      END  
