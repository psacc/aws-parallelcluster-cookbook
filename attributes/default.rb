# frozen_string_literal: true

#
# Cookbook:: aws-parallelcluster
# Attributes:: default
#
# Copyright:: 2013-2022 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the
# License. A copy of the License is located at
#
# http://aws.amazon.com/apache2.0/
#
# or in the "LICENSE.txt" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES
# OR CONDITIONS OF ANY KIND, express or implied. See the License for the specific language governing permissions and
# limitations under the License.

# ParallelCluster log dir
default['cluster']['log_base_dir'] = '/var/log/parallelcluster'
default['cluster']['bootstrap_error_path'] = "#{node['cluster']['log_base_dir']}/bootstrap_error_msg"

# ParallelCluster log rotation file dir
default['cluster']['pcluster_log_rotation_path'] = "/etc/logrotate.d/parallelcluster_log_rotation"

# AWS domain
default['cluster']['aws_domain'] = aws_domain

# URL for ParallelCluster Artifacts stored in public S3 buckets
# ['cluster']['region'] will need to be defined by image_dna.json during AMI build.
default['cluster']['artifacts_s3_url'] = "https://#{node['cluster']['region']}-aws-parallelcluster.s3.#{node['cluster']['region']}.#{node['cluster']['aws_domain']}/archives"

# Cluster config
default['cluster']['cluster_s3_bucket'] = nil
default['cluster']['cluster_config_s3_key'] = nil
default['cluster']['cluster_config_version'] = nil
default['cluster']['change_set_s3_key'] = nil
default['cluster']['instance_types_data_s3_key'] = nil
default['cluster']['cluster_config_path'] = "#{node['cluster']['shared_dir']}/cluster-config.yaml"
default['cluster']['previous_cluster_config_path'] = "#{node['cluster']['shared_dir']}/previous-cluster-config.yaml"
default['cluster']['change_set_path'] = "#{node['cluster']['shared_dir']}/change-set.json"
default['cluster']['launch_templates_config_path'] = "#{node['cluster']['shared_dir']}/launch-templates-config.json"
default['cluster']['instance_types_data_path'] = "#{node['cluster']['shared_dir']}/instance-types-data.json"
default['cluster']['computefleet_status_path'] = "#{node['cluster']['shared_dir']}/computefleet-status.json"
default['cluster']['shared_storages_mapping_path'] = "/etc/parallelcluster/shared_storages_data.yaml"
default['cluster']['previous_shared_storages_mapping_path'] = "/etc/parallelcluster/previous_shared_storages_data.yaml"

default['cluster']['reserved_base_uid'] = 400

# Intel Packages
default['cluster']['psxe']['version'] = '2020.4-17'
default['cluster']['psxe']['noarch_packages'] = %w(intel-tbb-common-runtime intel-mkl-common-runtime intel-psxe-common-runtime
                                                   intel-ipp-common-runtime intel-ifort-common-runtime intel-icc-common-runtime
                                                   intel-daal-common-runtime intel-comp-common-runtime)
default['cluster']['psxe']['archful_packages']['i486'] = %w(intel-tbb-runtime intel-tbb-libs-runtime intel-comp-runtime
                                                            intel-daal-runtime intel-icc-runtime intel-ifort-runtime
                                                            intel-ipp-runtime intel-mkl-runtime intel-openmp-runtime)
default['cluster']['psxe']['archful_packages']['x86_64'] = node['cluster']['psxe']['archful_packages']['i486'] + %w(intel-mpi-runtime)
default['cluster']['intelhpc']['platform_name'] = value_for_platform(
  'centos' => {
    '~>7' => 'el7',
  }
)
default['cluster']['intelhpc']['packages'] = %w(intel-hpc-platform-core-intel-runtime-advisory intel-hpc-platform-compat-hpc-advisory
                                                intel-hpc-platform-core intel-hpc-platform-core-advisory intel-hpc-platform-hpc-cluster
                                                intel-hpc-platform-compat-hpc intel-hpc-platform-core-intel-runtime)
