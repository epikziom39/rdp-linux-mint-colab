wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip > /dev/null 2>&1
unzip ngrok-stable-linux-amd64.zip > /dev/null 2>&1
read -p "Paste authtoken here https://dashboard.ngrok.com/get-started/your-authtoken (Copy and Ctrl+V to paste then press Enter): " CRP
./ngrok authtoken $CRP
echo region "us, eu, au, ap, sa, jp, in"
read -p "region: " region
nohup ./ngrok tcp -region $region 2137 &>/dev/null &
mkdir mint
cd mint
echo update
sudo apt update -y > /dev/null 2>&1
echo install qemu
sudo apt install qemu-system-x86 curl -y > /dev/null 2>&1
echo install mint iso
wget https://mirrors.layeronline.com/linuxmint/stable/20.3/linuxmint-20.3-cinnamon-64bit.iso
echo making disk
qemu-img create mint.vdi 100G
echo Your VNC IP Address:
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
sudo qemu-system-x86_64 -cdrom Tiny11 by Harbour of Tech.iso -vnc :2137 -hda win11.vdi -smp cores=5 -m 10000M -machine usb=on -device usb-tablet > /dev/null 2>&1
echo 12 hours
sleep 43200
