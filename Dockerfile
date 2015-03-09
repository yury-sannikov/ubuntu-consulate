FROM phusion/baseimage
MAINTAINER Yuriy Sannikov <yury.sannikov@gmail.com>

RUN apt-get -y update
RUN apt-get -y install unzip tar

# Install consul
ADD https://dl.bintray.com/mitchellh/consul/0.5.0_linux_amd64.zip /tmp/consul.zip
RUN cd /bin && unzip /tmp/consul.zip && chmod +x /bin/consul && rm /tmp/consul.zip

# Add consul config
ADD ./config /config/
ONBUILD ADD ./config /config/

# Add Consul agent as a service
ADD consulclient.sh /etc/service/consulagent/run
RUN chmod +x /etc/service/consulagent/run

# Install consul-template
# https://github.com/hashicorp/consul-template
ADD https://github.com/hashicorp/consul-template/releases/download/v0.7.0/consul-template_0.7.0_linux_amd64.tar.gz /tmp/consul-template.tar.gz
RUN cd /tmp && tar -xvzf /tmp/consul-template.tar.gz && mv /tmp/consul-template_0.7.0_linux_amd64/consul-template /bin/ && chmod +x /bin/consul-template && rm -rf /tmp/consul-template_0.7.0_linux_amd64

# Install envconsul
# https://github.com/hashicorp/envconsul
ADD https://github.com/hashicorp/envconsul/releases/download/v0.5.0/envconsul_0.5.0_linux_amd64.tar.gz /tmp/envconsul.tar.gz
RUN cd /tmp && tar -xvzf /tmp/envconsul.tar.gz && mv /tmp/envconsul_0.5.0_linux_amd64/envconsul /bin/ && chmod +x /bin/envconsul && rm -rf /tmp/envconsul_0.5.0_linux_amd64


# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*