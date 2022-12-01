#!/bin/bash

sudo apt update -y
sudo apt install nginx -y
ip=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)

cat <<EOF > /var/www/html/index.html

<html>
    <h2>
        Hello ${name1} and ${name2}!

    <br>
       IP:  $ip
    </h2>

</html>

EOF

sudo service nginx restart
systemctl nginx enable

