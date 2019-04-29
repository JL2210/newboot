#!/bin/sh

runcommand()
{
	echo ${@}
	${@}
}

runcommand rm -f *.o *.com *.a
