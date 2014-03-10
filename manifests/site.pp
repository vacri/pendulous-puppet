#globally set exec path
Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }

import "hosts/*.pp"
#import "users/*.pp"

node base {

	#include admins

	#packages packages packages
	$base_packages = [ 'sudo', 'git', 'nginx', 'screen', 'htop', 'iotop', 'iftop', 'vim', 'curl', 'mutt', 'mailutils' ]

	package { $base_packages: ensure => latest }

	exec { "/usr/sbin/update-alternatives --set editor /usr/bin/vim.basic":
		unless => "/usr/bin/test /etc/alternatives/editor -ef /usr/bin/vim.basic",
		require => Package['vim']
	}

	#silences cron from emailing if it's prepended to the command
	file {'/usr/local/bin/cronic':
		source => 'puppet:///files/cronic', #TODO fix file location
		owner => 'root',
		group => 'root',
		mode => 0755
	}

	


}
