FROM rawmind/alpine-jvm8:1.8.181-1
MAINTAINER RichieMay <meibo@sefon.com>

# Set environment
ENV SERVICE_HOME=/opt/storm \
    SERVICE_NAME=storm \
    SERVICE_VERSION=1.1.2 \
    SERVICE_USER=storm \
    SERVICE_UID=10003 \
    SERVICE_GROUP=storm \
    SERVICE_GID=10003 \
    SERVICE_VOLUME=/opt/tools \
    SERVICE_URL=http://apache.mirrors.spacedump.net/storm 
ENV SERVICE_RELEASE=apache-storm-"$SERVICE_VERSION" \
    SERVICE_CONF=${SERVICE_HOME}/conf/storm.yaml \
    PATH=$PATH:${SERVICE_HOME}/bin

# Install and configure storm
RUN curl -sS -k ${SERVICE_URL}/${SERVICE_RELEASE}/${SERVICE_RELEASE}.tar.gz | gunzip -c - | tar -xf - -C /opt \
  && mv /opt/${SERVICE_RELEASE} ${SERVICE_HOME} \
  && rm ${SERVICE_CONF} \
  && mkdir ${SERVICE_HOME}/data ${SERVICE_HOME}/logs \
  && addgroup -g ${SERVICE_GID} ${SERVICE_GROUP} \
  && adduser -g "${SERVICE_NAME} user" -D -h ${SERVICE_HOME} -G ${SERVICE_GROUP} -s /sbin/nologin -u ${SERVICE_UID} ${SERVICE_USER} 

ADD root /
RUN chmod +x ${SERVICE_HOME}/bin/* \
  && chown -R ${SERVICE_USER}:${SERVICE_GROUP} ${SERVICE_HOME} /opt/monit


USER $SERVICE_USER
WORKDIR $SERVICE_HOME

