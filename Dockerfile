
##################################################
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## Spark + Python 3
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##################################################

FROM continuumio/miniconda3
USER root

#-----------------------------------------------------
# Dev Tools
#-----------------------------------------------------
RUN apt-get -q update && apt-get install -y --no-install-recommends \
    curl   \
    git    \
    unzip  \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*


#-------------------------------------------------
#-- JAVA
#-------------------------------------------------
ENV JAVA_HOME=/opt/conda/pkgs/openjdk-8.0.121-1

RUN conda install --yes --quiet 'openjdk==8.0.121' \
 && conda clean -tipsy
 

#-------------------------------------------------
#-- SPARK
#-------------------------------------------------
ENV SPARK_VERSION=2.2.1 
ENV SPARK_PACKAGE=spark-${SPARK_VERSION}-bin-hadoop2.7 \
    SPARK_HOME=/usr/spark-${SPARK_VERSION}
ENV PATH=${PATH}:${SPARK_HOME}/bin

RUN curl -sL --retry 3 \
  "http://apache.rediris.es/spark/spark-${SPARK_VERSION}/${SPARK_PACKAGE}.tgz" \
  | gunzip \
  | tar x -C /usr/ \
 && mv /usr/${SPARK_PACKAGE} ${SPARK_HOME} \
 && chown -R root:root ${SPARK_HOME}

