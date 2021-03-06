#!/bin/sh

function chk_root(){
	if [ $UID -ne 0 ] ; then
		warn 'You should run as root!!!'
		exit
	fi
}

function test_cfg(){
	for n in $CFG_VAR
	do
		eval i=\$$n
        	echo $n: $i
	done
}

function msg(){
	echo `date +"%Y-%m-%d %H:%M:%S"`\($1\): $2
}

function info(){
	msg info "$1"
}

function warn(){
	msg warn "$1"
}

function make_dir(){
	info "make dir:$1 start."
		if [ -d $1 ]; then
			warn "dir:$1 already exists."
			if [[ '' != $2 ]]; then
				warn 'clear '$1
				rm -rf $1
				mkdir $1
			fi
		else
			mkdir $1
		fi
		chown $ENV_USER:$ENV_GROUP $1 -R
		chmod 0755 $1 -R
	info "make dir:$1 success."
}

function download_bincode(){
	info "download $1 start."
		if [ ! -d $EXEC_DIR_BINCODE ]; then
			info 'create '$EXEC_DIR_BINCODE' .'
			mkdir $EXEC_DIR_BINCODE
		else
			warn $EXEC_DIR_BINCODE' is exists.'
		fi
		wget -P $EXEC_DIR_BINCODE -c $1 
	info "download $1 success."
}

function unzip_bincode(){
	if [ -d $EXEC_DIR_BINCODE/$1 ]; then
		warn 'clear '$EXEC_DIR_BINCODE/$1
		rm -rf $EXEC_DIR_BINCODE/$1
	fi
	info 'unzip bincode: '$1.tar.gz' start.'
		tar -zxf $EXEC_DIR_BINCODE/$1.tar.gz -C $EXEC_DIR_BINCODE
	info 'unzip bincode: '$1.tar.gz' success.'
}

function install_check(){
	if [ ! -d $INSTALL_DIR_BIN ]; then
                warn 'create '$INSTALL_DIR_BIN' first. you should run mkdir_.sh first.'
                exit
        fi
	if [ -d $INSTALL_DIR_BIN/$1 ]; then
		warn 'clear '$INSTALL_DIR_BIN/$1
                rm -rf $INSTALL_DIR_BIN/$1
        fi
}

function configure_bin(){
	info 'configure '$2' start.'
	rm $2 -rf
	cp $1 $2 -rf
	for n in $BIN_VAR
	do
        	eval o=\$$n
        	script='s#{{'$n'}}#'$o'#g'
        	sed -i $script $2
	done
	info 'configure '$2' success.'
}
