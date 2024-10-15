#filtering vcf - pipeline for inbred diploid species - WBDC
#requires vcftools v0.1.16 - https://github.com/vcftools/vcftools 
#and bcftools https://samtools.github.io/bcftools/bcftools.html

#first convert heterozygote calls to missing- use github.com/bspan07/filter-vcf/convert_hets_to_missing_vcf.sh
#use vcftools to filter missing data
nohetsvcf="/path/to/no-hets-vcf/"
outputvcf_nomissing="/path/to/no-missing/"
vcftools --vcf $nohetsvcf --max-missing 0.9 --recode > $outputvcf_nomissing  
#use vcftools to filter for minor allele frequency, average min read depth and bi-allelic sites - in this case 3% threshold and minimum average read depth of 10 for a site
outputvcf_maf="/path/to/filtered-maf-mindp-vcf/"
vcftools --vcf $outputvcf_nomissing --maf 0.03 --min-meanDP 10 --min-alleles 2 --max-alleles 2 --recode > $outputvcf_maf
#filter by LD - sliding window of 5 sites, LD=0.2
bcf="/path/to/filtered-LD-bcf/"
bcftools +prune -l 0.2 -w 5 $outputvcf_maf -Ob -o $bcf
bcftools view $bcf > $vcf
#count number of SNPs
vcf="/path/to/vcf"
bcftools stats $vcf > vcf_statistics.txt
