case platform
when "redhat", "centos", "scientific", "fedora", "amazon", "oracle"
  default[:opennms][:jdk_package] = 'java-1.7.0-openjdk-devel' 
  default[:opennms][:opennms_home] = '/opt/opennms'
  default[:opennms][:pg_hba_location] = '/var/lib/pgsql/data/pg_hba.conf' # TODO: Need to validate location
when "debian", "ubuntu"
  default[:opennms][:jdk_package] = 'openjdk-7-jdk'
  default[:opennms][:opennms_home] = '/usr/share/opennms'
  default[:opennms][:pg_hba_location] = '/etc/postgresql/9.1/main/pg_hba.conf' #TODO: Need to make this detect and change version
end

default[:opennms][:pg_auth_method] = 'trust'
default[:opennms][:locale] = 'en_US.UTF-8'
default[:opennms][:release]  = 'stable' #stable, testing, unstable, snapshot, bleeding, opennms-1.12, etc
