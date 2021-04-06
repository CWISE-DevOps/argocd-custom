FROM argoproj/argocd:v1.8.7

USER root
RUN apt-get update && \
    apt-get install -y \
        curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER argocd

ARG GCS_PLUGIN_VERSION="0.3.9"
ARG GCS_PLUGIN_REPO="https://github.com/hayorov/helm-gcs.git"
RUN helm plugin install ${GCS_PLUGIN_REPO} --version ${GCS_PLUGIN_VERSION}
ENV HELM_PLUGINS="/home/argocd/.local/share/helm/plugins/"
