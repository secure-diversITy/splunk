BINFIX = /usr/local/bin
USER = root
GROUP = root

LINKS = "splunkrestart \
		splunkwebrestart \
		splunkdebug \
		splunkstop \
		splunkstart \
		splunkstatus \
		splunkshcapply \
		splunkshcdeploy \
		splunkcmapply \
		splunkcmdeploy \
		splunkclustershow \
		splunkclustershowbundle \
		splunkclusterlistpeers \
		splunkdsreload \
		splunkexchange"

install:
		@install -o ${USER} -g ${GROUP} -m 0755 splunkhelper.in ${BINFIX}/splunk
		for L in "${LINKS}";do \
				ln -sfv ${BINFIX}/splunk ${BINFIX}/$$L ; \
		done

uninstall:
		rm -fv ${BINFIX}/splunk
		for L in "${LINKS}";do rm -vf ${BINFIX}/$$L ; done

update: install
