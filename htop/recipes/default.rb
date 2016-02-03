#
# Cookbook Name:: htop
# Recipe:: default
#
#

case node[:platform] 
when "ubuntu","debian"
  package "htop" do
    action :install
  end
end

template '/mnt/srv/www/wordpress/current/wp-config.php' do
  source 'wp-config.php.erb'
  variables({
     :DB_NAME => node[:DB_NAME],
     :DB_HOST => node[:DB_HOST],
     :DB_USER => node[:DB_USER],
     :DB_PASSWORD => node[:DB_PASSWORD]
  })
end
