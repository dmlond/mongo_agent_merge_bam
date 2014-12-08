#!/usr/local/bin/ruby

require 'mongo_agent'
agent = MongoAgent::Agent.new({name: 'merge_bam_agent', queue: ENV['QUEUE']})
agent.work! { |task|
  #task = { build, reference, raw_file, subset_bams, parent_id, agent_name: merge_bam_agent, ready:true }
  response = false

  begin
    subset_bam_files = task[:subset_bams].collect { |subset_bam|
      subset_bam_file = File.join('/home/bwa_user/data', subset_bam)
      unless File.exists?(subset_bam_file)
        raise "#{ subset_bam_file } does not exist!"
      end
      subset_bam_file
    }
    final_bam = "#{ task[:raw_file] }.bam"
    final_bam_file = ['/home/bwa_user', 'data', final_bam].join('/')
    merge_command = "samtools merge #{ final_bam_file } #{ subset_bam_files.join(' ') }"
    $stderr.puts "RUNNING #{ merge_command }"
    `#{ merge_command }`

    unless File.exists?(final_bam_file)
      raise "#{ final_bam_file } does not exist!?"
    end
    files_produced = [{
      name: final_bam,
      sha1: `sha1sum #{ final_bam_file }`.split(' ')[0]
    }]
    response = [true, { files: files_produced }]
  rescue Exception => error
    response = [false, {error_message: error.message}]
  end
  response
}
