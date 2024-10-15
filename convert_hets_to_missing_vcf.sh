#convert all heterozygote calls to missing in inbred diploid or haploid species
#define variables- heterozygote and missing calls in vcf
het_one="0/1"
het_two="1/0"
het_missing="./."

#count heterozygote calls - outputs to text file
vcf="/path/to/vcf"
grep -e "0/1" -e "1/0" $WBDCvcf | wc -l > number_heterozygote_calls.txt

#convert hets to missing
missinghets="/path/to/vcf-with-hets-converted-to-missing/"
sed "s|$het_one|$het_missing|g" $vcf > hets-missing-1.vcf
sed "s|$het_two|$het_missing|g" hets-missing-1.vcf > $missinghets
