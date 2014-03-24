# -*- encoding : utf-8 -*-
#
class CatalogController < ApplicationController  
  include Blacklight::Catalog

  configure_blacklight do |config|
    ## Default parameters to send to solr for all search-like requests. See also SolrHelper#solr_search_params
    config.default_solr_params = {
      qt: '',
      defType: 'edismax',
      echoParams: 'explicit',
      'q.alt' => '*:*',
      qf: 'id title_t^500 artist_t^20 creditLine_t^5 text',
      fl: '*'
    }
    
    ## Default parameters to send on single-document requests to Solr. These settings are the Blackligt defaults (see SolrHelper#solr_doc_params) or 
    ## parameters included in the Blacklight-jetty document requestHandler.
    #
    config.default_document_solr_params = {
    }
    
    config.document_solr_path = 'get'
    config.document_unique_id_param = 'ids'

    # solr field configuration for search results/index views
    config.index.title_field = 'title_t'
    
    config.per_page = [10,20,50,100]
    config.default_per_page = 20

    config.add_fields_to_solr_request!
  end

end 
