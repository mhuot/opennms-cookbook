if platform?("redhat", "centos", "oracle")
  package_name = "opennms-repo-#{node[:opennms][:release]}-rhel#{node[:platform_version].chr}.noarch.rpm"
  remote_file "#{Chef::Config[:file_cache_path]}/#{package_name}" do
    source "http://yum.opennms.org/repofiles/#{package_name}"
    not_if "rpm -qa | grep -q '^opennms-repo-#{node[:opennms][:release]}'"
    notifies :install, "rpm_package[opennms]", :immediately
  end
  rpm_package "opennms" do
    source "#{Chef::Config[:file_cache_path]}/#{package_name}" 
    only_if {::File.exists?("#{Chef::Config[:file_cache_path]}/#{package_name}")} 
    action :install
  end
end
if platform?("fedora")
  package_name = "opennms-repo-#{node[:opennms][:release]}-fc#{node[:platform_version]}.noarch.rpm"
  remote_file "#{Chef::Config[:file_cache_path]}/#{package_name}" do
    source "http://yum.opennms.org/repofiles/#{package_name}"
    not_if "rpm -qa | grep -q '^opennms-repo-#{node[:opennms][:release]}'"
    notifies :install, "rpm_package[opennms]", :immediately
  end
  rpm_package "opennms" do
    source "#{Chef::Config[:file_cache_path]}/#{package_name}" 
    only_if {::File.exists?("#{Chef::Config[:file_cache_path]}/#{package_name}")} 
    action :install
  end
end
if platform?("scientific", "fedora", "amazon")
end
  # Don't know what to do with this yet :-)
if platform?("ubuntu", "debian")
  include_recipe "apt::default"
  apt_repository "opennms" do
    uri "http://debian.opennms.org"
    components [node[:onmsrepo][:release], "main"]
    key "http://debian.opennms.org/OPENNMS-GPG-KEY"
    deb_src true
    action :add
    notifies :run, resources(:execute => "apt-get update"), :immediately
  end
end
