FROM ibsng:1.24

ADD IBSng_backup.sh /root/IBSng_backup.sh
ADD run.sh /root/run.sh
RUN chmod +x /root/run.sh
RUN chmod +x /root/IBSng_backup.sh

CMD ["/root/run.sh"]
