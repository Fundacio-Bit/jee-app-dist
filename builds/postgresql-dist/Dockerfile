#
# Copyright 2019 gdeignacio.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#
# Pull base image
# ---------------

FROM postgres:9.5-alpine

# Maintainer
# ----------

LABEL MANTAINER="Guillermo De Ignacio <gdeignacio@gmail.com>"

# Environment variables required for this build (do NOT change)
# -------------------------------------------------------------

ENV PGTABLESPACES /var/lib/postgresql/data/tablespaces
# this 777 will be replaced by 700 at runtime (allows semi-arbitrary "--user" values)
#RUN mkdir -p "$PGTABLESPACES" && chown -R postgres:postgres "$PGTABLESPACES" && chmod 777 "$PGTABLESPACES"
#VOLUME $PGTABLESPACES

#ENV PGBACKUPS /app/postgres
# this 777 will be replaced by 700 at runtime (allows semi-arbitrary "--user" values)
#RUN mkdir -p "$PGBACKUPS" && chown -R postgres:postgres "$PGBACKUPS" && chmod 777 "$PGBACKUPS"
#VOLUME $PGBACKUPS

#ENV PGAPPTABLESPACES /var/lib/postgresql/app/tablespaces
# this 777 will be replaced by 700 at runtime (allows semi-arbitrary "--user" values)
#RUN mkdir -p "$PGAPPTABLESPACES" && chown -R postgres:postgres "$PGAPPTABLESPACES" && chmod 777 "$PGAPPTABLESPACES"
#VOLUME $PGAPPTABLESPACES



# Copy files needed during database creation
# -------------

COPY ./postgresql/bin/docker-entrypoint-initdb.d/00_initdb.sh /docker-entrypoint-initdb.d/
#COPY ./docker-entrypoint-initdb.d/scripts/ /docker-entrypoint-initdb.d/scripts/

# Define default entrypoint 

ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 5432
CMD ["postgres"]