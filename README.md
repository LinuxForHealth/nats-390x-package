# nats-390x-package
Builds a NATS Server Package for the s390x Architecture Using [nfpm]

## Dependencies

nats-390x-package has the following dependencies:

- [bash](https://www.gnu.org/software/bash/) 5.x or higher for build scripting
- [curl](https://curl.se/) to download NATS releases
- [go](https://go.dev/) to build NATS from source
- [nfpm](https://github.com/goreleaser/nfpm) to create the debian package

## Quickstart - The Easy Way

Browse the project's [releases](https://github.com/LinuxForHealth/nats-390x-package/releases) and download a package.

## Quickstart - Build From Scratch

If you need to customize the build process or build from scratch you will need to work with `build.sh` and `nfpm.yml`, 
the nfpm configuration file, directly.

### build.sh
Run `build.sh` to create a package for nats-server v2.8.4.

```shell
user@MBP nats-390x-package % ./build.sh
***********************************
building nats release https://github.com/nats-io/nats-server/archive/refs/tags/v2.8.4.tar.gz
***********************************
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
100 1445k    0 1445k    0     0  1979k      0 --:--:-- --:--:-- --:--:-- 9169k
/Users/user/code/lfh/nats-390x-package
Building NATS version v2.8.4
/Users/user/code/lfh/nats-390x-package
NATS build complete.
nats-server is located in build/release/nats-server
Creating deb package file
using deb packager...
created package: build/release/nats-server_2.8.4.01_s390x.deb
```

`build.sh` is designed to download a "source tarball" from the [nats-server github repo](https://github.com/nats-io/nats-server/releases)
The script is hard-coded to what is, as of now, the current nats-server release, version 2.8.4. To specify a different
release, invoke build.sh with the `-n` or `--nats-release` option

```shell
./build.sh --nats-release https://github.com/nats-io/nats-server/archive/refs/tags/v2.8.2.tar.gz
```

### nfpm configuration
To modify the debian package, please refer to the [nfpm configuration docs](https://nfpm.goreleaser.com/configuration/).

