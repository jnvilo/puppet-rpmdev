puppet-rpmdev
=============

Configures home directory and installs rpms required for building rpms

Example Use:

node workstation {

		#omitting yum_install_devgroups or setting it to other than true
		#will skip install of group Development Tools"

		class { "rpmdev": yum_install_devgroups=>'true',}

		#create the directory structure for rpmbuild
		rpmdev::setuptree{"jnvilo":}

		#The above requires that the user "jnvilo" and home is managed by puppet.
		user { "jnvilo":
                ensure  => present,
                uid     => "1111",
                gid     => "wheel",
                shell   => "/bin/bash",
                home    => "/home/jnvilo",
                managehome => true,
                password => '$1$SE7olR7EBSSKLaBkRQzQBulrbX.',}
        } 
	




A custom rpmmacro is in the files directory and this will be deployed to the home of the user. 


