#!/bin/sh

force=false
test x"$1" = x-f && force=true

L=$HOME/log/sv
R=${XDG_RUNTIME_DIR:-/run/user/`id -u`}/runit
S=$HOME/etc/sv

for d in `ls $S`; do
	test -d $S/$d || continue
	test -h $S/$d && continue

	grep -Fqx 'exec 2>&1' $S/$d/run || sed -i -e '1 a \' -e 'exec 2>&1' $S/$d/run

	$force && rm -fr $S/$d/log

	test -x $S/$d/log/run && continue

	mkdir -p $S/$d/log
	(
		echo "#!/bin/sh"
		echo "mkdir -p $L/$d"
		echo "exec svlogd -ttt $L/$d"
	) >$S/$d/log/run
	chmod 755 $S/$d/log/run
	ln -s $R/supervise.$d.log $S/$d/log/supervise

	echo Added logging to $d 1>&2
done
