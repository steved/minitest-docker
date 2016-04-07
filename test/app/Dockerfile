FROM alpine:3.3

EXPOSE 22

RUN apk --update add openssh s6

ADD service /service
ADD ssh/id_rsa.pub /tmp/id_rsa.pub

RUN mkdir /root/.ssh && cat /tmp/id_rsa.pub >> /root/.ssh/authorized_keys && rm /tmp/id_rsa.pub

CMD ["s6-svscan", "/service"]
