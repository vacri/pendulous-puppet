# administrator user accounts

class admins {

	# should be present anyway on Debian
	group { 'adm':
		ensure => 'present',
	}

	#include users

	users::account { "paul":
		password	=> '$6$XgFK4TNG$Vr3eJFXvX8i6R0WNNP5nYnM0TZxKVGmQOQI3DHzDBFucPUify2bpwSXDs78Fqbr/0Shermg75T2a/lsPt9hLx0',
		ssh_type	=> 'ssh-rsa',
		ssh_key		=> 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC8nXlIWo4XpVZ4tFIFsTXtW3/B/mNAplf51EsCbnxpbxQK6VUPiDeYggNSUCSvk+Qf+JW3pLFaBVO65l/OY8xevgcbVZZYe+FmqP/IhdqPqL4LsblcCgrYw1+oMId+4u48XfB9pFTOkojTOAphcCJ6RJqzLJpbnaTmGPD23Z5orOQpchUKU9yOPjcEXeb2mUBLYBihZ2cbT4aoky7/KZyvHTpOsNeqX6gURcgz45eMeoWm7PD+A5Ku5EHVpVfF0Vnga6Tv2IRGNzb9Rt6/g4TyIDj+5JxdWNeI0b9swLsnUvzsIbXGHomdlC2NRafVxCYYlp5SI0xjFoz6SqONQKQH',
		ssh_comment => 'paul@spilogale',
		groups		=> 'adm',
		require		=> Group['adm']
	}




}
