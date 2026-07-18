# clk
set_property IOSTANDARD LVCMOS33 [get_ports clk_0]
set_property PACKAGE_PIN Y9 [get_ports clk_0]
create_clock -period 10.000 -name clk_0 -waveform {0.000 5.000} [get_ports clk_0]

# reset
set_property IOSTANDARD LVCMOS33 [get_ports rst_n]
set_property PACKAGE_PIN M15 [get_ports rst_n]

# PMOD KYPD JC
set_property IOSTANDARD LVCMOS33 [get_ports {kypd_c4}]
set_property IOSTANDARD LVCMOS33 [get_ports {kypd_c3}]
set_property IOSTANDARD LVCMOS33 [get_ports {kypd_c2}]
set_property IOSTANDARD LVCMOS33 [get_ports {kypd_c1}]
set_property IOSTANDARD LVCMOS33 [get_ports {kypd_r4}]
set_property IOSTANDARD LVCMOS33 [get_ports {kypd_r3}]
set_property IOSTANDARD LVCMOS33 [get_ports {kypd_r2}]
set_property IOSTANDARD LVCMOS33 [get_ports {kypd_r1}]

set_property PACKAGE_PIN V7 [get_ports {kypd_c4}];  # "JD1_P" COL4
set_property PACKAGE_PIN W7 [get_ports {kypd_c3}];  # "JD1_N" COL3
set_property PACKAGE_PIN V5 [get_ports {kypd_c2}];  # "JD2_P" COL2
set_property PACKAGE_PIN V4 [get_ports {kypd_c1}];  # "JD2_N" COL1
set_property PACKAGE_PIN W6 [get_ports {kypd_r4}];  # "JD3_P" ROW4
set_property PACKAGE_PIN W5 [get_ports {kypd_r3}];  # "JD3_N" ROW3
set_property PACKAGE_PIN U6 [get_ports {kypd_r2}];  # "JD4_P" ROW2
set_property PACKAGE_PIN U5 [get_ports {kypd_r1}];  # "JD4_N" ROW1


# PMOD MaxSonar JA
#set_property IOSTANDARD LVCMOS33 [get_ports {sonar_o}] 
set_property IOSTANDARD LVCMOS33 [get_ports {sonar_rx}] 
#set_property IOSTANDARD LVCMOS33 [get_ports {sonar_transmiter}]
set_property IOSTANDARD LVCMOS33 [get_ports {sonar_pulse}]


#set_property PACKAGE_PIN Y11  [get_ports {sonar_o}];  # "JA1" AN
set_property PACKAGE_PIN AA11 [get_ports {sonar_rx}];  # "JA2" RX
#set_property PACKAGE_PIN Y10  [get_ports {sonar_transmiter}];  # "JA3" TX
set_property PACKAGE_PIN AA9  [get_ports {sonar_pulse}];  # "JA4" PW


# PMOD OLED RGB JB
set_property IOSTANDARD LVCMOS33 [get_ports {oled_cs_n}]
set_property IOSTANDARD LVCMOS33 [get_ports {oled_mosi}]
set_property IOSTANDARD LVCMOS33 [get_ports {oled_sclk}]
set_property IOSTANDARD LVCMOS33 [get_ports {oled_dc}]
set_property IOSTANDARD LVCMOS33 [get_ports {oled_rst_n}]
set_property IOSTANDARD LVCMOS33 [get_ports {oled_vbatc}]
set_property IOSTANDARD LVCMOS33 [get_ports {oled_vddc}]

set_property PACKAGE_PIN W12 [get_ports {oled_cs_n}];  # "JB1"
set_property PACKAGE_PIN W11 [get_ports {oled_mosi}];  # "JB2"
set_property PACKAGE_PIN W8 [get_ports {oled_sclk}];  # "JB4"
set_property PACKAGE_PIN V12 [get_ports {oled_dc}];  # "JB7"
set_property PACKAGE_PIN W10 [get_ports {oled_rst_n}];  # "JB8"
set_property PACKAGE_PIN V9 [get_ports {oled_vbatc}];  # "JB9"
set_property PACKAGE_PIN V8 [get_ports {oled_vddc}];  # "JB10"

# LEDs
set_property IOSTANDARD LVCMOS33 [get_ports {leds_o[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds_o[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds_o[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds_o[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds_o[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds_o[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds_o[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds_o[7]}]

set_property PACKAGE_PIN T22 [get_ports {leds_o[0]}]
set_property PACKAGE_PIN T21 [get_ports {leds_o[1]}]
set_property PACKAGE_PIN U22 [get_ports {leds_o[2]}]
set_property PACKAGE_PIN U21 [get_ports {leds_o[3]}]
set_property PACKAGE_PIN V22 [get_ports {leds_o[4]}]
set_property PACKAGE_PIN W22 [get_ports {leds_o[5]}]
set_property PACKAGE_PIN U19 [get_ports {leds_o[6]}]
set_property PACKAGE_PIN U14 [get_ports {leds_o[7]}]
