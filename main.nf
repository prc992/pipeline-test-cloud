 #! /usr/bin/env nextflow
nextflow.enable.dsl=2

process fastqc2 {

  //Docker Image
  container = 'quay.io/biocontainers/fastqc:0.11.9--0'
  label 'process_single'

  publishDir "$path", mode : 'copy'

  input:
  tuple val(sampleId), val(path),path(read1), path(read2)

  output:
  path ('*.html')
  path ('*.zip')
  
  script:
  """
  fastqc $read1 $read2
  """
}

workflow {
    
    chSampleInfo = Channel.fromPath(params.samples_sheet) \
        | splitCsv(header:true) \
        | map { row-> tuple(row.sampleId,row.path, row.read1, row.read2) }

    fastqc2 (chSampleInfo)
}
