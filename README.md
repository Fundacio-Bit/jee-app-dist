# emiserv-dist

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

### Installing


Clone this repository on your local machine

```bash
git clone https://github.com/Fundacio-Bit/emiserv-dist.git
```

## Setting environment values

---

1. Edit [10_app](./settings/10_app) file and set variables as shown

    ```bash
    # app section
    # See also:
    #
    # bin/compile
    # deploy/default/docker-compose.yaml
    #
    LONG_APP_NAME_UPPER=EMISERV
    LONG_APP_NAME_LOWER=emiserv
    LONG_APP_NAME_CAMEL=Emiserv
    SHORT_APP_NAME_UPPER=EMS
    SHORT_APP_NAME_LOWER=ems
    SHORT_APP_NAME_CAMEL=Ems
    # end app section
    ```

2. Edit [20_jdk](./settings/20_jdk) file. These values set default Java Home and installation target. **The environment scope is local to your script**

    ```bash
    # JDK Download section
    # Downloading java version lower than 9 is up to you
    JDK11_URL=https://download.java.net/java/ga/jdk11/openjdk-11_linux-x64_bin.tar.gz
    JDK11_TARGET=$HOME/java/${LONG_APP_NAME_LOWER}
    JDK11_TARFILE=openjdk-11_linux-x64_bin.tar.gz
    JDK_URL=$JDK11_URL
    JDK_TARGET=$JDK11_TARGET
    JDK_TARFILE=$JDK11_TARFILE
    # End JDK Download section

    # jdk section
    # set here previously installed jdk path  
    JDK8_HOME=/usr/lib/jvm/java-8-oracle
    JDK7_HOME=/usr/lib/jvm/jdk1.7.0_80
    OPENJDK11_HOME=$JDK11_TARGET/jdk-11
    JAVA_HOME=$OPENJDK11_HOME
    JDK_HOME=$JDK7_HOME
    # end jdk section
    ```

3. Edit [30_mvn](./settings/30_mvn) file. These values set default Maven Home and installation target according environment. **The environment scope is local to your script**

    ```bash
    # Maven Download section
    MAVEN_363_URL=https://ftp.cixug.es/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
    MAVEN_363_TARGET=$HOME/maven/${LONG_APP_NAME_LOWER}
    MAVEN_363_TARFILE=apache-maven-3.6.3-bin.tar.gz

    MAVEN_URL=$MAVEN_363_URL
    MAVEN_TARGET=$MAVEN_363_TARGET
    MAVEN_TARFILE=$MAVEN_363_TARFILE 

    # End Maven Download section

    # maven section
    M2_365_HOME=$MAVEN_363_TARGET/apache-maven-3.6.3
    M2_HOME=$M2_365_HOME
    # end maven section
    ```


4. Edit [40_jboss](./settings/40_jboss) file. These values set default Jboss EAP Home and installation target according environment. **The environment scope is local to your script**

    If jboss version < 7 should be manually installed. Othewise, keycloak uri arg must be set.

    ```bash
    # jboss section
    JBOSS_EAP_52_HOME=/usr/local/desarrollo/ServidoresJ2EE/jboss-eap-5.2/jboss-as
    JBOSS_EAP_52_DEPLOYDIR=$JBOSS_EAP_52_HOME/server/default/deploy$LONG_APP_NAME_LOWER
    JBOSS_HOME=$JBOSS_EAP_52_HOME
    JBOSS_DEPLOYDIR=$JBOSS_EAP_52_DEPLOYDIR
    # end jboss section

    # keycloak section
    KEYCLOAK_URI_ARG=http://keycloak-${LONG_APP_NAME_LOWER}:8180
    # end keycloak section
    ```


5. Edit [50_custom](./settings/50_custom) file.

    These values set custom to-deploy filenames, path updates, username for docker-compose args, and docker-compose.yaml file path. You can choose config depending on stage and services to enable. **The environment scope is local to your script**

    ```bash
    # Custom section 
    EAR_FILE=$PROJECT_PATH/src/$LONG_APP_NAME_LOWER/$LONG_APP_NAME_LOWER-ear/target/$LONG_APP_NAME_LOWER.ear

    # End custom section

    # path update section
    PATH=$JBOSS_HOME/bin:$JAVA_HOME/bin:$M2_HOME/bin:$PATH
    # end path update section

    # Docker-compose section
    CUSTOM_USERNAME=$LONG_APP_NAME_LOWER
    CUSTOM_USERID=1000
    DOCKER_COMPOSE_DEFAULT=${PROJECT_PATH}/deploy/default/docker-compose.yaml
    DOCKER_COMPOSE_DEV_PATH=${PROJECT_PATH}/deploy/dev/
    DOCKER_COMPOSE_PRE_PATH=${PROJECT_PATH}/deploy/pre/
    DOCKER_COMPOSE_PRO_PATH=${PROJECT_PATH}/deploy/pro/
    DOCKER_COMPOSE_PATH=$DOCKER_COMPOSE_DEV_PATH

    DOCKER_COMPOSE_FILE=$DOCKER_COMPOSE_DEFAULT
    # end docker-compose section
    ```

    **Actual values could be different than above once files in setting folder had been edited. Take these only as an example.**

6. Preconfigured values are stored in settings folder and can be used *as is* or modified at your discretion.
Although is possible to config any type of parameter, passwords should never be set there cause changes will be committed against repo.


## Run

---

1. Clone this repository on your local machine if you didn't yet. 

    ```bash
    git clone https://github.com/Fundacio-Bit/emiserv-dist.git
    ```

2. Run [installdocker](./bin/installdocker) script to update and install docker.

    ```bash
    ./bin/installdocker.sh
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

3. Check preconfigured values and change them as explained above if needed.


4. Run [setenv](./bin/setenv) script. It generates an .env file from settings folder content to be allocated in main folder. When loading env variables, this file will be used as input. Repeat steps 2 and 3 as times as you need.

    ```bash
    ./bin/setenv
    ```
    **Please remember run after edit settings. Otherwise, .env will remain unmodified.**

### Installing java tools

---

5. Optionally, run [installjdk](./bin/installjdk) script. It downloads a tar.gz file and inflates into preconfigured target. See ./settings/20_jdk file. If jdk version is lower than 9, jdk platform must be manually installed.

    ```bash
    ./bin/installjdk
    ```

6. Optionally, run [installmaven](./bin/installmaven) script. It downloads a tar.gz file and inflates into preconfigured target. See ./settings/30_mvn file. Running maven requires JAVA_HOME variable.
    
    ```bash
    ./bin/installmaven
    ```


## Docker settings





## docker-compose





## Run docker

---

1. Run [start](./bin/start) script. Runs docker-compose and starts containers configured in docker-compose.yaml

    ```bash
    ./bin/start
    ``` 

2. Run [cleanup](./bin/cleanup) script. Stops all running containers

    ```bash
    ./bin/cleanup
    ``` 

    Shortcut to [Getting started](#getting-started) if more detail is needed.

---

## Authors

* **gdeignacio**  - [gdeignacio-fundaciobit](https://github.com/gdeignacio-fundaciobit)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Acknowledgments

* https://github.com/GovernIB/docker-imatges
* https://github.com/docker-library/postgres
