#! /bin/bash
#SBATCH --export=ALL

#Determination of the variables that are required for the execution of this script

RESDIR=$1
INSDIR=$2
NUMREPINPUT=$3
NUMREPCHIP=$4
TF_EM=$5

#Beginning of the peak calling

echo ""
echo "===================="
echo "PROCESSING CALLPEAKS"
echo "===================="
echo ""

cd $RESDIR/../samples/input

#Depending on the type of the samples, whether they are transcriptional factor or epigenetic marks, different
#processes have to be followed.

if [ $NUMREPINPUT -gt 1 ] #for more than one input sample
then
	INPUTBAM=()
	for i in $(seq 1 $NUMREPINPUT)
	do
		INPUTBAM+=("input$i.bam")
	done
		samtools merge out.bam ${INPUTBAM[@]} #unification of all the input samples in an unique one
	
	if [ $TF_EM == "tf" ] #Data processing in case of transcription factors
	then	
		for i in $(seq 1 $NUMREPCHIP) #loop for doing the peaks calling, taking the unique input file as reference for the different chip samples files
		do
			macs2 callpeak -t ../chip/chip$i.bam -c out.bam -f BAM --outdir $RESDIR -n peaks$i
		done
		ext=$(echo "narrowPeak") #determination of a new variable that saves the extension for the finalpeak file in case of transcription factors
	elif [ $TF_EM == "em" ] #Data processing in case of epigenetic marks
	then
		for i in $(seq 1 $NUMREPCHIP) #loop for doing the peaks calling, taking the unique input file as reference for the different chip samples files
                do
                        macs2 callpeak -t ../chip/chip$i.bam -c out.bam --broad -f BAM --outdir $RESDIR -n peaks$i
                done
		ext=$(echo "broadPeak") #determination of a new variable that saves the extension for the finalpeak file in case of epigenetic marks
	fi	
else #for only one input sample
	if [ $TF_EM == "tf" ]
	then
		for i in $(seq 1 $NUMREPCHIP) #data processing for the peaks determination when there's only one input sample
		do
			macs2 callpeak -t ../chip/chip$i.bam -c input1.bam -f BAM --outdir $RESDIR -n peaks$i
		done
		ext=$(echo "narrowPeak") #determination of a new variable that saves the extension for the finalpeak file in case of transcription factors
	elif [ $TF_EM == "em" ]
	then
		for i in $(seq 1 $NUMREPCHIP) #data processing for the peaks determination when there's only one input sample
                do
                        macs2 callpeak -t ../chip/chip$i.bam -c input1.bam --broad -f BAM --outdir $RESDIR -n peaks$i
                done
		ext=$(echo "broadPeak") #determination of a new variable that saves the extension for the finalpeak file in case of epigenetic marks
	fi
fi


cd $RESDIR

if [ $NUMREPCHIP -gt 1 ] #peaks determination for more than one chip sample
then
       	for i in $(seq 2 $NUMREPCHIP)
       	do
		CHIPPEAK+=("peaks${i}_peaks."${ext})
	done
	#union of the different peaks files generated for each sample into only one file called finalpeak.${ext}, where the value of
	#ext can be narrowPeak or broadPeak depending on the type of data that we are processing
		bedtools intersect -a peaks1_peaks.${ext} -b ${CHIPPEAK[@]} > finalpeak.${ext}
else 
		mv peaks1_peaks.${ext} finalpeak.${ext} #data processing for determining peaks in an unique chip sample
fi



#Use of the command du -h * in order to check the size of all the files and that everything is correct

echo ""
echo "To be sure everything was correct:"
echo ""
du -h *

#Use of the tool HOMER for finding relevant DNA motifs related to the study
#It is important to distinguish between transcriptional factor or epigenetic marks to use the correct file with the final peaks

echo ""
echo "===================="
echo "FINDING MOTIFS-HOMER"
echo "===================="
echo ""

findMotifsGenome.pl finalpeak.${ext} ../genome/genome.fa . -size 200  



echo ""
echo "==========="
echo "HOMER DONE!"
echo "==========="
echo ""

#Data enrichment analysis using RStudio

echo ""
echo "================"
echo "RSCRIPT ANALYSIS"
echo "================"
echo ""


Rscript $INSDIR/pipe.R $RESDIR $INSDIR $TF_EM



