#!/bin/sh

source ./common.sh

info 'make php directroy start.'
	$EXEC_DIR_BASE/make_dir.sh
	make_dir $LOG_DIR_PHP 1
	make_dir $INSTALL_DIR_PHP 1
info 'make php directory success.'
