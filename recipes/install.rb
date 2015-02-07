# btsync will run as my user ID DAEMON_UID= [:btsync][:user]

user node[:btsync][:user] do
  action :create
  system true
  shell "/bin/bash"
end

if node[:btsync][:bootstrap]
  download_url = "#{node[:btsync][:download_aws]}"
else 
  download_url = "#{node[:btsync][:download_dash]}"
end

Chef::Log.info "Dashboard: #{node[:btsync][:dashboard]}. Downloading btsync binaries from #{download_url}"
base_package_dirname =  File.basename(node[:btsync][:file], ".tar.gz")
cached_package_filename = "#{Chef::Config[:file_cache_path]}/#{node[:btsync][:file]}"
Chef::Log.info "You should find it in:  #{cached_package_filename}"

# TODO - HTTP Proxy settings
remote_file cached_package_filename do
  user "#{node[:btsync][:user]}"
  source download_url
  mode "0600"
  action :create_if_missing
end

bash "unpack_btsync" do
  user "root"
  code <<-EOF
cd #{Chef::Config[:file_cache_path]}
tar -xzf #{node[:btsync][:file]}
mv btsync #{node[:btsync][:bin]}
chmod +x #{node[:btsync][:bin]}/btsync
chown #{node[:btsync][:user]} #{node[:btsync][:bin]}/btsync
EOF
  not_if { ::File.exists?( "#{node[:btsync][:bin]}/btsync" ) }
end

directory node[:btsync][:etc] do
  owner node[:btsync][:user]
  mode "775"
  action :create
  recursive true
end

directory "/home/#{node[:btsync][:user]}/.btsync" do
  owner node[:btsync][:user]
  mode "775"
  action :create
  recursive true
end


