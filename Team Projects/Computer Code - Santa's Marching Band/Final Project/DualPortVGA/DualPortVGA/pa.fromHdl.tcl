
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name DualPortVGA -dir "C:/Xilinx/DualPortVGA/planAhead_run_3" -part xc6slx16csg324-3
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "DualVGA.ucf" [current_fileset -constrset]
add_files [list {ipcore_dir/DualMemory.ngc}]
set hdlfile [add_files [list {ipcore_dir/DualMemory.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {DualVGA.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {TopBell.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top TopBell $srcset
add_files [list {DualVGA.ucf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/DualMemory.ncf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc6slx16csg324-3
