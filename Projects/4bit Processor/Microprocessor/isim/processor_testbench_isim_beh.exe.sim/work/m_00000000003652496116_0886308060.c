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

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "//chips.eng.utah.edu/home/sethk/.win_desktop/My processor/Microprocessor/ALU.v";
static unsigned int ng1[] = {2U, 0U};
static unsigned int ng2[] = {15U, 0U};
static unsigned int ng3[] = {14U, 0U};
static unsigned int ng4[] = {13U, 0U};
static unsigned int ng5[] = {12U, 0U};
static int ng6[] = {0, 0};



static void Always_28_0(char *t0)
{
    char t4[8];
    char t15[8];
    char *t1;
    char *t2;
    char *t3;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    char *t14;
    char *t16;
    char *t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    char *t30;
    char *t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    char *t37;
    char *t38;
    unsigned int t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    char *t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    unsigned int t50;
    unsigned int t51;
    int t52;
    int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    char *t60;

LAB0:    t1 = (t0 + 2688U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(28, ng0);
    t2 = (t0 + 3008);
    *((int *)t2) = 1;
    t3 = (t0 + 2720);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(29, ng0);

LAB5:    xsi_set_current_line(30, ng0);
    t5 = (t0 + 1368U);
    t6 = *((char **)t5);
    memset(t4, 0, 8);
    t5 = (t4 + 4);
    t7 = (t6 + 4);
    t8 = *((unsigned int *)t6);
    t9 = (t8 >> 2);
    *((unsigned int *)t4) = t9;
    t10 = *((unsigned int *)t7);
    t11 = (t10 >> 2);
    *((unsigned int *)t5) = t11;
    t12 = *((unsigned int *)t4);
    *((unsigned int *)t4) = (t12 & 3U);
    t13 = *((unsigned int *)t5);
    *((unsigned int *)t5) = (t13 & 3U);
    t14 = ((char*)((ng1)));
    memset(t15, 0, 8);
    t16 = (t4 + 4);
    t17 = (t14 + 4);
    t18 = *((unsigned int *)t4);
    t19 = *((unsigned int *)t14);
    t20 = (t18 ^ t19);
    t21 = *((unsigned int *)t16);
    t22 = *((unsigned int *)t17);
    t23 = (t21 ^ t22);
    t24 = (t20 | t23);
    t25 = *((unsigned int *)t16);
    t26 = *((unsigned int *)t17);
    t27 = (t25 | t26);
    t28 = (~(t27));
    t29 = (t24 & t28);
    if (t29 != 0)
        goto LAB9;

LAB6:    if (t27 != 0)
        goto LAB8;

LAB7:    *((unsigned int *)t15) = 1;

LAB9:    t31 = (t15 + 4);
    t32 = *((unsigned int *)t31);
    t33 = (~(t32));
    t34 = *((unsigned int *)t15);
    t35 = (t34 & t33);
    t36 = (t35 != 0);
    if (t36 > 0)
        goto LAB10;

LAB11:    xsi_set_current_line(32, ng0);
    t2 = (t0 + 1368U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng2)));
    memset(t4, 0, 8);
    t5 = (t3 + 4);
    t6 = (t2 + 4);
    t8 = *((unsigned int *)t3);
    t9 = *((unsigned int *)t2);
    t10 = (t8 ^ t9);
    t11 = *((unsigned int *)t5);
    t12 = *((unsigned int *)t6);
    t13 = (t11 ^ t12);
    t18 = (t10 | t13);
    t19 = *((unsigned int *)t5);
    t20 = *((unsigned int *)t6);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB16;

LAB13:    if (t21 != 0)
        goto LAB15;

LAB14:    *((unsigned int *)t4) = 1;

LAB16:    t14 = (t4 + 4);
    t24 = *((unsigned int *)t14);
    t25 = (~(t24));
    t26 = *((unsigned int *)t4);
    t27 = (t26 & t25);
    t28 = (t27 != 0);
    if (t28 > 0)
        goto LAB17;

