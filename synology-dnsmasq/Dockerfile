FROM registry.access.redhat.com/rhel7:latest

RUN ln -f -s /usr/share/zoneinfo/America/New_York /etc/localtime && \
    yum clean all && \
    yum -y --disablerepo="*" \
      --enablerepo=rhel-7-server-rpms \
      install vim-enhanced dnsmasq bind-utils iputils iproute && \
    yum clean all && rm -rvf /var/cache/yum

VOLUME ["/etc/dnsmasq.d"]
VOLUME ["/var/lib/tftpboot"]
RUN ln -s /var/lib/tftpboot /tftpboot

EXPOSE 53/tcp 53/udp 67/udp 69/udp
ENV TERM=xterm-256color
CMD ["/usr/sbin/dnsmasq", "-k"]
