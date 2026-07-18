# Hier Dateinamen der VHDL-Dateien anpassen
vcom -64 -2008 -work work ../fsm_t_package.vhd ../fsm.vhd ../fsm_testbench.vhd

# Hier Name der Testbench-Entity anpassen (work.EntityName)
vopt -64 +acc=npr -l elaborate.log -work work work.fsm_testbench -o testbench_opt    
    
vsim -64 -lib work testbench_opt

# GUI-Setup
view wave
view structure
view signals
# Signalnamen ohne Entity-Namen anzeigen
config wave -signalnamewidth 1
# Zeitbereich von 0 bis 15 ns anzeigen
wave zoom range 0ns 15ns

# Diese Signale werden angezeigt
# Format: /entity/signal


add wave /fsm_testbench/areset_ni 
add wave /fsm_testbench/clk 
add wave /fsm_testbench/person_d
add wave /fsm_testbench/rand_val_i  
add wave /fsm_testbench/state_o     
add wave /fsm_testbench/key_pressed_i 
add wave /fsm_testbench/key_data_i

# run -all # Simulation automatisch starten
