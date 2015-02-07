name             "btsync"
maintainer       "Jim Dowling"
maintainer_email "jdowling@kth.se"
license          "GPL 3.0"

description      "Installs/Configures Bittorrent P2P Synchronization Service"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

version          "0.1"

%w{ ubuntu debian }.each do |os|
  supports os
end


attribute "btsync/bootstrap",
:display_name => "Bootstrap server for Btsync",
:description => "True if this machine is the seeder for the torrent",
:type => 'string',
:default => "false"

