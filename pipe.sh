#! /bin/bash 

#Determination of the variables that are needed for executing this script.

PARAMS=$1

echo ""
echo "=================="
echo "LOADING PARAMETERS"
echo "=================="
echo ""

#Establishment of parameters' routes used in the analysis.

WD=$(grep working_directory $PARAMS | awk '{print($2)}')
echo "Working directory: $WD"

INSDIR=$(grep installation_directory $PARAMS | awk '{print($2)}')
echo "Installation directory: $INSDIR"

EXP=$(grep experiment_name $PARAMS | awk '{print($2)}')
echo "Experiment name: $EXP"

GENOME=$(grep path_genome $PARAMS | awk '{print($2)}')
echo "Genome path: $GENOME"

ANNOT=$(grep path_annotation $PARAMS | awk '{print($2)}')
echo "Annotation path: $ANNOT"

NUMREPCHIP=$(grep number_chip $PARAMS | awk '{print($2)}')
echo "Number of chip replicas: $NUMREPCHIP"

NUMREPINPUT=$(grep number_input $PARAMS | awk '{print($2)}')
echo "Number of input replicas: $NUMREPINPUT"

TF_EM=$(grep tf_em $PARAMS | awk '{print($2)}')
echo "Transcription factor or epigenetic marks: $TF_EM"

if [ $TF_EM != "tf" ] && [ $TF_EM != "em" ]
then
	echo "ERROR!!: Please, check the params file (params.txt). tf_em must be <tf> or <em>."
	exit 2
fi

for i in $(seq 1 $NUMREPINPUT)
do
	INPUT[$i]=$(grep path_input_${i} $PARAMS | awk '{print($2)}')
        echo "Input$i path: ${INPUT[$i]}"

done

for i in $(seq 1 $NUMREPCHIP)
do
	CHIP[$i]=$(grep path_chip_${i} $PARAMS | awk '{print($2)}')
	echo "Chip$i path: ${CHIP[$i]}"

done

#Creation of the study's workspace.

echo ""
echo "=================="
echo "CREATING WORKSPACE"
echo "=================="
echo ""

#Creation of the different folders.

cd $WD
mkdir $EXP
cd $EXP
mkdir genome annotation results scripts samples
cd samples
mkdir input chip

#Each file is moved into its corresponding folder.

cd ..
cp $GENOME genome/genome.fa
cp $ANNOT annotation/annotation.gtf

for i in $(seq 1 $NUMREPINPUT)
do
	cp ${INPUT[$i]} samples/input/input$i.fq.gz
done 

for i in $(seq 1 $NUMREPCHIP)
do
	cp ${CHIP[$i]} samples/chip/chip$i.fq.gz
done

#Generation of an index for the analysis.

echo ""
echo "=============="
echo "BUILDING INDEX"
echo "=============="
echo ""

cd genome
bowtie2-build genome.fa index

echo ""
echo "To be sure everything was correct:" 
echo "" 
du -h * 


echo ""
echo "============="
echo "INDEX CREATED"
echo "============="
echo ""

cd ..

# Execution of the sample processing scripts depending on the type: whether it is a chip sample or an input sample. 

for i in $(seq 1 $NUMREPINPUT)
do 
	sbatch --job-name=proc_input$i --output=input$i.txt --error=err_input$i.txt $INSDIR/sample_proc.sh $WD/$EXP/samples/input input$i $INSDIR $WD $EXP $NUMREPINPUT $NUMREPCHIP $TF_EM
done

for i in $(seq 1 $NUMREPCHIP)
do
	sbatch --job-name=proc_chip$i --output=chip$i.txt --error=err_chip$i.txt $INSDIR/sample_proc.sh $WD/$EXP/samples/chip chip$i $INSDIR $WD $EXP $NUMREPINPUT $NUMREPCHIP $TF_EM
done



