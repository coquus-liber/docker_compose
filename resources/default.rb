# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html

property :release, [String,nil], name_property: true

property :repo, String, default: lazy {|r| node['docker']['compose']['repo'] }
property :bin, String, default: lazy {|r| node['docker']['compose']['bin'] }
property :mode, String, default: lazy {|r| node['docker']['compose']['mode'] }
property :host, String, default: lazy {|r| node['docker']['compose']['host'] }
property :file, String, default: lazy {|r| node['docker']['compose']['file'] }
property :repo_url, String, default: lazy {|r| [r.host,r.repo].join('/') }
property :releases_url, String, default: lazy {|r| [r.repo_url,'releases'].join('/') }
property :download_url, String, default: lazy {|r| [r.releases_url,'download'].join('/') }
property :release_url, String, default: lazy {|r| [r.download_url,r.release].join('/') }
property :src_url, String, default: lazy {|r| [r.release_url,r.file].join('/') }

action :create do
  package 'docker-compose' do
    action :remove
  end

  remote_file new_resource.bin do
    source new_resource.src_url
    mode new_resource.mode
  end
end


