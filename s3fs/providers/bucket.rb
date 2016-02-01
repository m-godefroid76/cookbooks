action :mount do
    
  if @new_resource.mount_folder != nil
    
    folder = @new_resource.mount_folder
    
    #create uploads folder 	
    directory '/var/www/html/wp-content/uploads' do
      owner 'www-data'
      group 'www-data'
      mode '0755'
      action :create
      recursive true
    end

    directory "/var/www/html/wp-content/uploads/#{folder}" do
      mode "0755"
      owner "www-data"
      group "www-data"
      action :create
      recursive true
    end
    
    bucket = @new_resource.bucket_name
    
    bash "mount s3 bucket on folder" do
      code <<-EOH
      sudo bash -c 'export AWSACCESSKEYID=#{ node[:access_key] }; export AWSSECRETACCESSKEY=#{ node[:secret_key] }; s3fs #{bucket} /mnt/test/#{folder} -o allow_other'
      EOH
    
## a instrucao not_if parece nao funcionar devidamente  quando chamada varias vezes seguidas num loop      
      not_if { ::File.directory?("/var/www/html/wp-content/uploads/#{folder}/mysql/") }
    end
  end


end
