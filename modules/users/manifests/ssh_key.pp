define users::ssh_key( $key, $comment, $ensure = present, $type = 'ssh-rsa' ) {

    $username       = $title

    ssh_authorized_key { "${username}_${key}":
        ensure  => $ensure,
        type    => $type,
        key     => $key,
        name    => $comment,
        user    => $username,
        require => File["/home/$username/.ssh/authorized_keys"]
    }

}