default['cluster']['intelhpc']['version'] = '2018.0-7'
default['cluster']['intelhpc']['dependencies'] = %w(compat-libstdc++-33 nscd nss-pam-ldapd openssl098e)
default['cluster']['intelpython2']['version'] = '2019.4-088'
default['cluster']['intelpython3']['version'] = '2020.2-902'

# Intel MPI
default['cluster']['intelmpi']['version'] = '2021.6.0'
default['cluster']['intelmpi']['full_version'] = "#{node['cluster']['intelmpi']['version']}.602"
default['cluster']['intelmpi']['modulefile'] = "/opt/intel/mpi/#{node['cluster']['intelmpi']['version']}/modulefiles/mpi"
default['cluster']['intelmpi']['kitchen_test_string'] = 'Version 2021.6'
default['cluster']['intelmpi']['qt_version'] = '5.15.2'

# Arm Performance Library
default['cluster']['armpl']['major_minor_version'] = '21.0'
default['cluster']['armpl']['patch_version'] = '0'
default['cluster']['armpl']['version'] = "#{node['cluster']['armpl']['major_minor_version']}.#{node['cluster']['armpl']['patch_version']}"

default['cluster']['armpl']['gcc']['major_minor_version'] = '9.3'
default['cluster']['armpl']['gcc']['patch_version'] = '0'
default['cluster']['armpl']['gcc']['url'] = [
  'https://ftp.gnu.org/gnu/gcc',
  "gcc-#{node['cluster']['armpl']['gcc']['major_minor_version']}.#{node['cluster']['armpl']['gcc']['patch_version']}",
  "gcc-#{node['cluster']['armpl']['gcc']['major_minor_version']}.#{node['cluster']['armpl']['gcc']['patch_version']}.tar.gz",
].join('/')
default['cluster']['armpl']['platform'] = value_for_platform(
  'centos' => { '~>7' => 'RHEL-7' },
  'amazon' => { '2' => 'RHEL-8' },
  'redhat' => { 'default' => 'RHEL-8' },
  'ubuntu' => {
    '18.04' => 'Ubuntu-18.04',
    '20.04' => 'Ubuntu-20.04',
  }
)
default['cluster']['armpl']['url'] = [
  'archives/armpl',
  node['cluster']['armpl']['platform'],
  "arm-performance-libraries_#{node['cluster']['armpl']['version']}_#{node['cluster']['armpl']['platform']}_gcc-#{node['cluster']['armpl']['gcc']['major_minor_version']}.tar",
].join('/')

# URLs to software packages used during install recipes
default['cluster']['slurm_plugin_dir'] = '/etc/parallelcluster/slurm_plugin'
default['cluster']['slurm']['fleet_config_path'] = "#{node['cluster']['slurm_plugin_dir']}/fleet-config.json"
# Slurm
default['cluster']['slurm']['user'] = 'slurm'
default['cluster']['slurm']['user_id'] = node['cluster']['reserved_base_uid'] + 1
default['cluster']['slurm']['group'] = node['cluster']['slurm']['user']
default['cluster']['slurm']['group_id'] = node['cluster']['slurm']['user_id']
# Munge
default['cluster']['munge']['user'] = 'munge'
default['cluster']['munge']['user_id'] = node['cluster']['reserved_base_uid'] + 2
default['cluster']['munge']['group'] = node['cluster']['munge']['user']
default['cluster']['munge']['group_id'] = node['cluster']['munge']['user_id']

# Scheduler plugin Configuration
default['cluster']['scheduler_plugin']['name'] = 'pcluster-scheduler-plugin'
default['cluster']['scheduler_plugin']['user'] = default['cluster']['scheduler_plugin']['name']
default['cluster']['scheduler_plugin']['user_id'] = node['cluster']['reserved_base_uid'] + 4
default['cluster']['scheduler_plugin']['group'] = default['cluster']['scheduler_plugin']['user']
default['cluster']['scheduler_plugin']['group_id'] = default['cluster']['scheduler_plugin']['user_id']

