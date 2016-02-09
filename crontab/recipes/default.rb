cron "wp-cron" do
    action :create
    hour "0"
    minute "10"
    command '/usr/bin/php /var/www/wp-cron-mu.php > /var/log/cron.log 1>&1'
end
