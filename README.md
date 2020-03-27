
# IPFS screenshot url

Make screenshot and save it to IPFS (like cloudapp but using IPFS). If you're asking why IPFS, you should check out ipfs.io. A simple way to think of IPFS is torrents but accessible through HTTP. 

Sample IPFS link: https://gateway.ipfs.io/ipfs/QmVqeZQRfcvn8eMZARzRZRxHLignNhS59ksV9vQR3Mmuph/20200326_224139_screenshot.jpg


# Setup on Ubuntu
Currently no installer so steps need to be taken manually.

1. Install [IPFS](https://ipfs.io/docs/install/)
2. install xclip, `apt-get install xclip`
3. Clone repository, `git clone git@github.com:santaklouse/ipfs-screenshot`
4. Start ipfs daemon, `ipfs daemon`
5. create keyboard shortcut, System Settings -> Keyboard -> Shortcuts -> Custom Shortcuts -> +
  - command: /{path-to-ipfs-screen}/ipfs-screen.sh

# Setup on Mac OS

1. Install [IPFS](https://ipfs.io/docs/install/)
2. Clone repository, `git clone git@github.com:santaklouse/ipfs-screenshot`
3. Start ipfs daemon, `ipfs daemon`
4. Run`install.sh`
5. use Preferences in order to set Keyboard Shortcuts


# Use
1. use keyboard shortcut ie: ctrl + shift + s
2. Select screen area
3. Paste, ipfs url to the screenshot will be available for use
