
default[:btsync][:file]= "btsync_x64.tar.gz"

default[:btsync][:download_aws] = "http://btsync.s3-website-us-east-1.amazonaws.com/#{node[:btsync][:file]}"
default[:btsync][:bootstrap_ip] = "10.0.2.15"
default[:btsync][:download_dash] = "http://#{node[:btsync][:bootstrap_ip]}/#{node[:btsync][:file]}"
default[:btsync][:user] = "btsync"
default[:btsync][:device_name]= ""
default[:btsync][:timeout_secs] = 60000

# The bootstrap attribute declares whether this node is a seeder (true) or a leecher (false)
default[:btsync][:bootstrap] = false
# by default, btsync loads all profiles in the /etc/btsync directory. We will have a different
# profile for every recipe that uses btsync (ndb, java, python, hop, etc)
default[:btsync][:etc] = "/home/#{node[:btsync][:user]}/.btsync"
default[:btsync][:bin] = "/usr/bin"

default[:btsync][:search_lan] = false

# Folder where the files are downloaded to, and shared from.
default[:btsync][:shared_folder] = "/var/btsync"

# bysync::config needs to know what the client recipe that called it is called.
default[:btsync][:active_recipe] = "btsync"

#  attributes set by JClouds
default[:btsync][:public_ips] = ['10.0.2.15']
default[:btsync][:private_ips] = ['10.0.2.15']
default[:btsync][:public_ip] = '10.0.2.15'
default[:btsync][:private_ip] = '10.0.2.15'

