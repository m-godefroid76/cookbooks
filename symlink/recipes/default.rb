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

template '/srv/www/wordpress/current/opengraphy/config.php'
  source 'config.resto_be.erb'
  owner 'root'
  group 'root'
  mode '0644'
end 

template '/srv/www/wordpress/current/opengraphy/resto_fr/config.php'
  source 'config.resto_fr.erb'
  owner 'root'
  group 'root'
  mode '0644'
end 