# Knife-Client-Manager

Knife-client-manager is a tool to easily organize, manage and switch 
between different knife configurations. See [Chef](http://www.opscode.com/chef/)
for more info on knife.


# Commands 

* *kcm configure* - Configure the current environment to point to the given chef-server.  (Experimental)
* *kcm create* - Create a new knife environment.
* *kcm current* - Display the current knife environment.
* *kcm delete* - Delete a knife environment.
* *kcm info* - Display the knife configuration file for the current environment.
* *kcm list* - List all the knife configurations. * marks current
* *kcm unuse* - Don't use any knife environment. 
* *kcm use* - Use a knife environment.

You may also use help with any of the above commands (e.g. kcm configure help)

# Installation

Head on over to https://github.com/pkopriv2/bashum and install the latest version of bashum. 

* Install the current version.
	
	bashum install \<url_to_bashum\>

# Usage

## Initializing a new knife-client

### Create a new environment

	kcm create \<chef-server\>

### Configure the environment

	pushd ~/.chef # ~/.chef is a symlink to the configuration directory
	scp <user>@<chef-server>:/etc/chef/*.pem . 
	kcm configure http://<chef-server>:4000

### You're done!
