#!/bin/sh

JAVA_EXE='java -Xms512M -Xmx1G -XX:+UseConcMarkSweepGC -jar spigot.jar';

cd "$( dirname "$0" )"
if test ${MINECRAFT_EULA} != 'false'; then
	echo "eula=${MINECRAFT_EULA}" > eula.txt;
	$JAVA_EXE;
else
	$JAVA_EXE;
	echo "";
	echo "";
	echo "From eula.txt:";
	cat eula.txt;
	echo "";
	echo "!!";
	echo "!! Include -e MINECRAFT_EULA=TRUE with your docker run command if you agree.";
	echo "!!";
fi
