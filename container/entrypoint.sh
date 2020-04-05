#!/bin/ash
set -e

if [ "$1" = 'init' ]; then

    mkdir -p $TRAC_DATA

    # initialize trac
    trac-admin $TRAC_DATA initenv $PROJECT_NAME $DB_LINK
    trac-admin $TRAC_DATA deploy /tmp/deploy
    mv /tmp/deploy/cgi-bin $TRAC_DATA
    trac-admin $TRAC_DATA permission add $ADMIN_NAME TRAC_ADMIN

    # initialize web server
    /bin/ash /add_htdigest.sh "$ADMIN_NAME" "$REALM_NAME" "$ADMIN_PASSWD" > $TRAC_DATA/.htdigest
    cp /trac.conf /trac/trac.conf
    sed -i "s|{{SERVER_NAME}}|${SERVER_NAME}|g" /trac/trac.conf
    sed -i "s|{{PROJECT_NAME}}|${PROJECT_NAME}|g" /trac/trac.conf
    sed -i "s|{{REALM_NAME}}|${REALM_NAME}|g" /trac/trac.conf

elif [ "$1" != '' ]; then
    exec "$@"
fi

rm -f /etc/apache2/conf.d/trac.conf
ln -s /trac/trac.conf /etc/apache2/conf.d/trac.conf
chown -R apache:apache $TRAC_DATA
/usr/sbin/httpd -D FOREGROUND
