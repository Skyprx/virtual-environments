#Set ImageVersion and ImageOS env variables
echo ImageVersion=$IMAGE_VERSION | tee -a /etc/environment
echo ImageOS=$IMAGE_OS | tee -a /etc/environment

# This directory is supposed to be created in $HOME and owned by user(https://github.com/actions/virtual-environments/issues/491)
mkdir -p /etc/skel/.config/configstore
echo 'export XDG_CONFIG_HOME=$HOME/.config' | tee -a /etc/skel/.bashrc

# Change waagent entries to use /mnt for swapfile
sed -i 's/ResourceDisk.Format=n/ResourceDisk.Format=y/g' /etc/waagent.conf
sed -i 's/ResourceDisk.EnableSwap=n/ResourceDisk.EnableSwap=y/g' /etc/waagent.conf
sed -i 's/ResourceDisk.SwapSizeMB=0/ResourceDisk.SwapSizeMB=4096/g' /etc/waagent.conf

# Prepare directory and env variable for toolcache
AGENT_TOOLSDIRECTORY=/opt/hostedtoolcache
mkdir $AGENT_TOOLSDIRECTORY
echo "AGENT_TOOLSDIRECTORY=$AGENT_TOOLSDIRECTORY" | tee -a /etc/environment
chmod -R 777 $AGENT_TOOLSDIRECTORY
