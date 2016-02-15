bash "logrotate on shutdown" do
  user 'ubuntu'
  code <<-EOH
  logrotate -f /etc/logrotate.conf
  EOH
end