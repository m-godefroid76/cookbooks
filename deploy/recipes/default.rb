deploy 'wordpress' do
  # Application resource properties.
  repo 'git@github.com:m-godefroid76/ops_wordpress.git'
  user 'root'
  deploy_to '/var/www/html'
  action :deploy	
end
