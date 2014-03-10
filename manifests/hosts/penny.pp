node penny inherits cac_base {

	# make a deluge user manually at the moment
	# as per http://linuxhomeserverguide.com/mediaserver/deluge.php
	$penny_packages = [ 'deluged', 'deluge-web' ]

	class { 'nginx': }

	nginx::resource::upstream { 'deluge-server':
		ensure	=> present,
		members	=> [ 
			'localhost:8112',
		],
	}	

	nginx::resource::vhost { 'pendulous.equipment':
		ensure	=> present,
		proxy	=> 'http://deluge-server'
	}


}
