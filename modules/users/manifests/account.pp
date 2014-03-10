define users::account ( $uid, $ensure = present, $groups = [], $shell = '/bin/bash', $password = '', $ssh_type = '', $ssh_key = '', $ssh_comment = '') {
    $username = $name

    # This case statement will allow disabling an account by passing
    # ensure => absent, to set the home directory ownership to root.
    case $ensure {
        present: {
            $home_owner = $username
            $home_group = $username
        }
        default: {
            $home_owner = "root"
            $home_group = "root"
        }
    }

    user { "$username":
        ensure     => $ensure,
        uid        => $uid,
        gid        => $uid,
        groups     => $groups,
        comment    => "$username,,,,",
        home       => "/home/$username",
        shell      => $shell,
        allowdupe  => false,
        managehome => true,
        require    => Group[$username],
    }

    group { "$username":
        ensure    => $ensure,
        gid       => $uid,
        allowdupe => false,
    }

    if $password != '' {
        User <| title == "$username" |> { password => $password }
    }

    file { "/home/$username/.ssh":
        ensure  => directory,
        owner   => $username,
        group   => $username,
        mode    => 700,
        require => User[$username]
    }

    file { "/home/$username/.ssh/authorized_keys":
        ensure  => present,
        owner   => $username,
        group   => $username,
        mode    => 600,
        require => User[$username]
    }

    if $ssh_key != '' {
        users::ssh_key { "$username":
            type    => $ssh_type,
            key     => $ssh_key,
            comment => $ssh_comment,
            require => File["/home/$username/.ssh/authorized_keys"],
        }
    }

}

