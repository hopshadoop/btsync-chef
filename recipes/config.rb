# This recipe is a 'base-class' that is inherited by concrete
# recipes that want to use btsync to distribute their binaries.
# E.g., ndb::btsync includes "btsync::config" after setting
# node[:btsync][:active_recipe]="ndb" 

include_recipe "btsync::install"

tgt=node[:btsync][:active_recipe]
Chef::Log.info "Btsync::config - active cookbook: #{tgt}"

template "/etc/init.d/btsync-#{tgt}" do
  source "btsync.erb"
  owner node[:btsync][:user]
  group node[:btsync][:user]
  mode 0755
  variables({ :recipe_name => "#{tgt}" })
end

seeder_ip = private_cookbook_ip("#{tgt}")
Chef::Log.info "Btsync::config - seeder_ip: #{seeder_ip}"

template "#{node[:btsync][:etc]}/btsync-#{tgt}.conf" do
  source "btsync.conf.erb"
  owner node[:btsync][:user]
  group node[:btsync][:user]
  mode 0755
  variables({ :bt_secret => @bt_secret,
              :recipe_name => "#{tgt}",
              :port => 44445,
              :dir => node[:btsync][:shared_folder],
              :seeder_ip => seeder_ip
            })
end
