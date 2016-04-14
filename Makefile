NAME=socfpga-rbf
VERSION=0.1

INSTALLDIR=/lib/firmware/socfpga
RBF=soc_system.rbf
SITE=http://static.mah.priv.at/jenkins/testdir/quartus/

FPM_OPTS= \
	--verbose \
	--license 'GNU General Public License (GPL), version 2.0 or later' \
	--architecture all

.PHONY: package
package:
	wget $(SITE)/$(RBF)
	fpm $(FPM_OPTS) -s dir -t deb -n $(NAME) -v $(VERSION) --prefix $(INSTALLDIR) $(RBF)


clean:
	rm -f *.deb
