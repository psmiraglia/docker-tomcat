# docker-tomcat

Alpine based Docker images to run Apache Tomcat application server. They
extend [`openjdk:7-jre-alpine`][7-jre-alpine] or
[`openjdk:8-jre-alpine`][8-jre-alpine] according to Tomcat's major version.
Dockerfiles are generated with the script `update_dockerfiles.sh`. Supported
Tomcat versions are:

*   7.0.77
*   8.0.43
*   8.0.44
*   8.0.45
*   8.0.46
*   8.5.13

[7-jre-alpine]: https://github.com/docker-library/openjdk/tree/master/7-jre/alpine
[8-jre-alpine]: https://github.com/docker-library/openjdk/tree/master/8-jre/alpine

## Build Docker images

What's better than `make`?

    $ ./update_dockerfiles.sh (optional)
    $ make

## Use Docker image

You can create your own Docker image as follows.

    FROM psmiraglia/tomcat8:8.5.13

    # become root
    USER root

    # set timezone
    RUN apk add --no-cache --update tzdata && rm -fr /var/cache/apk/*
    ENV TZ=Europe/Rome

    # configure and deploy myapp
    COPY files/server.xml ${TOMCAT_HOME}/conf/server.xml
    COPY files/setenv.sh ${TOMCAT_HOME}/bin/setenv.sh
    COPY files/sample.war ${TOMCAT_HOME}/webapps/

    # update ownership
    RUN chown -R ${TOMCAT_USER}:${TOMCAT_GROUP} ${TOMCAT_HOME}

    # become tomcat
    USER ${TOMCAT_USER}

## References

*   [Docker](https://www.docker.com)
*   [Apache Tomcat](http://tomcat.apache.org)
*   [Alpine Linux](https://alpinelinux.org)
