#
# Cookbook Name:: shutdown
# Recipe:: default
# encoding: utf-8
#

bash "logrotate on shutdown" do
  user 'root'
  code <<-EOH
  /usr/sbin/logrotate -f /etc/logrotate.conf
  EOH
end