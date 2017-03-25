# SaltStack

### Setting up the **hostname** for the **salt-master** node:
```
echo "saltnode" > /etc/hostname
ip_address=$(ip addr show eth0 | awk '$1 == "inet" {gsub(/\/.*$/, "", $2); print $2}')
echo "$ip_address $(hostname)" >> /etc/hosts
```

### Adding the SaltStack repository key:
```
wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add -
```

### Adding the SaltStack package repository and updating the packages:
```
echo "deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main" > /etc/apt/source.list.d/saltstack.list
apt update
```

### Installing the **salt-master** and **salt-minion** packages:
```
apt install salt-master salt-minion
```

### Adding the hostname of **salt-master** in **salt-minion** configuration file (/etc/salt/minion):
```
...
# Set the location of the salt master server. If the master server cannot be
# resolved, then the minion will fail to start.
master: saltnode
...
```

### Restarting the services:
```
systemctl restart salt-master.service salt-minion.service
```

### Key Management:
1. Print the master key fingerprint:
```
salt-key -F master
```
2. Copy the **master.pub** fingerprint from the "Local Keys" section and add it as **master\_finger** value of the **salt-minion** configuration file `/etc/salt/minion`.

### Registering the minion:
To accept the minion, use the following command:
```
salt-key -a saltnode
```

### Status check and ping:
```
salt-run manage.up
salt 'saltnode' test.ping
```

### Dealing with Salt States:
1. Create the directory, where we are going to keep all the Salt states.
```
mkdir /srv/salt
cd /srv/salt
```
2. Create the salt state **log.sls** for the **logger.sh** script in `/srv/salt` directory.
3. Apply the Changes:
```
salt 'saltnode' state.apply log
```
4. Check the content of `/root/counts.log` file in every 30 minutes.

### Creating the Users:
1. Create the salt state **users.sls** and apply it on the node.
```
salt 'saltnode' state.apply users
```
