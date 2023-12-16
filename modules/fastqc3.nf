process fastqc3 {

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