default['cluster']['scheduler_plugin']['system_user_id_start'] = node['cluster']['reserved_base_uid'] + 10
default['cluster']['scheduler_plugin']['system_group_id_start'] = default['cluster']['scheduler_plugin']['system_user_id_start']

# Scheduler plugin event handler
default['cluster']['scheduler_plugin']['home'] = '/home/pcluster-scheduler-plugin'
default['cluster']['scheduler_plugin']['handler_log_out'] = "#{node['cluster']['log_base_dir']}/scheduler-plugin.out.log"
default['cluster']['scheduler_plugin']['handler_log_err'] = "#{node['cluster']['log_base_dir']}/scheduler-plugin.err.log"
default['cluster']['scheduler_plugin']['shared_dir'] = "#{node['cluster']['shared_dir']}/scheduler-plugin"
default['cluster']['scheduler_plugin']['local_dir'] = "#{node['cluster']['base_dir']}/scheduler-plugin"
default['cluster']['scheduler_plugin']['handler_dir'] = "#{node['cluster']['scheduler_plugin']['local_dir']}/.configs"
default['cluster']['scheduler_plugin']['scheduler_plugin_substack_outputs_path'] = "#{node['cluster']['shared_dir']}/scheduler-plugin-substack-outputs.json"
default['cluster']['scheduler_plugin']['python_version'] = '3.9.16'
default['cluster']['scheduler_plugin']['pyenv_root'] = "#{node['cluster']['scheduler_plugin']['shared_dir']}/pyenv"
default['cluster']['scheduler_plugin']['virtualenv'] = 'scheduler_plugin_virtualenv'
default['cluster']['scheduler_plugin']['virtualenv_path'] = [
  node['cluster']['scheduler_plugin']['pyenv_root'],
  'versions',
  node['cluster']['scheduler_plugin']['python_version'],
  'envs',
  node['cluster']['scheduler_plugin']['virtualenv'],
].join('/')

# NVIDIA
default['cluster']['nvidia']['enabled'] = 'no'
default['cluster']['nvidia']['driver_version'] = '470.141.03'
default['cluster']['nvidia']['cuda_version'] = '11.7'
default['cluster']['nvidia']['cuda_samples_version'] = '11.6'
default['cluster']['nvidia']['driver_url_architecture_id'] = arm_instance? ? 'aarch64' : 'x86_64'
default['cluster']['nvidia']['cuda_url_architecture_id'] = arm_instance? ? 'linux_sbsa' : 'linux'
default['cluster']['nvidia']['driver_url'] = "https://us.download.nvidia.com/tesla/#{node['cluster']['nvidia']['driver_version']}/NVIDIA-Linux-#{node['cluster']['nvidia']['driver_url_architecture_id']}-#{node['cluster']['nvidia']['driver_version']}.run"
default['cluster']['nvidia']['cuda_url'] = "https://developer.download.nvidia.com/compute/cuda/11.7.1/local_installers/cuda_11.7.1_515.65.01_#{node['cluster']['nvidia']['cuda_url_architecture_id']}.run"
default['cluster']['nvidia']['cuda_samples_url'] = "https://github.com/NVIDIA/cuda-samples/archive/refs/tags/v#{node['cluster']['nvidia']['cuda_samples_version']}.tar.gz"

# NVIDIA fabric-manager
# The package name of Fabric Manager for alinux2 and centos7 is nvidia-fabric-manager-version
# For ubuntu, it is nvidia-fabricmanager-470_version
default['cluster']['nvidia']['fabricmanager']['package'] = value_for_platform(
  'default' => "nvidia-fabric-manager",
  'ubuntu' => { 'default' => "nvidia-fabricmanager-470" }
)
default['cluster']['nvidia']['fabricmanager']['repository_key'] = value_for_platform(
  'default' => "D42D0685.pub",
  'ubuntu' => { 'default' => "3bf863cc.pub" }
)
default['cluster']['nvidia']['fabricmanager']['version'] = value_for_platform(
  'default' => node['cluster']['nvidia']['driver_version'],
  # with apt a star is needed to match the package version
  'ubuntu' => { 'default' => "#{node['cluster']['nvidia']['driver_version']}*" }
)
default['cluster']['nvidia']['fabricmanager']['repository_uri'] = value_for_platform(
  'default' => "https://developer.download.nvidia._domain_/compute/cuda/repos/rhel7/x86_64",
  'ubuntu' => { 'default' => "https://developer.download.nvidia._domain_/compute/cuda/repos/#{node['cluster']['base_os']}/x86_64" }
)

