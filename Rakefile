# task default: [:create_package_configuration]

desc "Create a package configuration"
task :create_package_configuration do |t|
  sh "./modules/moz_slurm/files/creating_new_package_configs/build_and_run.sh"
end

desc "Create a distribution package"
task :test_package_configuration do |t|
  sh "./modules/moz_slurm/files/testing_package_configs/build_and_run.sh"
end
