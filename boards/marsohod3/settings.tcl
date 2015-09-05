# Create a Quartus II project for simple flashing LEDs demo
# on the Marsohod2 board.
#
# Arg 1: Project name
# Arg 2: Source directory

if { $::argc != 2 } {
    puts "Error: Insufficient or invalid options passed to script \"[file tail $argv0]\"."
    exit 1
}

set proj [lindex $::argv 0]
set src  [lindex $::argv 1]
set family "MAX 10"
set part   "10M50SAE144C8GES"
set top    "Top"

# Create a new project
project_new -family $family -part $part $proj
set_global_assignment -name TOP_LEVEL_ENTITY $top

source ../scripts/marsohodx_list.tcl

marsohodx_list $src
marsohodx_list ../rtl/verilog

set_global_assignment -name FLOW_ENABLE_POWER_ANALYZER Off


# Pin constraints
set_global_assignment -name FLOW_ENABLE_IO_ASSIGNMENT_ANALYSIS ON

set_location_assignment PIN_26 -to CLK100MHZ

set_location_assignment PIN_83 -to LED[7]
set_location_assignment PIN_80 -to LED[6]
set_location_assignment PIN_81 -to LED[5]
set_location_assignment PIN_84 -to LED[4]
set_location_assignment PIN_85 -to LED[3]
set_location_assignment PIN_86 -to LED[2]
set_location_assignment PIN_87 -to LED[1]
set_location_assignment PIN_88 -to LED[0]

set outputs [list "LED[0]" "LED[1]" "LED[2]" "LED[3]" "LED[4]" "LED[5]" "LED[6]" "LED[7]"]
set inputs [list "CLK100MHZ"]

foreach i [concat $inputs $outputs] {
	set_instance_assignment -name IO_STANDARD "2.5 V" -to $i
	set_instance_assignment -name CURRENT_STRENGTH_NEW 12MA -to $i
}

foreach i $outputs {
	set_instance_assignment -name SLEW_RATE 2 -to $i
}
