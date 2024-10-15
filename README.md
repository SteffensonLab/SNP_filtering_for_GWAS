# Filtering a variant call file in preparation for GWAS
Commands used to filter the original variant call file in the WBDC whole-genome sequencing project to yield a robust and computationally manageable set up of single nucleotide polymorphisms for genome-wide association mapping using GAPIT.
Heterozygote calls were first converted to homozygote calls (since is inbred diploid) by replacing 0/1 and 1/0 genotype calls with ./. using a simple sed stream editor script (convert_hets_to_missing_vcf.sh).
Next filtered the vcf (filter-vcf.sh) to retain bi-allelic sites with <10% missing data, >3% minor allele frequency and a mean minimum read depth of 10. The vcf was further filtered for linkage disquilibrium by scanning every 5 SNP sites and removing sites where r2>0.2.
