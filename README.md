# jee-app-dist

Env settings and command line tools for jee building and deployment. Openjdk &amp; maven.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

Shortcut to [Run Docker](#run-docker) if environment is already set.

### Prerequisites

---

* Ubuntu, Debian or CentOS operating system
* A user account with sudo privileges
* Command-line/terminal (CTRL-ALT-T or Applications menu > Accessories > Terminal)
* Docker software repositories (optional)

The specific steps to installing Docker will differ depending on the host's operating system. Full instructions can be found on [Docker's installation documentation](https://docs.docker.com/install/overview/)

* Also, you may try [Docker Desktop](https://www.docker.com/products/docker-desktop) on Windows/Mac. See [docs](https://docs.docker.com/desktop/)
* In any case, you can locally build your app with Maven using an isolated local repo. 


### Installing
---

Clone this repository on your local machine.

```bash
git clone https://github.com/Fundacio-Bit/jee-app-dist.git
```

Forking this repository for specific purpose app is recommended

## Setting environment values
---

Environment values are preconfigured. See ./settings.template.d folder.

### Generate local settings values from template
---

1. Execute [bin/app_settings.sh](./bin/app_settings.sh) script to create settings folder and .template files will be copied into. If a previous version exists will be backed up.

    ```bash
    bin/app_settings.sh
    ```

2. Optionally execute [bin/app_clearenvbackup.sh](./bin/app_clearenvbackup.sh) to clean previous .backup files in settings folder.

     ```bash
    bin/app_clearenvbackup.sh
    ```

3. Set app name by executing [bin/app_setappname.sh] (bin/app_setappname.sh). Set parameters codapp and app to long application name and short application name respectively.

    ```bash
    bin/app_setappname.sh --codapp=long-application-name --app=shortapplicationname
    ```
    Repeat this step every time app_settings have been executed. Otherwise app name will take default values.

### Update .env settings values
---

Once you have updated local files

1. Execute [bin/app_setenv.sh](./bin/app_setenv.sh) to create an .env file and values configured in settings folder will take effect.
    
    ```bash
    bin/app_setenv.sh
    ```


2. You don't need to execute bin/lib_xxx_utils.sh by yourself. These scripts are sourced from others for read and export values from .env file, and should be updated with care. Sourced scripts are
    * [bin/lib_env_utils.sh](bin/lib_env_utils.sh)
    * [bin/lib_string_utils.sh](bin/lib_string_utils.sh)


### Settings files contents in detail
---

* Values in ${some_value} format are previously configured.
* All vars in a file have a distinctive prefix except 200_jdk, 300_mvn, 400_jboss files.

1. Edit [./settings/100_app](./settings.template.d/100_app.template) file and check variable values as shown

    ```bash
    LONG_APP_NAME=long-app-name
    SHORT_APP_NAME=short-app-name
    ```

2. Edit [./settings/110_nginx](./settings.template.d/110_nginx.template) for reverse proxy config. It contains all NGINX_xxx vars.

    ```bash
    # nginx section

    NGINX_DOMAIN_NAME=your.domain
    NGINX_SERVER_NAME=${LONG_APP_NAME_LOWER}
    NGINX_SERVER_HTTP_PORT=80
    NGINX_SERVER_HTTPS_PORT=443
    NGINX_SERVER=${NGINX_SERVER_NAME}.${NGINX_DOMAIN_NAME}

    NGINX_CONF_PATH=${PROJECT_PATH}/builds/nginx-dist/nginx/conf
    NGINX_DEFAULT_CONF=default.conf

    # end of nginx section
    ```


3. Edit [./settings/200_jdk](./settings.template.d/200_jdk.template) file. These values set default Java Home and installation target. **The environment scope is local to your script**

    By default, JDK version is 11. See [./settings.template.d/200_jdk.template](./settings.template.d/200_jdk.template) to find some examples of other versions downloading. Also, default target is located at HOME dir.

    ```bash
    JDK11_TARGET=$HOME/java/${LONG_APP_NAME_LOWER}
    ```
    See [bin/jdk_jdkinstall.sh](bin/jdk_jdkinstall.sh) for jdk installation.
    Shortcut to [Installing Java Tools](#installing-java-tools) if more detail is needed.


4. Edit [./settings/300_mvn](./settings.template.d/300_mvn.template) file. These values set default Maven Home and installation target according environment. **The environment scope is local to your script**

    By default, maven version is 3.6.3. See [./settings.template.d/300_mvn.template](./settings.template.d/300_mvn.template) to find some examples of other versions downloading. Also, default target is located at HOME dir.

    ```bash
    MAVEN_363_TARGET=$HOME/maven/${LONG_APP_NAME_LOWER}
    ```
    See [bin/mvn_maveninstall.sh](bin/mvn_maveninstall.sh) for maven installation.
    Shortcut to [Installing Java Tools](#installing-java-tools) if more detail is needed.


5. Edit [./settings/400_jboss](./settings.template.d/400_jboss.template) file. These values set default Jboss EAP Home and installation target according environment. **The environment scope is local to your script**

    If jboss version < 7 should be manually installed. Othewise, keycloak uri arg must be set.
    By default, jboss environment is Wildfly/Keycloak
    Shortcut to [Build and deploy](#build-and-deploy) if more detail is needed.

6. Edit [./settings/410_keycloak](./settings.template.d/410_keycloak.template) file. These values set default keycloak url and port. **The environment scope is local to your script**

    ```bash
    # keycloak section

    KEYCLOAK_PORT=8180
    KEYCLOAK_SERVER=${NGINX_SERVER}:${KEYCLOAK_PORT}
    KEYCLOAK_LOCAL_SERVER=keycloak-${LONG_APP_NAME_LOWER}

    # Set KEYCLOAK_SERVER to your IP if needed
    # and KEYCLOAK_URI_ARG to http://${KEYCLOAK_SERVER}:${KEYCLOAK_PORT}

    KEYCLOAK_URI_ARG=http://${KEYCLOAK_SERVER}

    KEYCLOAK_CONF_PATH=${PROJECT_PATH}/builds/keycloak-dist/keycloak/conf
    KEYCLOAK_IMPORT_REALM_JSON=${LONG_APP_NAME_LOWER}-import-goib-realm.json

    # end keycloak section
    ```

    Shortcut to [Build and deploy](#build-and-deploy) if more detail is needed.

7. Edit [./settings/500_docker](./settings.template.d/500_docker.template) file. These values set default docker-compose.yaml file and docker username. **The environment scope is local to your script**

    By default, a pod is composed by postgres + wildfly + keycloak + nginx. See [./settings.template.d/500_docker.template](./settings.template.d/500_docker.template). Also, default username is lowercase app name.

    ```bash
    DOCKER_CUSTOM_USERNAME=${LONG_APP_NAME_LOWER}
    DOCKER_CUSTOM_USERID=1000
    ```
    Shortcut to [Docker Settings](#docker-settings) if more detail is needed.

8. Edit [./settings/600_postgres](./settings.template.d/600_postgres.template) file. **The environment scope is local to your script**

    PostgreSQL is the default database, then environment vars use PG_ prefix. If other db is chosen this prefix can vary e.g. ORA_ , *etc.*

    You may set values for other databases in separate files e.g. ./settings.template.d/610_oracle.template, ./settings.template.d/620_mysql.template

    ```bash
    # Postgres section
    # Use this file for custom postgres settings

    PG_PORT=5441

    PG_DUMP_TARGET=/app/postgresql/backups
    PG_95_PATH=/usr/lib/postgresql/9.5/bin
    PG_PATH=$PG_95_PATH

    PG_DUMP_DBNAME=${LONG_APP_NAME_LOWER}
    PG_DUMP_SCHEMA=${LONG_APP_NAME_LOWER}
    PG_DUMP_NAME=${LONG_APP_NAME_LOWER}
    PG_DUMP_HOSTNAME=localhost
    PG_DUMP_PORT=5441
    PG_DUMP_FILENAME=${PG_DUMP_TARGET}/${LONG_APP_NAME_LOWER}.tar

    # End postgres section
    ```
    Shortcut to [Database backup and restore](#database-backup-and-restore) if more detail is needed.



9. Edit [./settings/900_custom](./settings.template.d/900_custom.template) file.

    These values set any custom value not previously included in other files, like PATH **The environment scope is local to your script**

    ```bash
    # Custom section
    # Use this file for custom app settings

    # End custom section

    # path update section
    PATH=$JBOSS_HOME/bin:$JAVA_HOME/bin:$M2_HOME/bin:$PATH
    # end path update section
    ```

    **Actual values could be different than above once files in setting folder had been edited. Take these only as an example.**

10. Preconfigured values are stored in settings folder and can be used *as is* or locally modified at your discretion
Although is possible to config any type of parameter, passwords should never be set at settings.template.d folder. *All changes will be committed against repo*. Always set critical data at settings local folder and set permission if needed.

## Build and deploy
---

To build and deploy a jee project with Maven.


1. Clone app repository at ${PROJECT_PATH}/.. by executing

   ```bash
   cd ..
   git clone app-repository-url
   ```
   App folder should be at same directory than jee-app-dist

2. Execute [test_setup](./test/test_setup.sh) to check if all values are right

   ```bash
   test/test_setup.sh
   ```

3. Generate from template local versions of config files.
    
    * JBoss EAP 5.1/5.2 using sar file

        * source/\${LONG_APP_NAME_LOWER}/sar/src/main/resources/\${LONG_APP_NAME_LOWER}.properties

        Generated from template by executing previously

        ```bash
        source/${LONG_APP_NAME_LOWER}/sar/etc/bin/setproperties.sh
        ```
    * JBoss 7/Wildfly properties files

        * \${LONG_APP_NAME_LOWER}.properties
        * \${LONG_APP_NAME_LOWER}.system.properties

    * \${LONG_APP_NAME_LOWER}-ds.xml as datasource

    Execute [deploysetup](./bin/jboss_deploysetup.sh)

    ```bash
    bin/jboss_deploysetup.sh
    ```

4. Generate local config for [keycloak](./bin/keycloak_deploysetup.sh)

    ```bash
    bin/keycloak_deploysetup.sh
    ```

5. Edit files in folders **(local changes will not be committed)**
   * builds/wildfly-dist/wildfly/bin
   * builds/wildfly-dist/wildfly/conf
   * builds/wildfly-dist/wildfly/deploy

6. Build project

    ```bash
    bin/mvn_compile.sh
    ```
    or build and copy files in deployment folder. If deployments folder needs root permission, then remove it first.
    JBoss deploy dir is set by default at /tmp/\${LONG_APP_NAME_LOWER}/deployments.

    ```bash
    bin/mvn_jboss_deploy.sh
    ```

## Run

---

1. Clone this repository on your local machine if you didn't yet. 

    ```bash
    git clone https://github.com/Fundacio-Bit/jee-app-dist.git
    ```

2. Run [docker_install](./bin/docker_install.sh) script to update and install docker.

    ```bash
    ./bin/docker_install.sh
    ```
    Note that we add a new user which default password is "docker" and would better update it, even in preproduction stage.

    ```bash
    sudo useradd -p $(openssl passwd -1 docker) docker -g docker
    ```

    ```
    -p, --password PASSWORD
        The encrypted password, as returned by crypt(3). The default is to disable the password.
        Note: This option is not recommended because the password (or encrypted password) will be visible by users listing the processes.
        You should make sure the password respects the system's password policy. 
    ```

    See [docker_install](./bin/docker_install.sh)

3. Check preconfigured values and change them as explained above if needed.


4. Run [app_setenv](./bin/app_setenv.sh) script. It generates an .env file from settings folder content to be allocated in main folder. When loading env variables, this file will be used as input. Repeat steps 2 and 3 as times as you need.

    ```bash
    ./bin/app.setenv.sh
    ```
    **Please remember run after edit settings. Otherwise, .env will remain unmodified.**

### Installing java tools

---

1. Optionally, run [jdkinstall](./bin/jdk_jdkinstall.sh) script. It downloads a tar.gz file and inflates into preconfigured target. See ./settings/200_jdk file. If jdk version is lower than 9, jdk platform must be manually installed.

    ```bash
    ./bin/jdk_jdkinstall.sh
    ```

2. Optionally, run [maveninstall](./bin/mvn_maveninstall.sh) script. It downloads a tar.gz file and inflates into preconfigured target. See ./settings/300_mvn file. Running maven requires JAVA_HOME variable.
    
    ```bash
    ./bin/mvn_maveninstall.sh
    ```


## Docker settings

\#TO-DO

## docker-compose

\#TO-DO

## Run docker

---

1. Run [docker_start](./bin/docker_start.sh) script. Runs docker-compose and starts containers configured in docker-compose.yaml

    ```bash
    # Execute bin/app_setenv.sh previously
    ./bin/docker_start.sh
    ``` 

2. Run [cleanup](./bin/docker_cleanup.sh) script. Stops all running containers

    ```bash
    ./bin/docker_cleanup.sh
    ``` 

    Shortcut to [Getting started](#getting-started) if more detail is needed.


## Database backup and restore

Export and import database using pg_dump/pg_restore

Using local PostgreSQL installation as a client. See [client backup](./bin/pg_bdclientbackup.sh) and [client restore](./bin/pg_bdclientrestore.sh) files. 

```bash
# Local Folder /app/postgresql/backups
# Backup
bin/pg_bdclientbackup.sh

# Restore
bin/pg_bdclientrestore.sh
```

Using containers. See [container backup](./bin/pg_bdcontainerbackup.sh) and [container restore](./bin/pg_bdcontainerrestore.sh) files. 

```bash
# Local Folder /app/docker/postgresql/${LONG_APP_NAME_LOWER}/backups
# Backup
bin/pg_bdcontainerbackup.sh

# Restore
bin/pg_bdcontainerrestore.sh
```



---
## Authors

* **gdeignacio**  - [gdeignacio-fundaciobit](https://github.com/gdeignacio-fundaciobit)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Acknowledgments

* https://github.com/GovernIB/docker-imatges
* https://github.com/docker-library/postgres
