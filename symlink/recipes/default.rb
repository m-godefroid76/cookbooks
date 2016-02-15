#
# Cookbook Name:: symlink
# Recipe:: default
# encoding: utf-8
#

link '/mnt/srv/www/wordpress/current/wp-content/uploads' do
  to '/mnt/uploads'
end

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

directory '/srv/www/wordpress/current/wp-content/cache' do
  owner 'www-data'
  group 'www-data'
  mode '0755'
  action :create
end

node[:deploy].each do |application, deploy|
  cache_config = "#{deploy[:deploy_to]}/current/wp-content/wp-cache-config.php"
  execute "chmod -R 666 #{cache_config}" do
  end
end
