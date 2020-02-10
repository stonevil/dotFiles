# vim:ft=Dockerfile :
FROM alpine:edge


ADD * /root/.Files/

RUN ~/.Files/install.sh

CMD ["while :; do echo 'Hit CTRL+C'; sleep 1; done"]