# NVIDIA GDRCopy
default['cluster']['nvidia']['gdrcopy']['version'] = '2.3'
default['cluster']['nvidia']['gdrcopy']['url'] = "https://github.com/NVIDIA/gdrcopy/archive/refs/tags/v#{node['cluster']['nvidia']['gdrcopy']['version']}.tar.gz"
default['cluster']['nvidia']['gdrcopy']['sha256'] = 'b85d15901889aa42de6c4a9233792af40dd94543e82abe0439e544c87fd79475'
default['cluster']['nvidia']['gdrcopy']['service'] = value_for_platform(
  'ubuntu' => { 'default' => 'gdrdrv' },
  'default' => 'gdrcopy'
)

# EFS Utils
default['cluster']['efs_utils']['version'] = '1.34.1'
default['cluster']['efs_utils']['url'] = "https://github.com/aws/efs-utils/archive/v#{node['cluster']['efs_utils']['version']}.tar.gz"
default['cluster']['efs_utils']['sha256'] = '69d0d8effca3b58ccaf4b814960ec1d16263807e508b908975c2627988c7eb6c'
default['cluster']['efs_utils']['tarball_path'] = "#{node['cluster']['sources_dir']}/efs-utils-#{node['cluster']['efs_utils']['version']}.tar.gz"
default['cluster']['stunnel']['version'] = '5.67'
default['cluster']['stunnel']['url'] = "#{node['cluster']['artifacts_s3_url']}/stunnel/stunnel-#{node['cluster']['stunnel']['version']}.tar.gz"
default['cluster']['stunnel']['sha256'] = '3086939ee6407516c59b0ba3fbf555338f9d52f459bcab6337c0f00e91ea8456'
default['cluster']['stunnel']['tarball_path'] = "#{node['cluster']['sources_dir']}/stunnel-#{node['cluster']['stunnel']['version']}.tar.gz"

# NICE DCV
default['cluster']['dcv_port'] = 8443
default['cluster']['dcv']['installed'] = 'yes'
default['cluster']['dcv']['version'] = '2022.1-13300'
if arm_instance?
  default['cluster']['dcv']['supported_os'] = %w(centos7 ubuntu18 amazon2)
  default['cluster']['dcv']['url_architecture_id'] = 'aarch64'
  default['cluster']['dcv']['sha256sum'] = value_for_platform(
    'centos' => {
      '~>7' => "62bea89c151c3ad840a9ffd17271227b6a51909e5529a4ff3ec401b37fde1667",
    },
    'amazon' => { '2' => "62bea89c151c3ad840a9ffd17271227b6a51909e5529a4ff3ec401b37fde1667" },
    'ubuntu' => { '18.04' => "cf0d5259254bed4f9777cc64b151e3faa1b4e2adffdf2be5082e64c744ba5b3b" }
  )
else
  default['cluster']['dcv']['supported_os'] = %w(centos7 ubuntu18 ubuntu20 amazon2)
  default['cluster']['dcv']['url_architecture_id'] = 'x86_64'
  default['cluster']['dcv']['sha256sum'] = value_for_platform(
    'centos' => {
      '~>7' => "fe782c3ff6a1fd9291f7dcca0eadeec7cce47f1ae13d2da97fbed714fe00cf4d",
    },
    'amazon' => { '2' => "fe782c3ff6a1fd9291f7dcca0eadeec7cce47f1ae13d2da97fbed714fe00cf4d" },
    'ubuntu' => {
      '18.04' => "db15078bacfb01c0583b1edd541031f31085f07beeca66fc0131225da2925def",
      '20.04' => "2e8c4a58645f3f91987b2b1086de5d46cf1c686c34046d57ee0e6f1e526a3031",
    }
  )
