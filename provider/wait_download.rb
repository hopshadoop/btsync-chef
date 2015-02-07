action :install_ndbd do

tgt = "#{new_resource.recipe_name}"

#  Chef::Log.info "seeder : #{node[:ndb][:seeder_ip]}"

# Tail the log (./sync/sync.log) until we see the event that the file has completed downloading ("Finished syncing file").
# Set a timeout if that event takes too long.

  bash "wait_until_file_downloaded" do
#      user "#{node[:btsync][:user]}"
    user "root"
    code <<-EOF
    DOWNLOADED=0
    TIMEOUT=#{node[:btsync][:timeout_secs]}
    COUNT=0
    ERROR=0
    LOG=#{node[:btsync][:etc]}/sync-#{tgt}.log
    service btsync-#{tgt} stop
    
    while [ $DOWNLOADED -eq 0 ] ; do
      if [ -e $LOG  ] ; then
        FOUND=`grep "Finished syncing file" $LOG`
        if [ $FOUND = "0" ] ; then
          ERROR=`grep -v "Error while adding folder" $LOG | grep "Error"`
        fi
      else
         FOUND=0
      fi
         
      if [ $FOUND -eq 1  ] ; then
        DOWNLOADED=1;
      elif [ $ERROR -eq 1 ] ; then
        DOWNLOADED=3;
      else
        if [ ${COUNT} -eq 0 ] ; then
          echo -n "Seconds left before timeout: "
          echo -n "`expr ${TIMEOUT} - ${COUNT}` "
          sleep 1
          COUNT=`expr ${COUNT} + 1`
          if [ $COUNT -gt $TIMEOUT ] ; then
            DOWNLOADED=2;
          fi
        fi
      fi
    done
    echo ""
    if [ $DOWNLOADED -ne 1 ] ; then
      echo "Btsync didn't finish on time, downloading using wget"
    else 
      touch #{Chef::Config[:file_cache_path]}/.#{tgt}_downloaded
    fi
    EOF
  not_if { ::File.exists?("#{Chef::Config[:file_cache_path]}/.#{tgt}_downloaded")  }
  end


end

