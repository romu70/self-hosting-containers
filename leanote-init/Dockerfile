FROM mongo:3.4.10
MAINTAINER R. Tisserand <r@tisserand.eu>

ENV MONGO_PORT 27017
ENV LEANOTE_COLLECTION leanote
ENV USER leanote

ENV MONGO_HOST host
ENV USER_PWD password

RUN apt-get update \
    && apt-get install -y subversion \
    && svn export https://github.com/leanote/leanote/trunk/mongodb_backup/leanote_install_data/ /leanote_data

CMD mongorestore -h $MONGO_HOST --port $MONGO_PORT -d $LEANOTE_COLLECTION -u $USER -p $USER_PWD --dir /leanote_data
