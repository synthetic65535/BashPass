# BashPass
Simple console password manager script

* Stores passwords as text file inside encrypted 7z file
* 7z archive approach gives future-proof cross-platform portable storage, but arguably less secure then GPG approach
* Passwords are unpacked in RAM (/dev/shm) leaving no traces on HDD/SSD
* If you will need your passwords in the field, you can unpack them on Windows/Android (but it will be insecure)
* Uses Vim to view and edit passwords

Usage:
* `./pass.sh init` - Initialize
* `./pass.sh` - View
* `./pass.sh edit` - Edit

