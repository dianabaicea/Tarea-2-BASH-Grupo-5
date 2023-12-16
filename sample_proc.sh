#! /bin/bash
#SBATCH --export=ALL

#Determination of the variables that are required for executing this script.

SAMPLEDIR=$1
i=$2
INSDIR=$3
WD=$4
EXP=$5
NUMREPINPUT=$6
NUMREPCHIP=$7
NUMREP=$((NUMREPINPUT+NUMREPCHIP))
TF_EM=$8

# Start of the sample processing.

echo ""
echo "=========================="
echo "PROCESSING SAMPLE $i"
echo "=========================="
echo ""

#Quality analysis of the sample.
cd $SAMPLEDIR

fastqc $i.fq.gz 

#Mapping of shorts reads to the reference genome and creation of a binary index (.bam).

bowtie2 -x ../../genome/index -U $i.fq.gz -S $i.sam
samtools sort -o $i.bam $i.sam
rm $i.sam
samtools index $i.bam

#Saving the route of the processed sample in order to check when all the samples are ready to continue the analysis,
# so the next script can be executed.  

echo ${SAMPLEDIR}/$i >> ../../results/replicas_list.txt

NUMPROC=$(wc -l ../../results/replicas_list.txt | awk '{print($1)}' )

echo ""
echo "===================="
echo "SAMPLE $i DONE"
echo "===================="
echo "" 


if [ $NUMPROC -eq $NUMREP ]
then 
	echo "All samples processed"
	cd ../..
	sbatch --job-name=peaks --output=peaks_out.txt --error=peaks_err.txt  $INSDIR/callpeaks.sh $WD/$EXP/results $INSDIR $NUMREPINPUT $NUMREPCHIP $TF_EM
fi 

