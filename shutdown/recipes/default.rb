#
# Cookbook Name:: shutdown
# Recipe:: default
# encoding: utf-8
#

bash "logrotate on shutdown" do
  user 'root'
  command 'sudo /usr/sbin/logrotate -f /etc/logrotate.conf'
  action :nothing
end