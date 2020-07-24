Useful Commands for Running Ubuntu on a Macbook
# Useful Commands for Running Ubuntu on a Macbook

Note: These are based on Ubuntu 12.04 on a Macbook 7,1.

-   To control the keyboard backlight, use

         echo 0 | sudo tee -a /sys/class/leds/smc::kbd_backlight/brightness

    0 turns it off, 255 is fullest brightness.

-   By default, the headphone jack has a bright red LED shining in it.
    This turns it off.

         amixer set IEC958 off

-   Some commands to make the trackpad perform like it does in OS X. The
    first disables tap-to-click completely, the second allows horizontal
    scrolling, and the last supposedly tries to stop accidental palm
    presses (though its not foolproof).

        synclient MaxTapTime=0
        synclient HorizTwoFingerScroll=1
        synclient PalmDetect=1

-   If the Macbook won\'t goto sleep automatically when the lid is
    closed, you can run the following before closing it.

         sudo /etc/acpi/sleep.sh

    Alternatively, install package `uswsusp`, and run the following.

         sudo s2ram --force
