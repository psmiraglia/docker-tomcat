#!/bin/bash

TEMPLATE="Dockerfile.template"
VERSIONS=( 7.0.77 8.0.43 8.5.13 )

for TOMCAT_VERSION in ${VERSIONS[@]}; do
    TOMCAT_MAJOR=`echo ${TOMCAT_VERSION} | cut -d. -f1`
    mkdir -p ${TOMCAT_MAJOR}/${TOMCAT_VERSION}
    sed \
        -e "s/%TOMCAT_MAJOR%/${TOMCAT_MAJOR}/g" \
        -e "s/%TOMCAT_VERSION%/${TOMCAT_VERSION}/g" \
        ${TEMPLATE} > ${TOMCAT_MAJOR}/${TOMCAT_VERSION}/Dockerfile
done

echo -e "default: ${VERSIONS[@]}\n" > Makefile
for TOMCAT_VERSION in ${VERSIONS[@]}; do
    TOMCAT_MAJOR=`echo ${TOMCAT_VERSION} | cut -d. -f1`
    echo "${TOMCAT_VERSION}:" >> Makefile
    echo -e "\tdocker build --tag psmiraglia/tomcat${TOMCAT_MAJOR}:${TOMCAT_VERSION} ${TOMCAT_MAJOR}/${TOMCAT_VERSION}\n" >> Makefile
done
