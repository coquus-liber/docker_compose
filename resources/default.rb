# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html

property :tag, [String,nil], name_property: true

property :repo, String, default: "docker/compose"
property :bin, String, default: "/usr/local/bin/docker-compose"
property :mode, String, default: '0755'
property :file, String, default: "docker-compose-Linux-x86_64"

action_class do 
  require 'octokit'

  def client
    Octokit::Client.new
  end

  def r
    new_resource
  end

  def release
    case r.tag
    when "latest",:latest,"",nil
      client.latest_release(r.repo)
    else
      client.release_for_tag(r.repo,r.tag)
    end
  end

  def asset
    release.assets.select{|a| a['name'] == r.file}.first
  end

  def download_url
    asset.browser_download_url 
  end
end

action :create do
  package 'docker-compose' do
    action :remove
  end

  remote_file new_resource.bin do
    source download_url
    mode new_resource.mode
  end
end


