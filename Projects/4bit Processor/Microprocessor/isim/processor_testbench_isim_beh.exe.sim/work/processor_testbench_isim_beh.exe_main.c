/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_00000000003652496116_0886308060_init();
    work_m_00000000004149495063_1317451190_init();
    work_m_00000000003611661472_0317860448_init();
    work_m_00000000001724269114_1210226550_init();
    work_m_00000000004058334446_3238527249_init();
    work_m_00000000003558007621_2748799600_init();
    work_m_00000000003492385983_1491512204_init();
    work_m_00000000001806213216_3831717581_init();
    work_m_00000000003145311030_3674772129_init();
    work_m_00000000002800728495_4125434173_init();
    work_m_00000000004105680235_1667949733_init();
    work_m_00000000000787319569_0756788125_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000000787319569_0756788125");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
