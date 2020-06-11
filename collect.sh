#!/bin/bash


NOW=$(date +"%Y%m%d_%H%M%S")
DIR=_LB

if [ $# -ne 0 ]   
   then DIR=$1_$NOW
fi
  
if test ! -d $DIR 
   then  
     mkdir $DIR
fi


      
      CONFIG=./$DIR/config.$NOW.log
      
      # Get config
      printf "TIME: $NOW\n\n"			> $CONFIG

      echo "" 							>> $CONFIG
      echo ""							>> $CONFIG
      echo "========================"	>> $CONFIG
      echo "====== config.log ======"	>> $CONFIG
      echo "========================"	>> $CONFIG
      echo ""							>> $CONFIG
      echo ""							>> $CONFIG
      
      printf "KERNEL VERSION:\n"	>> $CONFIG
      uname -a 				>> $CONFIG
      printf "\n" 			>> $CONFIG
      printf "BIOS VERSION:\n"		>> $CONFIG
      dmidecode -s bios-version 	>> $CONFIG
      printf "\n" 			>> $CONFIG
      printf "IPMCTL CLI VERSION:\n"	>> $CONFIG
      ipmctl version 			>> $CONFIG
      printf "\n" 			>> $CONFIG
      printf "DCPMM FW VERSION:\n"	>> $CONFIG
      ipmctl show -dimm 		>> $CONFIG
      printf "\n" 			>> $CONFIG
      printf "DCPMM BSR:\n"		>> $CONFIG
      ipmctl show -d bootstatus -dimm 	>> $CONFIG
      printf "\n" 			>> $CONFIG
      printf "DCPMM TOPOLOGY:\n"	>> $CONFIG
      ipmctl show -topology 		>> $CONFIG
      printf "\n" 			>> $CONFIG
      printf "DCPMM MEMORY RESOURCE:\n"	>> $CONFIG
      ipmctl show -memoryresources 	>> $CONFIG
      printf "\n" 			>> $CONFIG
      printf "DCPMM SYSTEM CAPABILITY:\n"	>> $CONFIG
      ipmctl show -system -capabilities >> $CONFIG
      printf "\n" 			>> $CONFIG
      printf "DCPMM GOAL:\n"		>> $CONFIG
      ipmctl show -goal 		>> $CONFIG
      printf "\n" 			>> $CONFIG
      printf "DCPMM REGION:\n"		>> $CONFIG
      ipmctl show -region 		>> $CONFIG
      printf "\n" 			>> $CONFIG
      printf "DCPMM NAMESPACE:\n"	>> $CONFIG
      ndctl list			>> $CONFIG
      printf "\n" 			>> $CONFIG
      printf "DCPMM PCD:\n"		>> $CONFIG
      ipmctl show -dimm -pcd		>> $CONFIG
          
      echo ""							>> $CONFIG
      echo "========================"	>> $CONFIG
      echo "========================"	>> $CONFIG
      echo " PROC MEMINFO"				>> $CONFIG
      echo "========================"	>> $CONFIG
     
      # Get meminfo
      cat /proc/meminfo > ./$DIR/meminfo.log
      cat /proc/meminfo >> $CONFIG

      echo ""							>> $CONFIG
      echo "========================"	>> $CONFIG
      echo "========================"	>> $CONFIG
      echo " DEV PMEM"					>> $CONFIG
      echo "========================"	>> $CONFIG

      # Get pmem device
      ls /dev/pmem* 	> ./$DIR/pmem.log
      lsblk		>> ./$DIR/pmem.log

      ls /dev/pmem* 					>> $CONFIG
      lsblk								>> $CONFIG


      echo ""							>> $CONFIG
      echo "========================"	>> $CONFIG
      echo "========================"	>> $CONFIG
      echo " DMI "							>> $CONFIG
      echo "========================"	>> $CONFIG
    
      # Get smbios
      dmidecode > ./$DIR/dmidecode.log
      dmidecode 						>> $CONFIG


      echo ""							>> $CONFIG
      echo "========================"	>> $CONFIG
      echo "========================"	>> $CONFIG
      echo " DMESG " 					>> $CONFIG
      echo "========================"	>> $CONFIG
      
      # Get e820/system map from dmesg
      dmesg > ./$DIR/dmesg.log
      dmesg 							>> $CONFIG
	  
	  
	  
      echo ""							>> $CONFIG
      echo "========================"	>> $CONFIG
      echo "========================"	>> $CONFIG
      echo ""							>> $CONFIG
     
      
      # Get SRAT/SLIT/NFIT/PCAT/HMAT/PMTT 
      cat /sys/firmware/acpi/tables/SRAT > $DIR/srat.aml  
      cat /sys/firmware/acpi/tables/SLIT > $DIR/slit.aml
      cat /sys/firmware/acpi/tables/HMAT > $DIR/hmat.aml
       
      cat /sys/firmware/acpi/tables/NFIT > $DIR/nfit.aml
      ipmctl show -system nfit >> $DIR/nfit.log

      cat /sys/firmware/acpi/tables/PCAT > $DIR/pcat.aml
      ipmctl show -system pcat >> $DIR/pcat.log

      cat /sys/firmware/acpi/tables/PMTT > $DIR/pmtt.aml     
      ipmctl show -system pmtt >> $DIR/pmtt.log
      
