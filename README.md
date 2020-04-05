# trac-on-docker

Dockerfile for Trac

# How to use

## initialize and launch for the first time 

```bash
#
# please change admin password at least in Makefile.
#
sed -i -e 's|PLEASE_CHANGE_BEFORE_INIT|TracAdminPassword|g' Makefile

#
# build container image.
#
make

#
# (first time) initialize and run Trac.
#
make init
```

open http://localhost:8080/ and login with admin account.

## launch a container.

```bash
#
# run container.
#
make run
```

## launch a shell in the container for debugging.

```bash
#
# exec shell
#
make shell
```

## add user authentication info.

```bash
make shell
/bin/ash add_htdigest.sh new_username trac-project_name new_password >> /trac/.htdigest
exit
```

## change user password

```bash
make shell
/bin/ash chg_htdigest.sh /trac/.htdigest username trac-project_name new_password
exit
```

# Memo.

ちょっと事情があって 十年ぶりくらいに Tracを使う必要があったので  
最新の 1.4.1(今年の2月にリリースになってました) を コンテナ化してみました。

Python 2.7系なので Alpine使おうとすると ちょっと面倒臭いですね。
