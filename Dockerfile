FROM centos:6

RUN yum install -y httpd postgresql postgresql-server postgresql-python php perl nano wget sed

RUN sed -i 's/SELINUX=".*"/SELINUX=\"disabled\"/g'  /etc/selinux/config

RUN wget https://netcologne.dl.sourceforge.net/project/ibsng/IBSng-A1.24.tar.bz2 \
 && tar -xvjf IBSng-A1.24.tar.bz2 -C /usr/local \
 && rm IBSng-A1.24.tar.bz2

RUN service postgresql initdb \
 && service postgresql start 

RUN sed -i '1ilocal IBSng ibs trust' /var/lib/pgsql/data/pg_hba.conf

RUN su - postgres \
 && createuser ibs \
 && createlang plpgsql IBSng \
 && exit

RUN  service postgresql restart


RUN /usr/local/IBSng/scripts/setup.py

RUN service iptables stop \
 && service postgresql stop \
 && service httpd stop

RUN sed -i '1iServerName 127.0.0.1' /etc/httpd/conf/httpd.conf \
 && sed -i '1i#coding:utf-8' /usr/local/IBSng/core/lib/IPy.py \
 && sed -i '1i#coding:utf-8' /usr/local/IBSng/core/lib/mschap/des_c.py \
 && sed -i '25s/$timeArr=".*"/$timeArr=”IRDT/4.0/DST”;/g'  /usr/local/IBSng/interface/IBSng/inc/error.php

RUN service iptables start \
 && service postgresql start \
 && service httpd start \
 && service IBSng start \
 && chkconfig postgresql on \
 && chkconfig httpd on \
 && chkconfig IBSng on 

RUN sed -i '1idate.timezone =”Asia/Tehran”' /etc/php.ini 

RUN service httpd restart


RUN iptables -A INPUT -p tcp -m state –state NEW -m tcp –dport 80 -j ACCEPT \
 && iptables -A INPUT -p tcp -m state –state NEW -m tcp –dport 1812 -j ACCEPT \
 && iptables -A INPUT -p tcp -m state –state NEW -m tcp –dport 1813 -j ACCEPT


ADD IBSng_backup.sh /IBSng_backup.sh
ADD run.sh /run.sh
RUN chmod +x /run.sh \
 && chmod +x /IBSng_backup.sh \
 && mkdir /backup

CMD ["/run.sh"]
