# Install Apache and configure its service.
include_recipe 'apache2::default'

# Create and enable our custom site.
web_app 'frontend' do
  template 'scalable.graphylabs.com.conf.erb'
end

# disable default site
apache_site '000-default' do
  enable false
end

# enable frontend site
apache_site 'frontend' do
  enable true
end

# restart apache2
service "apache2" do
    action [ :restart ]
end
