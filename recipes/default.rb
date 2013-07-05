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

script "install_heroku" do 
    action :nothing
    code <<-EOH
     /opt/startup/heroku-install.sh
    EOH
end


remote_file "/opt/startup/heroku-install.sh" do
  source "wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh"
   not_if { ::File.exists?("/opt/startup/heroku-install.sh") } 
   notifies :run, "script[install_heroku]", :immediately
end



