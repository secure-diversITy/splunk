BINFIX = /usr/local/bin
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
		@install -o ${USER} -g ${GROUP} -m 0755 splunkhelper.in ${BINFIX}/shelper
		for L in "${LINKS}";do \
				ln -sfv ${BINFIX}/shelper ${BINFIX}/$$L ; \
		done

uninstall:
		rm -fv ${BINFIX}/shelper ${BINFIX}/splunk*
		for L in "${LINKS}";do rm -vf ${BINFIX}/$$L ; done

update: install
