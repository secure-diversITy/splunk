BINFIX = /usr/local/bin
MANF = /etc/shelper.manifest
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

install:
		if [ ${MANF} ]&&[ -f ${BINFIX}/shelper ];then
		    md5sum -c ${MANF} || echo "ERROR: ${BINFIX}/shelper has been locally modified! aborted." && exit 9
		fi
		@install -o ${USER} -g ${GROUP} -m 0755 splunkhelper.in ${BINFIX}/shelper
		for L in "${LINKS}";do \
				ln -sfv ${BINFIX}/shelper ${BINFIX}/$$L ; \
		done
		sed -i "s#BINFIX#${BINFIX}#g" ${BINFIX}/shelper
		md5sum ${BINFIX}/shelper > ${MANF}

uninstall:
		rm -fv ${BINFIX}/shelper ${BINFIX}/splunk* ${MANF}
		for L in "${LINKS}";do rm -vf ${BINFIX}/$$L ; done

update: install
