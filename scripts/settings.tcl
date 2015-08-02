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
set family "Cyclone III"
set part   "EP3C10E144C8"
set top    "Top"


# Create a new project
project_new -family $family -part $part $proj
set_global_assignment -name TOP_LEVEL_ENTITY $top


# Read the LIST file which contains a list of HDL sources.
set fp [open "$src/LIST" r]
set file_data [read $fp]
close $fp

# Add each source file to the project
set data [split $file_data "\n"]
foreach line $data {
    set trimmed [string trim $line]
    if { [string length $trimmed] > 0 } {
        set firstchar [string index $trimmed 0]
        if { $firstchar != "#" } {
            set ext [string tolower [file extension $trimmed]]
            if { $ext == ".v" } {
                set_global_assignment -name VERILOG_FILE "$src/$trimmed"
            } elseif { $ext == ".vhdl" } {
                set_global_assignment -name VHDL_FILE "$src/$trimmed"
            } elseif { $ext == ".qip" } {
                set_global_assignment -name QIP_FILE "$src/$trimmed"
            } elseif { $ext == ".mif" } {
                set_global_assignment -name MIF_FILE "$src/$trimmed"
            } else {
                puts "Error: Unknown or unhandled file type \"$ext\"."
            }
            set_global_assignment -name SEARCH_PATH "[file dirname "$src/$trimmed"]/"
        }
    }
}

set_global_assignment -name FLOW_ENABLE_IO_ASSIGNMENT_ANALYSIS ON

# Pin constraints
set_location_assignment PIN_25 -to clk

set_location_assignment PIN_79 -to LED[3]
set_location_assignment PIN_83 -to LED[2]
set_location_assignment PIN_84 -to LED[1]
set_location_assignment PIN_85 -to LED[0]

set outputs [list "LED[0]" "LED[1]" "LED[2]" "LED[3]" "clk"]
set inputs [list "clk"]

foreach i [concat $inputs $outputs] {
	set_instance_assignment -name IO_STANDARD "2.5 V" -to $i
	set_instance_assignment -name CURRENT_STRENGTH_NEW 8MA -to $i
}

foreach i $outputs {
	set_instance_assignment -name SLEW_RATE 2 -to $i
}