LAB18:    xsi_set_current_line(34, ng0);
    t2 = (t0 + 1368U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng3)));
    memset(t4, 0, 8);
    t5 = (t3 + 4);
    t6 = (t2 + 4);
    t8 = *((unsigned int *)t3);
    t9 = *((unsigned int *)t2);
    t10 = (t8 ^ t9);
    t11 = *((unsigned int *)t5);
    t12 = *((unsigned int *)t6);
    t13 = (t11 ^ t12);
    t18 = (t10 | t13);
    t19 = *((unsigned int *)t5);
    t20 = *((unsigned int *)t6);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB25;

LAB22:    if (t21 != 0)
        goto LAB24;

LAB23:    *((unsigned int *)t4) = 1;

LAB25:    t14 = (t4 + 4);
    t24 = *((unsigned int *)t14);
    t25 = (~(t24));
    t26 = *((unsigned int *)t4);
    t27 = (t26 & t25);
    t28 = (t27 != 0);
    if (t28 > 0)
        goto LAB26;

LAB27:    xsi_set_current_line(36, ng0);
    t2 = (t0 + 1368U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng4)));
    memset(t4, 0, 8);
    t5 = (t3 + 4);
    t6 = (t2 + 4);
    t8 = *((unsigned int *)t3);
    t9 = *((unsigned int *)t2);
    t10 = (t8 ^ t9);
    t11 = *((unsigned int *)t5);
    t12 = *((unsigned int *)t6);
    t13 = (t11 ^ t12);
    t18 = (t10 | t13);
    t19 = *((unsigned int *)t5);
    t20 = *((unsigned int *)t6);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB35;

LAB32:    if (t21 != 0)
        goto LAB34;

LAB33:    *((unsigned int *)t4) = 1;

LAB35:    t14 = (t4 + 4);
    t24 = *((unsigned int *)t14);
    t25 = (~(t24));
    t26 = *((unsigned int *)t4);
    t27 = (t26 & t25);
    t28 = (t27 != 0);
    if (t28 > 0)
        goto LAB36;

LAB37:    xsi_set_current_line(38, ng0);
    t2 = (t0 + 1368U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng5)));
    memset(t4, 0, 8);
    t5 = (t3 + 4);
    t6 = (t2 + 4);
    t8 = *((unsigned int *)t3);
    t9 = *((unsigned int *)t2);
    t10 = (t8 ^ t9);
    t11 = *((unsigned int *)t5);
    t12 = *((unsigned int *)t6);
    t13 = (t11 ^ t12);
    t18 = (t10 | t13);
    t19 = *((unsigned int *)t5);
    t20 = *((unsigned int *)t6);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB42;

LAB39:    if (t21 != 0)
        goto LAB41;

LAB40:    *((unsigned int *)t4) = 1;

LAB42:    t14 = (t4 + 4);
    t24 = *((unsigned int *)t14);
    t25 = (~(t24));
    t26 = *((unsigned int *)t4);
    t27 = (t26 & t25);
    t28 = (t27 != 0);
    if (t28 > 0)
        goto LAB43;

LAB44:    xsi_set_current_line(41, ng0);

LAB46:    xsi_set_current_line(42, ng0);
    t2 = ((char*)((ng6)));
    t3 = (t0 + 1768);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 4);

LAB45:
LAB38:
LAB28:
LAB19:
LAB12:    goto LAB2;

LAB8:    t30 = (t15 + 4);
    *((unsigned int *)t15) = 1;
    *((unsigned int *)t30) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(31, ng0);
    t37 = (t0 + 1208U);
    t38 = *((char **)t37);
    t37 = (t0 + 1768);
    xsi_vlogvar_assign_value(t37, t38, 0, 0, 4);
    goto LAB12;

LAB15:    t7 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t7) = 1;
    goto LAB16;

LAB17:    xsi_set_current_line(33, ng0);
    t16 = (t0 + 1048U);
    t17 = *((char **)t16);
    memset(t15, 0, 8);
    t16 = (t15 + 4);
    t30 = (t17 + 4);
    t29 = *((unsigned int *)t17);
    t32 = (~(t29));
    *((unsigned int *)t15) = t32;
    *((unsigned int *)t16) = 0;
    if (*((unsigned int *)t30) != 0)
        goto LAB21;

