# Ansible

An ansible playbook for setting up a new Cosmos seed node.

## Prerequisites

- [Python3](https://realpython.com/installing-python)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

_Ideally ansible should be installed via [pip](https://pip.pypa.io/en/stable/), the package installer for python._

## Assumptions

This README assumes that you've already installed `debian` or `ubuntu` onto the target environment/s.

## Ansible 

### Setup

1. Install the required git submodule dependencies:

```console
git submodule update --init
```

2. Install the ansible `community.general` collection:

```console
ansible-galaxy collection install community.general
```

3. Rename the `hosts.example` file in `inventory/` to `hosts`:

```console
cp inventory/hosts.example inventory/hosts
```

4. Edit the file `inventory/hosts` and add the IP addresses of your seed node/s.

## Seed 

### Setup

To setup a new seed node:

```console
PASSWORD='<password>' \
DD_API_KEY=<dd_api_key> \
PROVIDER=<provider> \
TARGET=<target> \
make setup
```

where:

| Param          | Description                                                                                            | Required |
|----------------|--------------------------------------------------------------------------------------------------------|----------|
| `<password>`   | The password for the default user that gets created.                                                   | `true`   |
| `<dd_api_key>` | The DataDog API key.                                                                                   | `false`  |
| `<provider>`   | The provider being used (`mevspace`, or `ovhcloud`).                                                   | `false`  |
| `<target>`     | The IP address of the host to run the playbook against (all hosts will be configured if not provided). | `false`  |

e.g.:

```console
PASSWORD='theFuture!' \
DD_API_KEY=0gD04PXCnLk0CYNHdamJ7lylKs5uMZkJ \
PROVIDER=ovhcloud \
TARGET=1.2.3.4 \
make setup
```

This will provision the host in question with all the necessary packages. To then launch a seed, see the documentation below.

### Launch

The seed servers run as containers on the host you configured above.

To launch a seed for a given chain:

```console
PORT=<port> \ 
CHAIN_ID=<chain_id> \
SEEDS='<seeds>' \
TARGET=<target> \
make launch
```

where:

| Param        | Description                                                                                            | Required |
|--------------|--------------------------------------------------------------------------------------------------------|----------|
| `<port>`     | The port to expose on the host.                                                                        | `true`   |
| `<chain_id>` | The chain to setup (e.g.: `cosmoshub-4`).                                                              | `true`   |
| `<seeds>`    | A list of existing seeds/peers on the network to poll.                                                 | `false`  |
| `<target>`   | The IP address of the host to run the playbook against (all hosts will be configured if not provided). | `false`  |

e.g.:

```console
PORT=2000 \
CHAIN_ID=cosmoshub-4 \
SEEDS='bf8328b66dceb4987e5cd94430af66045e59899f@public-seed.cosmos.vitwit.com:26656' \
TARGET=1.2.3.4 \
make launch
```
