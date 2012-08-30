#!/bin/bash

finalFile='fittinoNewObservables.txt'
tempFile1='fittinoNewObservables_temp1.txt'
tempFile2='fittinoNewObservables_temp2.txt'

### Delete previous files ###

if [ -e "$finalFile" ]
    then
    rm $finalFile
fi
if [ -e "$tempFile1" ]
    then
    rm $tempFile1
fi
if [ -e "$tempFile2" ]
    then
    rm $tempFile2
fi


### Isolate the interesting lines of the input file ###

grep LEObs $1 > $tempFile1
echo -ne "LEObs  " >> $tempFile1
grep massTop $1 | grep -v fitParameter | cut -d"#" -f 1 >> $tempFile1

### Replace some characters to make life easier ###
sed -i s/GeV/\ /g $tempFile1
sed -i s/\(/\ /g $tempFile1
sed -i s/\)/\ /g $tempFile1
sed -i s/alias/X/g $tempFile1
sed -i 's/</ /g' $tempFile1
sed -i 's/+-/ /g' $tempFile1

### Loop over lines ###

### Isolate the measurement ###
while read line
do
part=`echo $line | cut -d"X" -f 1`
echo $part >> $tempFile2 
done < $tempFile1

### Combine the uncertainties ###
while read line
  do
  if [ -n "$line" ]
      then
      pre=`echo $line | cut -d" " -f 1`
      if [ $pre == "LEObs" ] 
	  then 
	  name=`echo $line | cut -d" " -f 2`
	  val=`echo $line | cut -d" " -f 3`
	  unc1=`echo $line | cut -d" " -f 4`
	  unc2=`echo $line | cut -d" " -f 5`
	  unc3=`echo $line | cut -d" " -f 6`
	  #echo $line	  
	  #echo "name: " $name " val: " $val " unc1: " $unc1 " unc2: " $unc2 " unc3: " $unc3
	  if [ -z "$unc2" ]
	      then
	      unc2=-1
	  fi
	  if [ -z "$unc3" ]
	      then
	      unc3=-1
	  fi
	  echo $name $val $unc1 $unc2 $unc3 >> $finalFile    
      fi
  fi
done < $tempFile2

#LEObs Bsg_npf 3.55E-4 +- 0.24E-4 +- 0.09E-4 +- 0.46E-4

#rm $tempFile1 
#rm $tempFile2