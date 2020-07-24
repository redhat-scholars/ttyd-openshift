# TTYD for OpenShift

This is a RHEL ubi7-minimal-based build of TTYD focused on OpenShift
Container Platform.

It is roughly inspired by [Ian Lawson's gotty
terminal](https://github.com/utherp0/workshop4/blob/master/images/terminal/Dockerfile).

It is using [ttyd](https://github.com/tsl0922/ttyd) as the core terminal,
which itself uses [xterm.js](https://github.com/xtermjs/xterm.js).

It includes the basic OpenShift clients and `jq` for manipulating JSON
objects. If you have a use case that needs additional software, you can
easily use this image as your base and add it. For example, doing something
that requires Quarkus? You probably want to install that, and perhaps Maven,
or something else.

Ruby? Sure, why not.

## Usage

* Run it locally with `podman` or `docker` or your favorite OCI runtime:
    
        podman run -p 7681:7681 -it quay.io/redhat-scholars/ttyd-openshift:latest

* Deploy it in OpenShift using `new-app` or the developer console

* Probably other ways! It's just a container image.
