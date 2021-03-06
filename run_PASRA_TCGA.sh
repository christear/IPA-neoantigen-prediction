#!/bin/bash
current_path=$1
cancer_type=$3
bam_path=$4
path=$5
mkdir -p "${path}"/"${cancer_type}"
cd ${path}/"${cancer_type}"
list="$1/TCGA_${cancer_type}.list"

for line in $(tac ${list}); do
	if [ ! -f "${path}/${cancer_type}/${line}.unsorted.bam_out_PAS_sites_from_softclipping_based_on_S.txt" ]; then
		N=24
        	if (( i % N == 0 )); then
                	wait
        	fi
	        ((i++))
		(perl ${current_path}/detect_from_soft_cliping_with_bam_file_polyT_beginning_based_on_S.pl ${bam_path}/${line}.unsorted.bam ${line}.unsorted.bam
	        perl ${current_path}/detect_from_soft_cliping_with_bam_file_polyA_end_based_on_S.pl ${bam_path}/${line}.unsorted.bam ${line}.unsorted.bam ) &
	fi
done
