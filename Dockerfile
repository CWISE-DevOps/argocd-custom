FROM quay.io/argoproj/argocd:v2.8.2
USER root
RUN apt-get update && \
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    apt-get install curl apt-transport-https ca-certificates gnupg -y && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && \
    apt-get update && apt-get install google-cloud-sdk -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER argocd
ARG GCS_PLUGIN_VERSION="0.4.2"
ARG GCS_PLUGIN_REPO="https://github.com/hayorov/helm-gcs.git"
RUN helm plugin install ${GCS_PLUGIN_REPO} --version ${GCS_PLUGIN_VERSION}
ENV HELM_PLUGINS="/home/argocd/.local/share/helm/plugins/"
