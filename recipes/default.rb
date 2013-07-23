#
# Cookbook Name:: startup
# Recipe:: default
#
# Copyright (C) 2013
# 
#
#
#
#
#
#
package "git-core"

directory "/opt/startup"

bash "install_heroku" do 
  action :nothing
  cwd "/opt/startup"
  code <<-EOH
    sudo chmod +x /opt/startup/heroku-install.sh
    sudo /opt/startup/heroku-install.sh
  EOH
  user "root"
  group "root"
end

remote_file "/opt/startup/heroku-install.sh" do
  source "https://toolbelt.heroku.com/install-ubuntu.sh"
  mode 0755
  not_if { ::File.exists?("/opt/startup/heroku-install.sh") } 
  notifies :run, "bash[install_heroku]", :immediately
end

bash "setup" do 
  action :nothing
  cwd "/opt/startup-setup"
  code <<-EOH
    sudo chmod +x /opt/startup-setup/setup.sh
    sudo /opt/startup-setup/setup.sh
  EOH
end

git "/opt/startup-setup" do
  repository "https://github.com/startup-class/setup.git"
  reference "master"
  action :sync
  user "root"
  group "root"
  notifies :run, "bash[setup]", :immediately
end
