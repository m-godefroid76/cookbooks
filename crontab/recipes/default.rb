cron "wp-cron" do
    action :create
    minute "*/10"
    command '/usr/bin/php /srv/www/wordpress/current/wp-cron-mu.php > /var/log/cron.log 1>&1'
end
