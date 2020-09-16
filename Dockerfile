# vim:ft=Dockerfile :
FROM alpine:edge

# Define basic CLI
ENV SOFTWARE_DOWNLOAD_TIMEOUT=${SOFTWARE_DOWNLOAD_TIMEOUT:-300}
ENV SOFTWARE_DOWNLOAD_RETRIES=${SOFTWARE_DOWNLOAD_RETRIES:-5}
ENV SOFTWARE_DOWNLOAD_RETRIES_DELAY=${SOFTWARE_DOWNLOAD_RETRIES_DELAY:-10}
ENV SOFTWARE_DOWNLOAD_CMD="curl --connect-timeout ${SOFTWARE_DOWNLOAD_TIMEOUT} --retry ${SOFTWARE_DOWNLOAD_RETRIES} --retry-delay ${SOFTWARE_DOWNLOAD_RETRIES_DELAY} --silent --insecure --location"
ENV APK_UPGRADE_CMD="apk update && apk upgrade"
ENV APK_INSTALL_CMD="apk --update add"
ENV APK_REMOVE_CMD="apk del"
ENV APK_CACHE_RM="rm -rf /var/cache/apk/* && rm -rf /tmp/*.apk && rm -rf /tmp/*.tar*"

ENV NOTVISIBLE "in users profile"

# Define labels
LABEL architecture="amd64" \
	vendor=stonevil \
	com.stonevil.os="alpine" \
	com.stonevil.os.version="edge"

COPY . /root/.Files/

VOLUME ["/root/.Files"]
WORKDIR /root/.Files

RUN /root/.Files/install.sh

CMD ["/bin/bash -c","while true; do sleep 30; done;"]
