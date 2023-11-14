#!/bin/bash
set -e


setupEdgecoreConfig(){
#Ensure destination directory exists
if [ ! -d "/etc/kubeedge/config" ]; then
   mkdir -p /etc/kubeedge/config
fi



# Init config
/usr/local/bin/edgecore --defaultconfig > /etc/kubeedge/config/edgecore.yaml

# Update httpServer addr
sed -i 's/^    httpServer.*10002/    httpServer: https:\/\/'"$CLOUD_HOST"':10002/' /etc/kubeedge/config/edgecore.yaml

# Update token
sed -i 's/^    token.*/    token: '"$TOKEN"'/' /etc/kubeedge/config/edgecore.yaml

# Update websocket and quic addr
sed -i 's/^      server.*10000/      server: '"$CLOUD_HOST"':10000/' /etc/kubeedge/config/edgecore.yaml

# Update edgeStream addr
sed -i 's/^    server.*10004/    server: '"$CLOUD_HOST"':10004/' /etc/kubeedge/config/edgecore.yaml

# Update hostname override
sed -i 's/^    hostnameOverride.*/    hostnameOverride: '"$HOSTNAME"'/' /etc/kubeedge/config/edgecore.yaml

# Update cgroup override
sed -i 's/^      cgroupDriver.*/      cgroupDriver: systemd/' /etc/kubeedge/config/edgecore.yaml

# Update readOnlyPort
sed -i 's/^      readOnlyPort.*/      readOnlyPort: 10250/g' /etc/kubeedge/config/edgecore.yaml

# Update address
sed -i 's/^      address.*/      address: 0.0.0.0/g' /etc/kubeedge/config/edgecore.yaml

}



setupEdgecoreConfig