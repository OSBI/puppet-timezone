class timezone {
    
    # requires ntp, but not included here as it makes key changes to the OS 
    # and should instead be included in some sort of default node class
    # (common.pp) which is included on all nodes.
    include ntp 
    $timezone_zone = extlookup('timezone_zone','Etc/UTC')
    
    package { 'tzdata':
        ensure => latest
    }
    
    file { '/etc/timezone':
        ensure  => present,
        content => template('timezone/clock.erb'),
        notify  => Service['ntp'],
    }
    
    file { '/etc/localtime':
        ensure  => link,
        target  => '/usr/share/zoneinfo/UTC',
        require => [Package['tzdata']],
        notify  => Service['ntp']
    }
    
}

