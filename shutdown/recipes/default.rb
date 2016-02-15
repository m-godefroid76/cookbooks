bash "logrotate on shutdown" do
  user 'root'
  code <<-EOH
  sudo logrotate -f /etc/logrotate.conf
  EOH
end