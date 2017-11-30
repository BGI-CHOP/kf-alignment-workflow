cwlVersion: v1.0
class: CommandLineTool
id: gatk4_applybqsr
requirements:
  - class: ShellCommandRequirement
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerPull: 'kfdrc/gatk:4.beta.1'
baseCommand: [/gatk-launch]
arguments:
  - position: 1
    shellQuote: false
    valueFrom: >-
      --javaOptions "-Xms3000m
      -XX:+PrintFlagsFinal
      -XX:+PrintGCTimeStamps
      -XX:+PrintGCDateStamps
      -XX:+PrintGCDetails
      -Xloggc:gc_log.log
      -XX:GCTimeLimit=50
      -XX:GCHeapFreeLimit=10"
      ApplyBQSR
      --createOutputBamMD5
      --addOutputSAMProgramRecord
      -R $(inputs.indexed_reference_fasta.path)
      -I $(inputs.input_bam.path)
      --useOriginalQualities
      -O $(inputs.input_bam.nameroot).bqsr.bam
      -bqsr $(inputs.bqsr_report.path)
      -SQQ 10 -SQQ 20 -SQQ 30
inputs:
  indexed_reference_fasta:
    type: File
    secondaryFiles: [^.dict, .fai]
  input_bam:
    type: File
  bqsr_report:
    type: File
  sequence_interval:
    type:
      type: array
      items: File
      inputBinding:
        prefix: '-L'
    inputBinding: 
      position: 1
outputs:
  recalibrated_bam:
    type: File
    outputBinding:
      glob: '*bam'
    secondaryFiles: [^.bai, .md5]
