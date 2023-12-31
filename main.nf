 #! /usr/bin/env nextflow
nextflow.enable.dsl=2

include {fastqc3} from './modules/fastqc3'

process r_dummy5{

  //Docker Image
  container ='prc992/pileups-report:v1.1'
  publishDir "$path_sample", mode : 'copy'

  input:
  tuple val(sampleId), val(path),path(read1), path(read2)
  path (chRDummy)

  exec:
  path_sample = path + "/" + sampleId + "/"

  output:
  path ('*.txt')

  script:
  """
  Rscript $chRDummy
  """
}

workflow {
    
    chSampleInfo = Channel.fromPath(params.samples_sheet) \
        | splitCsv(header:true) \
        | map { row-> tuple(row.sampleId,row.path, row.read1, row.read2) }

    chR_dummy = Channel.fromPath("${projectDir}/auxiliar_programs/dummy.R")
    fastqc3 (chSampleInfo)
    r_dummy5 (chSampleInfo,chR_dummy)
}
