      subroutine g_calc_raster_pedestal(ABORT,err)
*
* $Log$
* Revision 1.2  1999/02/10 17:38:43  csa
* Cleanup
*
* Revision 1.1  1996/01/22 15:10:20  saw
* Initial revision
*
      implicit none
      save
*
      character*23 here
      parameter (here='g_calc_raster_pedestal')
*
      logical ABORT
      character*(*) err
*
      INCLUDE 'gen_data_structures.cmn'
*
* extract raster pedestal information from gmisc variables.
*
      gfrx_adc_ped=gmisc_ped(14,2)     !2 is for ADCs
      gfry_adc_ped=gmisc_ped(16,2)
      gsrx_adc_ped=0.
      gsry_adc_ped=0.
      gfrx_sync_mean=gmisc_ped(13,2)
      gfry_sync_mean=gmisc_ped(15,2)
      gsrx_sync_mean=0.
      gsry_sync_mean=0.


      return
      end
