Getting WICD to connect to MWireless
# Getting WICD to connect to MWireless


**Note:** There's apparently a bug which results in "Bad Password" errors. Using PEAP with GTC may work.

1.  Save the following into a file called "peap-mschapv2" in `/etc/wicd/encrytion/templates`:

```
    name = PEAP-MSCHAPV2
    version = 1
    require identity *Identity password *Password
    optional ca_cert *Path_to_CA_Cert
    -----
    ctrl_interface=/var/run/wpa_supplicant
    network={
          ssid="$_ESSID"
          scan_ssid=$_SCAN
          proto=RSN WPA
          key_mgmt=WPA-EAP
          pairwise=CCMP TKIP
          group=CCMP TKIP
          eap=PEAP
          identity="$_IDENTITY"
          password="$_PASSWORD"
          ca_cert="$_CA_CERT"
          phase1="peaplavel=0"
          phase2="auth=MSCHAPV2"
    }
```

2.  In the same directory, append the line "peap-mschapv2" to the end of file `active`.
3.  Restart WICD, and when connecting to MWireless, choose the new PEAP-MSCHAPV2 encryption option. Identity and Password are your Kerberos account,
    and Path to CA cert is the path to the security certificate available [here](http://www.itcom.itd.umich.edu/wireless/connect/linux.php).

Reference: <http://kb.iu.edu/data/bbtc.html>
