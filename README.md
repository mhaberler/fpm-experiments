[![Build Status](https://jenkins.stiwoll.mah.priv.at/job/fpm-freight-test/badge/icon)](https://jenkins.stiwoll.mah.priv.at/job/fpm-freight-test/)

# fpm-experiments
idiot-proof debian packaging with fpm, so the right thing for me


# install fpm 

see https://github.com/jordansissel/fpm

    apt-get install ruby-dev gcc make
    gem install fpm

inspiration from: https://github.com/jordansissel/fpm/wiki/PackageSimpleFiles

# build test package
see the Makefile - to build a simple deb: 

  `make package`

the debian version is set via 'git rev-list --count --first-parent HEAD' which derives
an increasing serial from git history, so the `0.5` seen below will vary

# inspect results

````
$ dpkg -c socfpga-rbf_0.5_all.deb
drwx------ 0/0               0 2016-04-14 11:28 ./
drwxr-xr-x 0/0               0 2016-04-14 11:28 ./usr/
drwxr-xr-x 0/0               0 2016-04-14 11:28 ./usr/share/
drwxr-xr-x 0/0               0 2016-04-14 11:28 ./usr/share/doc/
drwxr-xr-x 0/0               0 2016-04-14 11:28 ./usr/share/doc/socfpga-rbf/
-rw-r--r-- 0/0             139 2016-04-14 11:28 ./usr/share/doc/socfpga-rbf/changelog.gz
drwxr-xr-x 0/0               0 2016-04-14 11:28 ./lib/
drwxr-xr-x 0/0               0 2016-04-14 11:28 ./lib/firmware/
drwxr-xr-x 0/0               0 2016-04-14 11:28 ./lib/firmware/socfpga/
-rw-r--r-- 0/0         1514668 2016-04-10 02:26 ./lib/firmware/socfpga/soc_system.rbf
````

# extract contents for inspection

extract a .deb under foo:
````
mah@jessie64:~/src/fpm-experiments$ dpkg -x socfpga-rbf_0.5_all.deb foo
mah@jessie64:~/src/fpm-experiments$ find foo
foo
foo/usr
foo/usr/share
foo/usr/share/doc
foo/usr/share/doc/socfpga-rbf
foo/usr/share/doc/socfpga-rbf/changelog.gz
foo/lib
foo/lib/firmware
foo/lib/firmware/socfpga
foo/lib/firmware/socfpga/soc_system.rbf
````




