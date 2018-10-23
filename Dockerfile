ARG ELASTIC_VERSION=6.2.4 
ARG LOGTRAIL_VERSION=0.1.27 
FROM docker.elastic.co/kibana/kibana-oss:${ELASTIC_VERSION} 
ARG ELASTIC_VERSION 
ARG LOGTRAIL_VERSION 
RUN set -x \
    && kibana-plugin install https://github.com/sivasamyk/logtrail/releases/download/v${LOGTRAIL_VERSION}/logtrail-${ELASTIC_VERSION}-${LOGTRAIL_VERSION}.zip

COPY logtrail.json plugins/logtrail/logtrail.json
