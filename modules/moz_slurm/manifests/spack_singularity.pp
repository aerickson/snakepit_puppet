class moz_slurm::spack_singularity {

  require moz_slurm::spack
  require moz_slurm::spack_lmod

  # install singularity
  exec {'install singularity':
    command  => "%{lookup('moz_slurm::spack_bin_path')} install singularity",
    provider => shell,
    user     => 'slurm',
    unless   => "%{lookup('moz_slurm::spack_bin_path')} find singularity",
    timeout  => 3600,
  }

}