#!/bin/sh

runcommand()
{
	echo ${@}
	${@}
}

runcommand rm -f *.com *.a
runcommand rm -rf obj/
