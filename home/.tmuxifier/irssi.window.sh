# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
#window_root "~/Projects/irssi"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "irssi"

# Split window into panes.
split_h 20

# Run commands.
run_cmd "cat /home/spenserj/.irssi/nicklistfifo" 1
run_cmd "sleep 1; irssi" 0
send_keys "/nicklist fifo" 0
send_keys Enter 0

# Paste text
#send_keys "top"    # paste into active pane
#send_keys "date" 1 # paste into active pane

# Set active pane.
select_pane 0
