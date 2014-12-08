mongo_agent_merge_bam
=====================

[MongoAgent](https://github.com/dmlond/mongo_agent) that uses
samtools to merge the subset bam files into a single bam file
for the raw_file specified in the original alignment_agent parent.

See the [mongo_agent_alignment](https://github.com/dmlond/mongo_agent_alignment)
documentation for more details.

input task: {
  agent_name: 'merge_bam_agent',
  parent_id: 'id of the alignment_agent task that this is working on',
  build: 'dirname of build directory in /home/bwa_user/bwa_indexed',
  reference: 'filename of fasta file indexed in /home/bwa_user/bwa_indexed/build',
  raw_file: 'filename of fastq file in /home/bwa_user/data',
  subset_bams: 'array of subset bam files that have been created by one or more
                align_subset_agents',
  ready: true
}
