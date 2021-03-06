# panda-envshell

当前最新版本 V3.8.1

这是一个快速安装web运行环境的程序集合

目前程序支持创建环境用户,相关目录创建,基本库的安装,nginx,php-fpm,mysql,bind等相关软件源码或编译文件的下载,以及对应的安装.并加入服务列表.

##文件及对应功能

文件名|功能
----|----
common.sh|引入配置文件和函数文件,并确保运行者是root
config.sh|顾名思义,配置文件
config_*.sh|根据配置模板和配置文件,生成应用对应的配置文件
download_*.sh|会英文的都懂,下载对应的tar包
functions.sh|相关的通用函数
install_*.sh|安装相关软件,其中mysql是bin文件安装,其余都是源码编译安装
install_lib.sh|安装基本库
logrotate_*.sh|配置日志切割工具
make_dir.sh|创建全局目录结构
mkdir_*.sh|创建应用需要的目录结构
service_*.sh|将应用添加到chkconfig列表中,支持service命令
test_cfg.sh|输出所有的配置
user_group.sh|创建环境用户和用户组
bin_conf|所有应用的配置文件模板,安装时会根据配置做响应的替换
shell|程序文件,包括添加服务列表需要的程序,以及一些批量处理的小工具
tar|下载的tar包存放在这里

当然了,相关的编译,安装及配置参数,都是根据自己的需求来做的,如果你有自己的需求,改改改

##使用过程介绍
- 所有命令基于CentOS6.*-x86_64版本,如果使用的是32位版本,请调整mysql的tar包下载路径.如果使用CentOS7,那就不要用这些程序了,自己重写吧╮(╯▽╰)╭
- 请使用root用户运行,且程序所在目录可写(用于下载tar包)
- 1.编辑config.sh,确认nginx(1.6.2),php(5.6.0),mysql(5.6.21),bind(9.10.2)的版本(括弧中是默认的版本号),如果没什么特别需求,就不要改了吧.另外文件中配置了相关的目录结构.
 - /data ``#应用根目录``
 - /data/bin ``#程序文件安装目录``
 - /data/logs ``#相关日志目录``
 - /data/app ``#web代码存放目录``
- 2.运行user_group.sh,创建环境用户和用户组,密码随意
- 3.运行make_dir.sh,创建全局目录结构
- 4.运行install_lib.sh安装相关扩展库
- 5.运行download_*.sh下载你所需要的tar包
- 6.运行mkdir_*.sh创建你所需要的应用的目录
- 7.运行install_*.sh安装你所需要的应用,安装程序会自动调用8,9的程序.8,9也可单独运行
- 8.运行config_*.sh配置你所需要的应用
- 9.运行service_*.sh把应用添加到chkconfig列表中
- 10.运行logrotate_*.sh配置对应应用的日志切割工具

到此你的环境应该安装差不多了,php基本是不需要配置的,nginx和bind有一个基本的配置,nginx可以支持多分支开发,测试及正式环境的部署,bind将对应的域名解析为本地.安装mysql时,会需要输入root的密码,这个不要忘记了.

注意:
- 修改配置文件的时候注意修改sshd和mysql的启动端口号
- 将自己的key上传至服务器对应的地方,因为sshd就不能用命令行登陆了

##关于作者

```php
date_default_timezone_set('Asia/Shanghai');

class me extends 码畜
{

    public $_sNickName = 'pandajingjing';

    public $_sWebSite = 'http://www.jxu.life';

    protected $_iQQ = 18073848;
}
```

##change log
- 20150808 V3.8.1
 - 1.调整里nginx中gzip的mimetype
- 20150709 V3.8
 - 1.修正了nginx中关于压缩js的一个配置问题
 - 2.加入了logrotate的nginx配置
- 20150702 V3.7.1
 - 1.增加了sshd的配置,快速修改成通过key登陆,并且阻止root和环境用户登陆
 - 2.增加了mysql的端口配置
 - 3.增加了bashrc的修改,对history的参数做了调整
 - 4.调整history目录到.history
- 20150616 V3.5.1
 - 1.调整了创建目录时候的相关逻辑
 - 2.修正了安装mysql时相对路径造成的一个bug
 - 3.整个程序结构基本就这么定了,以后就根据需要添加对应的*的部分程序了
- 20150615 V3.5
 - 1.重写了程序的结构
 - 2.将每个应用每个步骤的程序都单独了出来,方便直接运行
 - 3.增加了域名的配置
 - 4.修正了大部分的bug
- 20150611 V3.0
 - 1.重写了所有的程序
 - 2.增加了很多的可配置项
 - 3.又有新的想法了
- 20150604 V2.9
 - 1.加入BIND的安装支持
 - 2.打算重构了
- 20150603 V2.1
 - 1.将PHP版本从5.6.6调整为5.6.0
 - 2.创建目录时会创建php的日志目录
- 20150527 V2.0.1
 - 1.完善本文档 
- 20150526 V2.0
 - 1.添加了php-fpm的配置文件,配置为监听socket方式
 - 2.将nginx调用php-fp调整为socket方式
 - 3.取消pandajingjing.net域名的相关配置,仅跳转到jxu.life
 - 4.取消api域名的解析,增加service域名的解析
 - 5.添加chkconfig需要的程序,并可以通过命令将nginx,php,mysql服务化
- 20150415 V1.0.1
 - 1.修改了一下文档中的错别字啦
- 20150413 V1.0 
 - 1.写了这个文档,也算是初步的结构完成了,那就算1.0吧
 - 2.在创建日志目录的时候,顺带把nginx的子目录也创建了.nginx这丫不会自己创建日志目录
- 20150331 V0.9
 - 1.安装完nginx和php后导入相关站点配置,并检查配置,排除错误
 - 2.修改ignore文件,排除tar文件夹
 - 3.初始化所有项目文件