end
if platform?('ubuntu')
  # Unlike the other supported OSs, the DCV package names for Ubuntu use different architecture abbreviations than those used in the download URLs.
  default['cluster']['dcv']['package_architecture_id'] = arm_instance? ? 'arm64' : 'amd64'
end
default['cluster']['dcv']['package'] = value_for_platform(
  'centos' => {
    '~>7' => "nice-dcv-#{node['cluster']['dcv']['version']}-el7-#{node['cluster']['dcv']['url_architecture_id']}",
  },
  'amazon' => { '2' => "nice-dcv-#{node['cluster']['dcv']['version']}-el7-#{node['cluster']['dcv']['url_architecture_id']}" },
  'ubuntu' => {
    'default' => "nice-dcv-#{node['cluster']['dcv']['version']}-#{node['cluster']['base_os']}-#{node['cluster']['dcv']['url_architecture_id']}",
  }
)
default['cluster']['dcv']['server']['version'] = '2022.1.13300-1'
default['cluster']['dcv']['server'] = value_for_platform( # NICE DCV server package
  'centos' => {
    '~>7' => "nice-dcv-server-#{node['cluster']['dcv']['server']['version']}.el7.#{node['cluster']['dcv']['url_architecture_id']}.rpm",
  },
  'amazon' => { '2' => "nice-dcv-server-#{node['cluster']['dcv']['server']['version']}.el7.#{node['cluster']['dcv']['url_architecture_id']}.rpm" },
  'ubuntu' => {
    'default' => "nice-dcv-server_#{node['cluster']['dcv']['server']['version']}_#{node['cluster']['dcv']['package_architecture_id']}.#{node['cluster']['base_os']}.deb",
  }
)
default['cluster']['dcv']['xdcv']['version'] = '2022.1.433-1'
default['cluster']['dcv']['xdcv'] = value_for_platform( # required to create virtual sessions
  'centos' => {
    '~>7' => "nice-xdcv-#{node['cluster']['dcv']['xdcv']['version']}.el7.#{node['cluster']['dcv']['url_architecture_id']}.rpm",
  },
  'amazon' => { '2' => "nice-xdcv-#{node['cluster']['dcv']['xdcv']['version']}.el7.#{node['cluster']['dcv']['url_architecture_id']}.rpm" },
  'ubuntu' => {
    'default' => "nice-xdcv_#{node['cluster']['dcv']['xdcv']['version']}_#{node['cluster']['dcv']['package_architecture_id']}.#{node['cluster']['base_os']}.deb",
  }
)
default['cluster']['dcv']['gl']['version'] = '2022.1.973-1'
default['cluster']['dcv']['gl']['installer'] = value_for_platform( # required to enable GPU sharing
  'centos' => {
    '~>7' => "nice-dcv-gl-#{node['cluster']['dcv']['gl']['version']}.el7.#{node['cluster']['dcv']['url_architecture_id']}.rpm",
  },
  'amazon' => { '2' => "nice-dcv-gl-#{node['cluster']['dcv']['gl']['version']}.el7.#{node['cluster']['dcv']['url_architecture_id']}.rpm" },
  'ubuntu' => {
    'default' => "nice-dcv-gl_#{node['cluster']['dcv']['gl']['version']}_#{node['cluster']['dcv']['package_architecture_id']}.#{node['cluster']['base_os']}.deb",
  }
)
default['cluster']['dcv']['web_viewer']['version'] = '2022.1.13300-1'
default['cluster']['dcv']['web_viewer'] = value_for_platform( # required to enable WEB client
  'centos' => {
    '~>7' => "nice-dcv-web-viewer-#{node['cluster']['dcv']['web_viewer']['version']}.el7.#{node['cluster']['dcv']['url_architecture_id']}.rpm",
  },
  'amazon' => { '2' => "nice-dcv-web-viewer-#{node['cluster']['dcv']['web_viewer']['version']}.el7.#{node['cluster']['dcv']['url_architecture_id']}.rpm" },
  'ubuntu' => {
    'default' => "nice-dcv-web-viewer_#{node['cluster']['dcv']['web_viewer']['version']}_#{node['cluster']['dcv']['package_architecture_id']}.#{node['cluster']['base_os']}.deb",
  }
)
default['cluster']['dcv']['url'] = "https://d1uj6qtbmh3dt5.cloudfront.net/2022.1/Servers/#{node['cluster']['dcv']['package']}.tgz"
# DCV external authenticator configuration
default['cluster']['dcv']['authenticator']['user'] = "dcvextauth"
default['cluster']['dcv']['authenticator']['user_id'] = node['cluster']['reserved_base_uid'] + 3
default['cluster']['dcv']['authenticator']['group'] = node['cluster']['dcv']['authenticator']['user']
default['cluster']['dcv']['authenticator']['group_id'] = node['cluster']['dcv']['authenticator']['user_id']
default['cluster']['dcv']['authenticator']['user_home'] = "/home/#{node['cluster']['dcv']['authenticator']['user']}"
default['cluster']['dcv']['authenticator']['certificate'] = "/etc/parallelcluster/ext-auth-certificate.pem"
default['cluster']['dcv']['authenticator']['private_key'] = "/etc/parallelcluster/ext-auth-private-key.pem"
default['cluster']['dcv']['authenticator']['virtualenv'] = "dcv_authenticator_virtualenv"
default['cluster']['dcv']['authenticator']['virtualenv_path'] = [
  node['cluster']['system_pyenv_root'],
  'versions',
  node['cluster']['python-version'],
  'envs',
  node['cluster']['dcv']['authenticator']['virtualenv'],
].join('/')

