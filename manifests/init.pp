class rpmdev(
	$yum_install_devgroups='false',
)
{
       
	package { "redhat-rpm-config": ensure=>"installed" }
       	package { "createrepo": ensure=>"installed" }


	if $yum_install_devgroups == 'true' {

		# Puppet doesn't yet support yum groups with the package directive
		# Until it does we use exec to install these packages. 
		exec { 'install dev tools':
			unless  => '/usr/bin/yum grouplist "Development tools" | /bin/grep "^Installed Groups"',
			command => '/usr/bin/yum -y groupinstall "Development tools"',
		}
	}
}


define rpmdev::setuptree(
	$username = $name,
)
{
	exec {"create_rpmbuild_for_$name":
 	 	require => User[$name],
		user => $name,
  		command => "/bin/mkdir -p  /home/$name/rpmbuild/{RPMS,BUILD,SOURCES,SPECS,SRPMS}",
		creates => "/home/$name/rpmbuild"
	}

	file { "/home/$name/.rpmmacros":
		ensure => present,
		source => 'puppet:///modules/rpmdev/rpmmacros';
	}	


}