LAB20:    t39 = *((unsigned int *)t15);
    *((unsigned int *)t15) = (t39 & 15U);
    t40 = *((unsigned int *)t16);
    *((unsigned int *)t16) = (t40 & 15U);
    t31 = (t0 + 1768);
    xsi_vlogvar_assign_value(t31, t15, 0, 0, 4);
    goto LAB19;

LAB21:    t33 = *((unsigned int *)t15);
    t34 = *((unsigned int *)t30);
    *((unsigned int *)t15) = (t33 | t34);
    t35 = *((unsigned int *)t16);
    t36 = *((unsigned int *)t30);
    *((unsigned int *)t16) = (t35 | t36);
    goto LAB20;

LAB24:    t7 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t7) = 1;
    goto LAB25;

LAB26:    xsi_set_current_line(35, ng0);
    t16 = (t0 + 1048U);
    t17 = *((char **)t16);
    t16 = (t0 + 1208U);
    t30 = *((char **)t16);
    t29 = *((unsigned int *)t17);
    t32 = *((unsigned int *)t30);
    t33 = (t29 & t32);
    *((unsigned int *)t15) = t33;
    t16 = (t17 + 4);
    t31 = (t30 + 4);
    t37 = (t15 + 4);
    t34 = *((unsigned int *)t16);
    t35 = *((unsigned int *)t31);
    t36 = (t34 | t35);
    *((unsigned int *)t37) = t36;
    t39 = *((unsigned int *)t37);
    t40 = (t39 != 0);
    if (t40 == 1)
        goto LAB29;

LAB30:
LAB31:    t60 = (t0 + 1768);
    xsi_vlogvar_assign_value(t60, t15, 0, 0, 4);
    goto LAB28;

LAB29:    t41 = *((unsigned int *)t15);
    t42 = *((unsigned int *)t37);
    *((unsigned int *)t15) = (t41 | t42);
    t38 = (t17 + 4);
    t43 = (t30 + 4);
    t44 = *((unsigned int *)t17);
    t45 = (~(t44));
    t46 = *((unsigned int *)t38);
    t47 = (~(t46));
    t48 = *((unsigned int *)t30);
    t49 = (~(t48));
    t50 = *((unsigned int *)t43);
    t51 = (~(t50));
    t52 = (t45 & t47);
    t53 = (t49 & t51);
    t54 = (~(t52));
    t55 = (~(t53));
    t56 = *((unsigned int *)t37);
    *((unsigned int *)t37) = (t56 & t54);
    t57 = *((unsigned int *)t37);
    *((unsigned int *)t37) = (t57 & t55);
    t58 = *((unsigned int *)t15);
    *((unsigned int *)t15) = (t58 & t54);
    t59 = *((unsigned int *)t15);
    *((unsigned int *)t15) = (t59 & t55);
    goto LAB31;

LAB34:    t7 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t7) = 1;
    goto LAB35;

LAB36:    xsi_set_current_line(37, ng0);
    t16 = (t0 + 1048U);
    t17 = *((char **)t16);
    t16 = (t0 + 1208U);
    t30 = *((char **)t16);
    memset(t15, 0, 8);
    xsi_vlog_unsigned_minus(t15, 4, t17, 4, t30, 4);
    t16 = (t0 + 1768);
    xsi_vlogvar_assign_value(t16, t15, 0, 0, 4);
    goto LAB38;

LAB41:    t7 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t7) = 1;
    goto LAB42;

LAB43:    xsi_set_current_line(39, ng0);
    t16 = (t0 + 1048U);
    t17 = *((char **)t16);
    t16 = (t0 + 1208U);
    t30 = *((char **)t16);
    memset(t15, 0, 8);
    xsi_vlog_unsigned_add(t15, 4, t17, 4, t30, 4);
    t16 = (t0 + 1768);
    xsi_vlogvar_assign_value(t16, t15, 0, 0, 4);
    goto LAB45;

}


extern void work_m_00000000003652496116_0886308060_init()
{
	static char *pe[] = {(void *)Always_28_0};
	xsi_register_didat("work_m_00000000003652496116_0886308060", "isim/processor_testbench_isim_beh.exe.sim/work/m_00000000003652496116_0886308060.didat");
	xsi_register_executes(pe);
}
