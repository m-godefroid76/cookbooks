bash "logrotate on shutdown" do
  user 'ubuntu'
  code <<-EOH
  sudo logrotate -f /etc/logrotate.conf
  EOH
end