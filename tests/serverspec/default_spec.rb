require "spec_helper"
require "serverspec"

config_dir = "/etc/ssh"
ssh_config = "#{config_dir}/ssh_config"
ssh_known_hosts = "#{config_dir}/ssh_known_hosts"
keys = [
  "anoncvs.au.openbsd.org ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBKDCcpTR+00ygfH+7WnZGWUKWrDvH1gaXkBeyGaVkPLf73mIJEuaCwh0aWalf+ccc76VWj6CRLnC6W3Mj/9VK7U=",
  "anoncvs.ca.openbsd.org ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCz6RLtgGksBp/0dH7M5vGCUxgD31+wX28tnLlij90+cYhjELDV3HX95DypEA7xfIN6W8Vg/GOJkX4Oot+zpQXNQx3VeOyMgcn4KXO83XYGsPVfJQijjzyI0r0/ztEsxYAE6JHEiEvY9floDnNRyoFLVETNE5oB9yBcDIt6W6BYjlpXqJNsEPy7ij+kBbEk7QT0FcyFidp7FmExsOQy23nhQ55A/6fB7ATsDQtz+snniF9ZJg5+b71SYzxfhUPkxJhmhBkx7NmPnRjy7eE0I7qrHODrHONIi1LWCo0joTIAfVgxhEn5SDbviTAINAecGgis5LQqXp0xSupfWuozZeXV",
  "github.com ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ=="
]
default_user = "root"
default_group = "root"

case os[:family]
when "freebsd"
  default_group = "wheel"
when "openbsd"
  default_group = "wheel"
end

describe file(ssh_config) do
  it { should exist }
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by default_user }
  it { should be_grouped_into default_group }
end

describe file(ssh_known_hosts) do
  it { should exist }
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by default_user }
  it { should be_grouped_into default_group }
  keys.each do |k|
    its(:content) { should match(/^#{Regexp.escape(k)}$/) }
  end
end

describe file(ssh_config) do
  it { should exist }
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by default_user }
  it { should be_grouped_into default_group }
  its(:content) { should match(/^Port 22$/) }
  its(:content) { should match(/^Protocol 2$/) }
end
