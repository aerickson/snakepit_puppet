class moz_slurm::head::nfs {

  # install NFS server
  package {
      'nfs-kernel-server':
          ensure => present;
  }

  service { 'nfs-server':
    ensure  => 'running',
    enable  => true,
    require => Package['nfs-kernel-server'],
  }

  # create nfs mount points

  # /snakepit/shared/data
  file { '/snakepit':
    ensure => 'directory',
    path   => '/snakepit',
    # leave options loose as it's an existing dir in prod
  }
  file { '/snakepit/shared':
    ensure => 'directory',
    path   => '/snakepit/shared',
    # leave options loose as it's an existing dir in prod
  }
  file { '/snakepit/shared/data':
    ensure => 'directory',
    path   => '/snakepit/shared/data',
    # leave options loose as it's an existing dir in prod
  }

  #   /moz_slurm/user_data
  file { '/moz_slurm/user_data':
    ensure => 'directory',
    path   => '/moz_slurm/user_data',
    mode   => '0750',
    owner  => 'slurm',
    group  => 'slurm'
  }

  # configure /etc/exports
  file { '/etc/exports':
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
  #   content => template('::moz_slurm/etc_exports'),  # why was this a template?
    source => 'puppet:///modules/moz_slurm/etc_exports',
    notify => Service['nfs-server'],
  }

  # TODO: configure number of NFS daemon threads
  # root@mlchead:/etc/default# cat nfs-kernel-server
  # Number of servers to start up
  # RPCNFSDCOUNT=32

  # TODO: configure nfsd
  # 32 on mlchead, set in /etc/defaults/nfs-kernel-server
  # RPCNFSDCOUNT=8

}
