from libqtile import widget
import os 

critical_msg = 'notify-send "Connect the laptop NOW!" -u critical'
log_msg = 'notify-send "Low battery"'
full_msg = 'notify-send "Full battery :)"'
battery = widget.Battery()

while True:
    battery_info = battery.poll()
    if battery_info.split()[1] == '20%':
        os.system(critical_msg)
    elif battery_info.split()[1] == '25%':
        os.system(low_msg)
    elif battery_info.split()[1]=='100%':
        os.system(full_msg)
