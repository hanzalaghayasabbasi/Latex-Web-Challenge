FROM php:apache

RUN apt update; \
    apt -y upgrade; \
    apt install -y texlive-latex-base texlive-latex-extra cron;

COPY challenge/entry.sh /entry.sh
COPY challenge/cleanpdfdir.sh /root/cleanpdfdir.sh
RUN chmod -w /root/cleanpdfdir.sh

COPY challenge/public_html/ /var/www/html/
RUN mkdir /var/www/html/compile
RUN mkdir /var/www/html/pdf
RUN chown -R www-data /var/www/html
RUN chgrp -R www-data /var/www/html

COPY challenge/flag.txt /home/Desktop/trustline/flag/flag.txt
RUN chmod -w /home/Desktop/trustline/flag/flag.txt
RUN chmod -R -w /var/www/html/assets
RUN chmod -w /var/www/html/ajax.php /var/www/html/config.php /var/www/html/index.html

RUN (crontab -l 2> /dev/null; echo "* * * * * /root/cleanpdfdir.sh")| crontab -

ENTRYPOINT ["/entry.sh"]
