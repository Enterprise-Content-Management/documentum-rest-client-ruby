module Dctmclient

  # This class is an abstraction for REST links, holding all the link relation names.
  class Link
    LINK_REL_PREFIX = 'http://identifiers.emc.com/linkrel/'

    REL_NAMES = {
        :self => 'self',
        :edit => 'edit',
        :contents => 'contents',
        :delete => LINK_REL_PREFIX + 'delete',
        :cabinets => LINK_REL_PREFIX + 'cabinets',
        :cabinet => LINK_REL_PREFIX + 'cabinet',
        :users => LINK_REL_PREFIX + 'users',
        :groups => LINK_REL_PREFIX + 'groups',
        :checked_out_objects => LINK_REL_PREFIX + 'checked-out-objects',
        :current_user => LINK_REL_PREFIX + 'current-user',
        :formats => LINK_REL_PREFIX + 'formats',
        :network_locations => LINK_REL_PREFIX + 'network-locations',
        :relations => LINK_REL_PREFIX + 'relations',
        :relation_types => LINK_REL_PREFIX + 'relation-types',
        :types => LINK_REL_PREFIX + 'types',
        :dql => LINK_REL_PREFIX + 'dql',
        :search => LINK_REL_PREFIX + 'search',
        :batches => LINK_REL_PREFIX + 'batches',
        :documents => LINK_REL_PREFIX + 'documents',
        :folders => LINK_REL_PREFIX + 'folders',
        :user_default_folder => LINK_REL_PREFIX + 'default-folder',
        :objects => LINK_REL_PREFIX + 'objects',
        :parent_links => LINK_REL_PREFIX + 'parent-links',
        :child_links => LINK_REL_PREFIX + 'child-links',
        :checkout => LINK_REL_PREFIX + 'checkout',
        :cancel_checkout => LINK_REL_PREFIX + 'cancel-checkout',
        :version_history => 'version-history',
        :current_version => LINK_REL_PREFIX + 'current-version',
        :checkin_next_major => LINK_REL_PREFIX + 'checkin-next-major',
        :checkin_next_minor => LINK_REL_PREFIX + 'checkin-next-minor',
        :predecessor_version => LINK_REL_PREFIX + 'predecessor-version',
        :batch_capabilities => LINK_REL_PREFIX + 'batch-capabilities',
        :first => 'first',
        :next => 'next',
        :previous => 'previous',
        :last => 'last'
    }

    attr_accessor :rel_name, :href


    def initialize(rel_name, href)
      @rel_name = rel_name
      @href = href
    end

    def rel_name
      return @rel_name
    end

    def href
      return @href
    end

    def rel_name= (rel_name)
      @rel_name=rel_name
    end

    def href= (href)
      @href=href
    end

    def empty?
      return @href.nil? || @href.empty?
    end
  end

end