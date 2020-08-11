FROM registry.access.redhat.com/ubi7/ubi-minimal
EXPOSE 7681

ENTRYPOINT ["/usr/bin/ttyd"]
CMD ["bash"]
WORKDIR /workspace
ENV KUBECONFIG=/workspace/kubeconfig

RUN touch /workspace/kubeconfig && chmod 664 /workspace/kubeconfig

RUN rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-$(rpm -E %rhel).noarch.rpm && \
      microdnf -y install gzip tar wget jq vim-enhanced nano git && \
      chmod 775 /workspace && \
      wget https://github.com/tsl0922/ttyd/releases/download/1.6.1/ttyd_linux.x86_64 -O /usr/bin/ttyd && \
      chmod 755 /usr/bin/ttyd && \
      microdnf clean all

RUN curl -sL -o /tmp/oc.tar.gz https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz && \
      tar -C /tmp -xf /tmp/oc.tar.gz --no-same-owner && \
      mv /tmp/oc /usr/local/bin && \
      chmod +x /usr/local/bin/oc && \
      rm /tmp/*

RUN curl -sL -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && \
      chmod +x /usr/local/bin/kubectl

RUN curl -sL -o /tmp/tkn.tar.gz https://mirror.openshift.com/pub/openshift-v4/clients/pipeline/0.9.0/tkn-linux-amd64-0.9.0.tar.gz && \
      tar -C /tmp -xf /tmp/tkn.tar.gz --no-same-owner && \
      mv /tmp/tkn /usr/local/bin && \
      chmod +x /usr/local/bin/tkn && \
      rm /tmp/*

RUN curl -sL -o /tmp/kamel.tar.gz https://mirror.openshift.com/pub/openshift-v4/clients/camel-k/latest/camel-k-client-1.0-linux-64bit.tar.gz && \
      tar -C /tmp -xf /tmp/kamel.tar.gz --no-same-owner && \
      mv /tmp/kamel /usr/local/bin && \
      chmod +x /usr/local/bin/kamel && \
      rm /tmp/*

RUN curl -sL -o /usr/local/bin/odo https://mirror.openshift.com/pub/openshift-v4/clients/odo/latest/odo-linux-amd64 && \
      chmod +x /usr/local/bin/odo

RUN curl -sL -o /tmp/kn.tar.gz https://mirror.openshift.com/pub/openshift-v4/clients/serverless/latest/kn-linux-amd64-0.13.2.tar.gz && \
      tar -C /tmp -xf /tmp/kn.tar.gz --no-same-owner && \
      mv /tmp/kn /usr/local/bin && \
      chmod +x /usr/local/bin/kn && \
      rm /tmp/*

RUN curl -sL -o /usr/local/bin/helm https://mirror.openshift.com/pub/openshift-v4/clients/helm/latest/helm-linux-amd64 && \
      chmod +x /usr/local/bin/helm

RUN curl -sL -o /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/3.3.2/yq_linux_amd64 && \
      chmod +x /usr/local/bin/yq

USER 1001

