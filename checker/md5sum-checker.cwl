#!/usr/bin/env cwl-runner

class: CommandLineTool
id: Md5sumWorkflowChecker
label: A tool that checks the md5sum workflow
cwlVersion: v1.0

requirements:
- class: DockerRequirement
  dockerPull: quay.io/dockstore-testing/md5sum-checker:1.0.0
- class: InlineJavascriptRequirement

hints:
- class: ResourceRequirement
  # The command really requires very little resources.
  coresMin: 1
  ramMin: 1024
  outdirMin: 512000

inputs:
  input_file:
    type: File
    inputBinding:
      position: 1
      prefix: --input-file
    doc: The file that contains an md5sum.
  expected_md5:
    type: string
    inputBinding:
      position: 2
      prefix: --md5


outputs:
  results_file:
    type: File
    outputBinding:
      glob: results.json
    doc: A json file that contains the result of the test.

  log_file:
    type: File
    outputBinding:
      glob: log.txt
    doc: A text log file that contains more details.

baseCommand: [/bin/check_md5sum]
