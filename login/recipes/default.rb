template '/mnt/srv/www/wordpress/current/login/index.php' do
  source 'index.php.erb'
  owner 'root'
  group 'root'
  mode '0644'
end  