# CloudWatch Agent
default['cluster']['cloudwatch']['public_key_url'] = "https://s3.amazonaws.com/amazoncloudwatch-agent/assets/amazon-cloudwatch-agent.gpg"
default['cluster']['cloudwatch']['public_key_local_path'] = "#{node['cluster']['sources_dir']}/amazon-cloudwatch-agent.gpg"

# OpenSSH settings for AWS ParallelCluster instances
default['openssh']['server']['protocol'] = '2'
default['openssh']['server']['syslog_facility'] = 'AUTHPRIV'
default['openssh']['server']['permit_root_login'] = 'forced-commands-only'
default['openssh']['server']['password_authentication'] = 'no'
default['openssh']['server']['gssapi_authentication'] = 'yes'
default['openssh']['server']['gssapi_clean_up_credentials'] = 'yes'
default['openssh']['server']['ciphers'] = 'aes128-cbc,aes192-cbc,aes256-cbc,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com'
default['openssh']['server']['m_a_cs'] = 'hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256'
default['openssh']['client']['gssapi_authentication'] = 'yes'
default['openssh']['client']['match'] = 'exec "ssh_target_checker.sh %h"'
# Disable StrictHostKeyChecking for target host in the cluster VPC
default['openssh']['client']['  _strict_host_key_checking'] = 'no'
# Do not store server key in the know hosts file to avoid scaling clashing
# that is when an new host gets the same IP of a previously terminated host
default['openssh']['client']['  _user_known_hosts_file'] = '/dev/null'

# ulimit settings
default['cluster']['filehandle_limit'] = 10_000
default['cluster']['memory_limit'] = 'unlimited'

# Default NFS mount options
default['cluster']['nfs']['hard_mount_options'] = 'hard,_netdev,noatime'
# For performance, set NFS threads to min(256, max(8, num_cores * 4))
default['cluster']['nfs']['threads'] = [[node['cpu']['cores'].to_i * 4, 8].max, 256].min

