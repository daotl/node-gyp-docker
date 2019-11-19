FROM node:lts-alpine
ARG BUILD_DATE
ARG CI_JOB_ID
ARG CI_PIPELINE_ID
ARG VERSION
ARG VCS_REF
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.name="node-gyp" \
      org.label-schema.version=${VERSION} \
      org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.description="node-gyp with toolchain on the NodeJS image" \
      org.label-schema.url="https://github.com/nodejs/node-gyp/" \
      org.label-schema.vcs-url="https://github.com/AndreySenov/node-gyp-docker/" \
      org.label-schema.vcs-ref=${VCS_REF} \
      ci_job_id=${CI_JOB_ID} \
      ci_pipeline_id=${CI_PIPELINE_ID}
ENV NODE_GYP_VERSION=${VERSION}
ENV HOME=/home/node
RUN apk add --no-cache python make g++ && \
    yarn global add node-gyp@${VERSION} && \
    yarn cache clean && \
    node-gyp help && \
    mkdir $HOME/.cache && \
    chown -R node:node $HOME
USER node
VOLUME $HOME/.cache
WORKDIR $HOME
CMD ["sh"]
