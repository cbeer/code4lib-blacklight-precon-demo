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
    
    config.add_index_field 'artist_t', label: "Artist"
    config.add_index_field 'medium_s', label: "Medium"
    config.add_index_field 'dimensions_s', label: "Dimensions"
    config.add_index_field 'year_s', label: "Year"
    
    config.show_fields.merge!(config.index_fields)
    
    config.add_show_field 'creditLine_t', label: "Credit"
    config.add_show_field 'thumbnailCopyright_s', label: "Thumbnail credit"
    config.add_show_field 'acquisitionYear_s', label: "Acquired"
    config.add_show_field 'accession_number_s', label: "Accession number"
    
    
    # 'all fields' performs the default search given above
    config.add_search_field 'All Fields'
    
    # A title search, configured using the hash syntax
    config.add_search_field 'Title', solr_parameters: { qf: 'title_t' }

    # For some configuration, the block-based syntax may be better
    config.add_search_field 'Artist' do |field|
      field.solr_parameters = { qf: 'artist_t' }
    end
    
    config.add_sort_field 'relevancy', sort: 'score desc', label: 'relevancy'
    config.add_sort_field 'id', sort: 'id asc', label: 'identifier'
    config.add_sort_field 'year', sort: 'year_s asc, id asc', label: 'year'
    config.add_sort_field 'width', sort: 'width_s asc', label: 'width'
    # the schema doesn't have a single-valued sort field, or we could do something like:
    # config.add_sort_field 'title', sort: 'title_t asc, id asc', label: 'title'

    config.add_fields_to_solr_request!
  end

end 
