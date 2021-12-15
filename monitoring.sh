Architecture=$(uname -a)
physicalCPU=$(nproc)
virtualCPU=$(cat /proc/cpuinfo | grep -c processor)
UsageMem=$(free -m | grep Mem | awk '{printf"%d/%dMB (%.2f%%)\n",$3, $2, $3/$2 *100}')
diskusage=$(df --total -H | grep total | sed 's/G//'| sed 's/G//' | awk '$1 == "total" {print $3 "/" $2"Gb " "("$5")"}')
cpuload=$(mpstat | grep all | awk '{printf "%.2f%%\n", 100-$13}')
lastboot=$(who -b | awk '{print $3 " " $4}')
lvmt=$(lsblk | grep "lvm" | wc -l)
lvmu=$(if [ $lvmt -eq 0 ]; then echo no; else echo yes; fi)
TCP=$(ss -s | grep TCP  | awk 'NR==1 {print $4 " ESTABLISHED"}' | sed 's/,//')
loguser=$(who | wc -l)
mac=$(ip link | grep "link/ether" | awk '$1 == "link/ether" {print $2}')
network=$(printf "%s" "IP $(hostname -I)($mac)")
nbsudo=$(echo "$(journalctl _COMM=sudo -q| grep -c COMMAND) cmd")
wall "
#Architecture: $Architecture
#CPU physical : $physicalCPU
#vCPU : $virtualCPU
#Memory Usage: $UsageMem
#Disk Usage: $diskusage
#CPU load: $cpuload
#Last boot: $lastboot
#LVM use: $lvmu
#Connexions TCP : $TCP
#User log: $loguser
#Network: $network
#Sudo : $nbsudo"
