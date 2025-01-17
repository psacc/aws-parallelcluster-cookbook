user = "pcluster-admin"

control 'admin_user_created' do
  title 'Configure cluster admin user'

  describe command("grep #{user} /etc/passwd") do
    its('stdout.strip') { should eq "#{user}:x:400:400:AWS ParallelCluster Admin user:/home/#{user}:/bin/bash" }
  end

  describe user(user) do
    its(:gid) { should eq 400 }
    its(:group) { should eq "pcluster-admin" }
  end
end

control 'ulimit_configured' do
  title 'Configure soft ulimit nofile'
  describe limits_conf("/etc/security/limits.d/00_all_limits.conf") do
    its('*') { should include ['-', 'nofile', "10000"] }
  end
end
