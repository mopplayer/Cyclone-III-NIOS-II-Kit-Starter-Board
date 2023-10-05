set system_name [glob *.qpf];
puts "system_name = $system_name\n";
project_open $system_name
create_timing_netlist -model slow
read_sdc
update_timing_netlist
qsta_utility::generate_top_failures_per_clock "Top Failing Paths" 200
#qsta_utility::generate_all_core_timing_reports "Report Timing (Core)" 1000
delete_timing_netlist
project_close