# ParallelCluster internal variables (also in /etc/parallelcluster/cfnconfig)
default['cluster']['region'] = 'us-east-1'
default['cluster']['stack_name'] = nil
default['cluster']['preinstall'] = 'NONE'
default['cluster']['preinstall_args'] = 'NONE'
default['cluster']['postinstall'] = 'NONE'
default['cluster']['postinstall_args'] = 'NONE'
default['cluster']['postupdate'] = 'NONE'
default['cluster']['postupdate_args'] = 'NONE'
default['cluster']['scheduler'] = 'slurm'
default['cluster']['scheduler_slots'] = 'vcpus'
default['cluster']['scheduler_queue_name'] = nil
default['cluster']['instance_slots'] = '1'
default['cluster']['ephemeral_dir'] = '/scratch'
default['cluster']['proxy'] = 'NONE'
default['cluster']['node_type'] = nil
default['cluster']['cluster_user'] = 'ec2-user'
default['cluster']['head_node_private_ip'] = nil
default['cluster']['volume'] = ''

# ParallelCluster internal variables to configure active directory service
default['cluster']["directory_service"]["enabled"] = 'false'
default['cluster']["directory_service"]["domain_name"] = nil
default['cluster']["directory_service"]["domain_addr"] = nil
default['cluster']["directory_service"]["password_secret_arn"] = nil
default['cluster']["directory_service"]["domain_read_only_user"] = nil
default['cluster']["directory_service"]["ldap_tls_ca_cert"] = nil
default['cluster']["directory_service"]["ldap_tls_req_cert"] = nil
default['cluster']["directory_service"]["ldap_access_filter"] = nil
default['cluster']["directory_service"]["generate_ssh_keys_for_users"] = nil
default['cluster']['directory_service']['additional_sssd_configs'] = nil
default['cluster']['directory_service']['disabled_on_compute_nodes'] = nil

# Other ParallelCluster internal variables
default['cluster']['ddb_table'] = nil
default['cluster']['slurm_ddb_table'] = nil
default['cluster']['log_group_name'] = "NONE"
default['cluster']['volume_fs_type'] = 'ext4'
default['cluster']['efs_shared_dirs'] = ''
default['cluster']['efs_fs_ids'] = ''
default['cluster']['efs_encryption_in_transits'] = ''
default['cluster']['efs_iam_authorizations'] = ''
default['cluster']['cluster_admin_user'] = 'pcluster-admin'
default['cluster']['cluster_admin_user_id'] = node['cluster']['reserved_base_uid']
default['cluster']['cluster_admin_group'] = node['cluster']['cluster_admin_user']
default['cluster']['cluster_admin_group_id'] = node['cluster']['cluster_admin_user_id']
default['cluster']['fsx_shared_dirs'] = ''
default['cluster']['fsx_fs_ids'] = ''
default['cluster']['fsx_dns_names'] = ''
default['cluster']['fsx_mount_names'] = ''
default['cluster']['fsx_fs_types'] = ''
default['cluster']['fsx_volume_junction_paths'] = ''
default['cluster']['custom_node_package'] = nil
default['cluster']['custom_awsbatchcli_package'] = nil
default['cluster']['raid_type'] = ''
default['cluster']['raid_vol_ids'] = ''
default['cluster']['dns_domain'] = nil
default['cluster']['use_private_hostname'] = 'false'
default['cluster']['skip_install_recipes'] = 'yes'
default['cluster']['enable_nss_slurm'] = node['cluster']['directory_service']['enabled']
default['cluster']['realmemory_to_ec2memory_ratio'] = 0.95
default['cluster']['slurm_node_reg_mem_percent'] = 75
default['cluster']['slurmdbd_response_retries'] = 30
default['cluster']['slurm_plugin_console_logging']['sample_size'] = 1

# Official ami build
default['cluster']['is_official_ami_build'] = false

# Additional instance types data
default['cluster']['instance_types_data'] = nil

# IMDS
default['cluster']['head_node_imds_secured'] = 'true'
default['cluster']['head_node_imds_allowed_users'] = ['root', node['cluster']['cluster_admin_user'], node['cluster']['cluster_user']]
default['cluster']['head_node_imds_allowed_users'].append('dcv') if node['cluster']['dcv_enabled'] == 'head_node' && platform_supports_dcv?
default['cluster']['head_node_imds_allowed_users'].append(node['cluster']['scheduler_plugin']['user']) if node['cluster']['scheduler'] == 'plugin'

# Compute nodes bootstrap timeout
default['cluster']['compute_node_bootstrap_timeout'] = 1800
