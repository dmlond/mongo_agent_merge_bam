# build this into a mongo_agent:candidate
# and then build mongo_agent_base
# docker build -t mongo_agent:candidate .
# docker build -t dmlond/mongo_agent_merge_bam
FROM dmlond/bwa_samtools_base
MAINTAINER Darin London <darin.london@duke.edu>

USER root
RUN ["/usr/bin/yum", "install", "-y", "--nogpgcheck", "libyaml", "libyaml-devel", "tar", "make", "gcc", "readline", "readline-devel", "openssl","openssl-devel","libxml2-devel","libxslt","libxslt-devel"]
ADD install_ruby.sh /root/install_ruby.sh
RUN ["chmod", "u+x", "/root/install_ruby.sh"]
RUN ["/root/install_ruby.sh"]
RUN ["/usr/local/bin/gem", "install", "moped"]
RUN ["/usr/local/bin/gem", "install", "mongo_agent"]
ADD merge_bam_agent.rb /usr/local/bin/merge_bam_agent.rb
RUN ["chmod", "777", "/usr/local/bin/merge_bam_agent.rb"]
USER bwa_user
WORKDIR /home/bwa_user
CMD ["/user/local/bin/merge_bam_agent.rb"]
