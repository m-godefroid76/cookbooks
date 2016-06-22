#
# Cookbook Name:: symlink
# Recipe:: default
# encoding: utf-8
#

# link '/mnt/srv/www/wordpress/current/wp-content/uploads' do
  # to '/mnt/uploads'
# end

# link '/mnt/srv/www/wordpress/template' do
  # to '/mnt/srv/www/wordpress/wp-content/uploads/template'
# end

# link '/mnt/srv/www/wordpress/content' do
  # to '/mnt/srv/www/wordpress/wp-content/uploads/content'
# end

template '/srv/www/wordpress/current/.htaccess' do
  source 'htaccess.erb'
  owner 'root'
  group 'root'
  mode '0444'
end

template '/srv/www/wordpress/current/opengraphy/config.php' do
  source 'config.resto_be.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/srv/www/wordpress/current/opengraphy/resto_fr/config.php' do
  source 'config.resto_fr.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/srv/www/wordpress/current/wp-cron-mu.php' do
  source 'wp-cron-mu.php.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/etc/logrotate.conf' do
  source 'logrotate.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/etc/logrotate.d/apache2' do
  source 'apache2.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/root/.s3cfg' do
  source 's3cfg.erb'
  owner 'root'
  group 'root'
  mode '0600'
end

template '/srv/www/wordpress/current/health-check.php' do
  source 'health-check.php.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

directory '/scripts' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template '/scripts/backup-db.sh' do
  source 'backup-db.sh.erb'
  owner 'root'
  group 'root'
  mode '0777'
end

bash "chmod x script backup" do
  user 'root'
  code <<-EOH 
  chmod +x /scripts/backup-db.sh
  EOH
end

directory '/srv/www/wordpress/current/wp-content/w3tc-config' do
  owner 'www-data'
  group 'www-data'
  mode '0777'
  action :create
end

template '/srv/www/wordpress/current/wp-content/w3tc-config/master.php' do
  source 'master.php.erb'
  owner 'www-data'
  group 'www-data'
  mode '0777'
end

template '/srv/www/wordpress/current/wp-content/w3tc-config/master-admin.php' do
  source 'master-admin.php.erb'
  owner 'www-data'
  group 'www-data'
  mode '0777'
end

template '/srv/www/wordpress/current/wp-content/w3tc-config/index.html' do
  source 'index.html.erb'
  owner 'www-data'
  group 'www-data'
  mode '0777'
end

directory '/srv/www/wordpress/current/wp-content/uploads' do
  owner 'www-data'
  group 'www-data'
  mode '0777'
  action :create
end

directory '/srv/www/wordpress/current/wp-content/uploads/cron_reviews' do
  owner 'www-data'
  group 'www-data'
  mode '0777'
  action :create
end

directory '/srv/www/wordpress/current/wp-content/uploads/cron_reviews/cron_update_reviews' do
  owner 'www-data'
  group 'www-data'
  mode '0777'
  action :create
end


bash "move logrotate.cron from daily to hourly" do
  user 'root'
  code <<-EOH
  sudo cp /etc/cron.daily/logrotate /etc/cron.hourly/logrotate
  EOH
end

directory '/srv/www/wordpress/current/wp-content/cache' do
  owner 'www-data'
  group 'www-data'
  mode '0755'
  action :create
end

# directory '/var/www/.aws' do
  # owner 'www-data'
  # group 'www-data'
  # mode '0755'
  # action :create
# end
# 
# template '/var/www/.aws/config' do
  # source 'config.erb'
  # owner 'www-data'
  # group 'www-data'
  # mode '400'
# end


directory '/root/.aws' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template '/root/.aws/config' do
  source 'config.erb'
  owner 'root'
  group 'root'
  mode '400'
end

# bash "download enfold.css from s3" do
  # user 'root'
  # code <<-EOH  
  # aws s3 cp s3://devrestofactory/wp-content/uploads/dynamic_avia/ /srv/www/wordpress/current/wp-content/uploads/ --recursive
  # EOH
# end

# bash "download specific folders" do
  # user 'root'
  # code <<-EOH  
  # aws s3 cp s3://#{ node[:bucket] }/wp-content/uploads/ /srv/www/wordpress/current/wp-content/uploads/ --recursive  --exclude "*"  --include "*sites/41/*" --include "*sites/53/*"
  # EOH
# end

directory '/srv/www/wordpress/current/wp-content/cache' do
  owner 'www-data'
  group 'www-data'
  mode '0777'
  action :create
end

directory '/srv/www/wordpress/current/wp-content/cache/cron_reviews' do
  owner 'www-data'
  group 'www-data'
  mode '0777'
  action :create
end

directory '/srv/www/wordpress/current/wp-content/cache/cron_reviews/cron_update_reviews/' do
  owner 'www-data'
  group 'www-data'
  mode '0777'
  action :create
end

node[:deploy].each do |application, deploy|
  cache_config = "#{deploy[:deploy_to]}/current/wp-content/w3tc-config"
  execute "chmod -R 777 #{cache_config}" do
  end
end

node[:deploy].each do |application, deploy|
  uploads_folder = "#{deploy[:deploy_to]}/current/wp-content/uploads"
  execute "chown -R www-data:www-data #{uploads_folder}" do
  end
end

node[:deploy].each do |application, deploy|
  www_folder = "/var/www"
  execute "chown -R www-data:www-data #{www_folder}" do
  end
end

node[:deploy].each do |application, deploy|
  srv_folder = "/srv/www"
  execute "chown -R www-data:www-data #{srv_folder}" do
  end
end

%w{ awscli }.each do |pkg|
  package pkg
end

# template '/etc/sudoers' do
  # source 'sudoers.erb'
  # owner 'root'
  # group 'root'
  # mode '0440'
# end

service "apache2" do
  action :restart
end

# node[:deploy].each do |application, deploy|
  # cache_config = "#{deploy[:deploy_to]}/current/wp-content/wp-cache-config.php"
  # execute "chmod -R 666 #{cache_config}" do
  # end
# end

