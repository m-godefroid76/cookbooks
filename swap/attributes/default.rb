#
# Cookbook Name:: cookbook-swap
# Recipe:: default
#
# Copyright 2012, Kevin Bringard
# Copyright 2012-2013, John Dewey
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

# Where should we create the swapfile on disk?
default['create-swap']['swap-location'] = '/mnt/swapfile'

# How big should we make the swap file (in gigabytes)
default['create-swap']['swap-size'] = 8 # In gigabytes
