#
# Cookbook Name:: celery
# Recipe:: default
#
# Copyright 2011, Needle Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "python"

directory node[:celery][:logdir]

template "/etc/logrotate.d/celery" do
  source "celery-logrotate.erb"
  owner "root"
  group "root"
  mode 0640
end

if node[:celery][:virtualenv]
  python_virtualenv node[:celery][:virtualenv] do
    action :create
  end
end

python_pip "celery" do
  action :install
  if node.has_attribute?("celery_virtualenv")
    virtualenv node[:celery][:virtualenv]
  end
  if node.has_attribute?("celery_version")
    version node[:celery][:version]
  end
end

python_pip "celerymon" do
  action :install
  if node.has_attribute?("celery_virtualenv")
    virtualenv node[:celery][:virtualenv]
  end
  if node.has_attribute?("celerymon_version")
    version node[:celery][:version]
  end
end
