# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

SearchApp::Application.load_tasks

ZIP_URL = "https://github.com/projectblacklight/blacklight-jetty/archive/v4.6.0.zip"
require 'jettywrapper'

namespace :solr do
  desc "Copies the default SOLR config for the bundled Testing Server"
  task :configure => ['jetty:clean'] do
    FileList['solr_conf/conf/*'].each do |f|  
      cp("#{f}", File.expand_path('solr/blacklight-core/conf/', Jettywrapper.jetty_dir), :verbose => true)
    end
  end

  desc "Load fixtures"
  task :fixtures => [:environment] do
    data =  Dir.chdir(Rails.root) do
      `gunzip -c spec/fixtures/artwork_data.csv.gz`
    end
    
    Blacklight.solr.update data: data, params: { commit: true, overwrite: true }, headers: { 'Content-Type' => 'application/csv' }
  end
end
