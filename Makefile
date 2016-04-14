

# extracting info from git:

# construct name from 'nearest' tag -  a tag MUST exist
# git-describe - Show the most recent tag that is reachable from a commit

# mah@next:~/src/u-boot$ git describe
# v2016.03-1-ge3c66fe
#

#GIT_DESCRIBE=$(shell git describe HEAD)

# mah@next:~/src/u-boot$
# mah@next:~/src/u-boot$ git rev-list --count --first-parent HEAD
# 14194

GIT_VERSION=$(shell git rev-list --count --first-parent HEAD)
$(info GIT_VERSION=$(GIT_VERSION))

PKG_VERSION=0.$(GIT_VERSION)
$(info PKG_VERSION=$(PKG_VERSION))

NAME=socfpga-rbf
INSTALLDIR=/lib/firmware/socfpga
RBF=soc_system.rbf
SITE=http://static.mah.priv.at/jenkins/testdir/quartus/

MAINTAINER=git@mah.priv.at
ARCHITECTURE=all
LICENSE='GNU General Public License (GPL), version 2.0 or later'
# can be met, does exist
#PRE_DEPENDS=--deb-pre-dependsgcc
# cannot be met, 4.99 does not exist
#PRE_DEPENDS=--deb-pre-depends 'gcc > 4:4.99'

FPM_OPTS= \
	--maintainer $(MAINTAINER) \
	$(PRE_DEPENDS) \
	--verbose \
	--license $(LICENSE) \
	--architecture $(ARCHITECTURE) \
	--before-install preinstall.sh \
	--after-install  postinstall.sh \
	--before-remove preremove.sh \
	--after-remove postremove.sh \
	--before-upgrade preupgrade.sh \
	--after-upgrade postupgrade.sh \


all: clean package

.PHONY: package
package:
	rm -f $(RBF)
	wget $(SITE)/$(RBF)
	fpm $(FPM_OPTS) -s dir -t deb -n $(NAME) -v $(PKG_VERSION) --prefix $(INSTALLDIR) $(RBF)


clean:
	rm -f *.deb
