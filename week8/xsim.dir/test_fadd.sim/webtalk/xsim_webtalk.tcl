webtalk_init -webtalk_dir /home/tansei/hardware/week8/xsim.dir/test_fadd.sim/webtalk/
webtalk_register_client -client project
webtalk_add_data -client project -key date_generated -value "Thu Jun  8 19:37:07 2017" -context "software_version_and_target_device"
webtalk_add_data -client project -key product_version -value "XSIM v2016.4 (64-bit)" -context "software_version_and_target_device"
webtalk_add_data -client project -key build_version -value "1756540" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_platform -value "LIN64" -context "software_version_and_target_device"
webtalk_add_data -client project -key registration_id -value "211142045_1777515821_210626051_443" -context "software_version_and_target_device"
webtalk_add_data -client project -key tool_flow -value "xsim" -context "software_version_and_target_device"
webtalk_add_data -client project -key beta -value "FALSE" -context "software_version_and_target_device"
webtalk_add_data -client project -key route_design -value "FALSE" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_family -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_device -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_package -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_speed -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key random_id -value "1293dd6b4eb65192959c59a4f21ab381" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_id -value "f3bd2d77-32d2-4b27-aa82-28f2326ce60b" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_iteration -value "195" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_name -value "Ubuntu" -context "user_environment"
webtalk_add_data -client project -key os_release -value "Ubuntu 14.04.5 LTS" -context "user_environment"
webtalk_add_data -client project -key cpu_name -value "Intel(R) Core(TM) i7-4610M CPU @ 3.00GHz" -context "user_environment"
webtalk_add_data -client project -key cpu_speed -value "3639.609 MHz" -context "user_environment"
webtalk_add_data -client project -key total_processors -value "1" -context "user_environment"
webtalk_add_data -client project -key system_ram -value "16.000 GB" -context "user_environment"
webtalk_register_client -client xsim
webtalk_add_data -client xsim -key runall -value "true" -context "xsim\\command_line_options"
webtalk_add_data -client xsim -key Command -value "xsim" -context "xsim\\command_line_options"
webtalk_add_data -client xsim -key runtime -value "33601352 ns" -context "xsim\\usage"
webtalk_add_data -client xsim -key iteration -value "0" -context "xsim\\usage"
webtalk_add_data -client xsim -key Simulation_Time -value "60.79_sec" -context "xsim\\usage"
webtalk_add_data -client xsim -key Simulation_Memory -value "135460_KB" -context "xsim\\usage"
webtalk_transmit -clientid 4235337836 -regid "211142045_1777515821_210626051_443" -xml /home/tansei/hardware/week8/xsim.dir/test_fadd.sim/webtalk/usage_statistics_ext_xsim.xml -html /home/tansei/hardware/week8/xsim.dir/test_fadd.sim/webtalk/usage_statistics_ext_xsim.html -wdm /home/tansei/hardware/week8/xsim.dir/test_fadd.sim/webtalk/usage_statistics_ext_xsim.wdm -intro "<H3>XSIM Usage Report</H3><BR>"
webtalk_terminate
