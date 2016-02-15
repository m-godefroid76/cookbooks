bash "logrotate on shutdown" do
  user 'root'
  code <<-EOH
  logrotate -f /etc/logrotate.conf
  EOH
end