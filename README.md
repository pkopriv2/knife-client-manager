# Knife-Client-Manager

Knife-client-manager is a tool to easily organize, manage and switch 
between different knife configurations. See [Chef](http://www.opscode.com/chef/)
for more info on knife.


# Commands 

* *kcm list* - List the current knife configurations. * marks current
* *kcm use* - Use a knife configuration.
* *kcm unuse* - Don't use any configuration. 
* *kcm create* - Create a new knife configuration.
* *kcm delete* - Delete a configuration
* *kcm info* - Show the current knife.rb file that is being used.
* *kcm configure* - Configure the current environment to point to the given chef-server.  (Experimental)

You may also use help with any of the above commands (e.g. kcm configure help)

# Installation

* Install the current version.
	
	curl https://raw.github.com/pkopriv2/knife-client-manager/master/install.sh | bash -s 

* Install a specific version.

	curl https://raw.github.com/pkopriv2/knife-client-manager/master/install.sh | bash -s "1.0.1"

# Usage

## Initializing a new knife-client

### Create a configuration

	kcm create <chef-server>

### Copy The validation keys

	pushd ~/.chef # ~/.chef is a symlink to the configuration directory
	scp <user>@<chef-server>:/etc/chef/*.pem . 
	kcm configure http://<chef-server>:4000


_If you decide to use knife configure -i, when chef asks for the location of the pem files you 
can reference either the absolute path of the configuration directory, or you can 
reference the absolute path of the home directory where .chef lives, e.g. /home/pkopriv2/.chef_ 

### You're done!
