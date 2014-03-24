# -*- encoding : utf-8 -*-
class SolrDocument 

  include Blacklight::Solr::Document    

  def artist_name
    first('artist_t').split(/,\s+/).reverse.join " "
  end

  # self.unique_key = 'id'
  
end
