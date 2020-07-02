FROM ubi7-minimal
EXPOSE 7681

ENTRYPOINT ["/usr/bin/ttyd"]
CMD ["bash"]
WORKDIR /workspace

RUN rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-$(rpm -E %rhel).noarch.rpm && \
      microdnf -y install gzip tar wget jq vim-enhanced nano tmux git && \
      chmod 775 /workspace && \
      wget https://github.com/tsl0922/ttyd/releases/download/1.6.1/ttyd_linux.x86_64 -O /usr/bin/ttyd && \
      chmod 755 /usr/bin/ttyd && \
      microdnf clean

RUN curl -sL -o /tmp/oc.tar.gz https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz && \
tar -C /tmp -xf /tmp/oc.tar.gz --no-same-owner && \
mv /tmp/oc /usr/local/bin && \
chmod +x /usr/local/bin/oc && \
rm /tmp/*

RUN curl -sL -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && \
chmod +x /usr/local/bin/kubectl

RUN curl -sL -o /tmp/tkn.tar.gz https://github.com/tektoncd/cli/releases/download/v0.9.0/tkn_0.9.0_Linux_x86_64.tar.gz && \
tar -C /tmp -xf /tmp/tkn.tar.gz --no-same-owner && \
mv /tmp/tkn /usr/local/bin && \
chmod +x /usr/local/bin/tkn && \
rm /tmp/*

RUN curl -sL -o /tmp/kamel.tar.gz https://github.com/apache/camel-k/releases/download/1.0.0-RC2/camel-k-client-1.0.0-RC2-linux-64bit.tar.gz && \
tar -C /tmp -xf /tmp/kamel.tar.gz --no-same-owner && \
mv /tmp/kamel /usr/local/bin && \
chmod +x /usr/local/bin/kamel && \
rm /tmp/*

RUN curl -sL -o /usr/local/bin/odo https://mirror.openshift.com/pub/openshift-v4/clients/odo/latest/odo-linux-amd64 && \
chmod +x /usr/local/bin/odo

RUN curl -sL -o /usr/local/bin/kn https://storage.googleapis.com/knative-nightly/client/latest/kn-linux-amd64 && \
chmod +x /usr/local/bin/kn


USER 1001

