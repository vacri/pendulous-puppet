# TODO: 
# - sort out users (there's some odd infinite loop...)
# - colour prompts


#globally set exec path
Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }

import "hosts/*.pp"
#import "users/*.pp"
import "concat"

node base {
	
	#include admins

	#packages packages packages
	$base_packages = [ 'sudo', 'git', 'screen', 'htop', 'iotop', 'iftop', 'vim', 'curl', 'mutt', 'mailutils', 'fail2ban' ]

	package { $base_packages: ensure => latest }

	exec { "/usr/bin/update-alternatives --set editor /usr/bin/vim.basic":
		unless => "/usr/bin/test /etc/alternatives/editor -ef /usr/bin/vim.basic",
		require => Package['vim']
	}

	#silences cron from emailing if it's prepended to the command
	file {'/usr/bin/cronic':
		source => 'puppet:///files/cronic', 
		owner => 'root',
		group => 'root',
		mode => 0755
	}

}


node cac_base inherits base {

	# TODO: note that there's no entry yet for network interfaces in puppet...
	notice ( "CLOUDATCOST: Cloudatcost hoses your static IP after a reimage of the VM - before 'applying', you may need to manually update the IP addresses in puppet to match those in panel.cloudatcost.com" )

}
