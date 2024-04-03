
samples = [ 
	"test",
	"test2",
	"test3"
]


rule all:
    input: expand("{sample}/{sample}_Aligned.sortedByCoord.out.bam", sample=samples)


rule star:
	message: "aligning"
	input: 
		fastq = "{sample}/{sample}_trimmed.fq.gz",
	output: "{sample}/{sample}_Aligned.sortedByCoord.out.bam"
	shell: 
		"""
		/uufs/chpc.utah.edu/common/home/hcibcore/atlatl/app/STAR/2.7.2c/STAR --runThreadN 24 --readFilesCommand zcat --genomeDir /uufs/chpc.utah.edu/common/home/hcibcore/atlatl/data/Mouse/GRCm38/release98/star50/ --readFilesIn {input.fastq} --outFilterMultimapNmax 50 --winAnchorMultimapNmax 100 --outFilterMismatchNoverLmax 0.05 --outSAMtype BAM SortedByCoordinate --outFileNamePrefix {wildcards.sample}/{wildcards.sample}_
		"""	

rule trim:
	message: "trimming"
	input: "{sample}.fastq.gz"
	output: "{sample}/{sample}_trimmed.fq.gz"
	shell: 
		"""
		module load trim_galore
		trim_galore --fastqc {input} --output_dir {wildcards.sample}
		"""
