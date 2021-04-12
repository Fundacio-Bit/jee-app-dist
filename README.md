# jee-app-dist
Env settings and command line tools for jee building and deployment. Openjdk &amp; maven.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

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

## Settings

1. Set environment values

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

2. Run [setenv.sh](./bin/setenv.sh) script

    ```bash
    ./bin/installdocker.sh
    ```


## Deployment

1. Clone this repository on your local machine

    ```bash
    git clone https://github.com/Fundacio-Bit/emiserv-dist.git
    ```

2. Run [installdocker.sh](./bin/installdocker.sh) script

    ```bash
    ./bin/installdocker.sh
    ```



## Authors

* **gdeignacio**  - [gdeignacio](https://github.com/gdeignacio)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* https://github.com/GovernIB/docker-imatges
* https://github.com/docker-library/postgres
