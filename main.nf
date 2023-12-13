 #! /usr/bin/env nextflow
nextflow.enable.dsl=2

process fastqc {

  //Docker Image
  container = 'quay.io/biocontainers/fastqc:0.11.9--0'
  label 'process_single'

  publishDir "$params.path_sample_fastqc", mode : 'copy'

  input:
  path(read1)
  path(read2)

  output:
  path ('*.html')
  path ('*.zip')
  
  script:
  """
  fastqc $read1 $read2
  """
}

workflow {
    fastqc(params.read1,params.read2)
}
