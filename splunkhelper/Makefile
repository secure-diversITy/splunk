BINFIX = /usr/local/bin
MANF = /etc/shelper.manifest
ERR = 0
USER = root
GROUP = root

LINKS = "shelperrestart \
		shelperwebrestart \
		shelperdebug \
		shelperstop \
		shelperstart \
		shelperstatus \
		shelpershcapply \
		shelpershcdeploy \
		shelpercmapply \
		shelpercmdeploy \
		shelperclustershow \
		shelperclustershowbundle \
		shelperclusterlistpeers \
		shelperdsreload \
		shelperreload \
		shelpershcshowstatus \
		shelpershclistcaptain \
		shelperexchange"

check:
		@echo "checking for manipulation ..."
		@if [ -f ${MANF} ]&&[ -f ${BINFIX}/shelper ];then \
		    md5sum -c ${MANF} ; ERR=$$? ; \
		    if [ $$ERR -ne 0 ];then \
			echo -e "ERROR: ${BINFIX}/shelper has been locally modified! aborted.\nIf you want to overwrite, remove ${MANF} manually and try again." ;\
			exit 4 ;\
		    else \
			echo "check passed: ${BINFIX}/shelper has not been modified" ;\
		    fi ;\
		fi

install:
		@install -o ${USER} -g ${GROUP} -m 0755 splunkhelper.in ${BINFIX}/shelper
		for L in "${LINKS}";do \
				ln -sfv ${BINFIX}/shelper ${BINFIX}/$$L ; \
		done
		sed -i "s#BINFIX#${BINFIX}#g" ${BINFIX}/shelper
		md5sum ${BINFIX}/shelper > ${MANF}

uninstall:
		rm -fv ${BINFIX}/shelper ${BINFIX}/splunk*
		for L in "${LINKS}";do rm -vf ${BINFIX}/$$L ; done

fulluninstall: uninstall
		rm -fv ${MANF}

update: check uninstall install
