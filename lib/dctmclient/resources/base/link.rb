module Dctmclient
  module Resources
    class Link
      attr_reader :relation
      attr_accessor :href

      LINK_REL_PREFIX = 'http://identifiers.emc.com/linkrel/'

      RELATIONS = {
          :self => 'self',
          :edit => 'edit',
          :delete => LINK_REL_PREFIX + 'delete',
          :cabinets => LINK_REL_PREFIX + 'cabinets',
          :cabinet => LINK_REL_PREFIX + 'cabinet',
          :users => LINK_REL_PREFIX + 'users',
          :default_folder => LINK_REL_PREFIX + 'default-folder',
          :groups => LINK_REL_PREFIX + 'groups',
          :checked_out_objects => LINK_REL_PREFIX + 'checked-out-objects',
          :current_user => LINK_REL_PREFIX + 'current-user',
          :formats => LINK_REL_PREFIX + 'formats',
          :network_locations => LINK_REL_PREFIX + 'network-locations',
          :relations => LINK_REL_PREFIX + 'relations',
          :relation_types => LINK_REL_PREFIX + 'relation-types',
          :sys_objects => LINK_REL_PREFIX + 'objects',
          :documents => LINK_REL_PREFIX + 'documents',
          :folders => LINK_REL_PREFIX + 'folders',
          :repositories => LINK_REL_PREFIX + 'repositories',
          :batch_capabilities => LINK_REL_PREFIX + 'batch-capabilities',
          :dql => LINK_REL_PREFIX + 'dql',
          :types => LINK_REL_PREFIX + 'types',
          :batches => LINK_REL_PREFIX + 'batches',
          :contents => 'contents',
          :versions => 'version-history',
          :current_version => LINK_REL_PREFIX + 'current-version',
          :check_out => LINK_REL_PREFIX + 'checkout',
          :cancel_check_out => LINK_REL_PREFIX + 'cancel-checkout',
          :check_in_next_major => LINK_REL_PREFIX + 'checkin-next-major',
          :check_in_next_minor => LINK_REL_PREFIX + 'checkin-next-minor',
          :check_in_branch_version => LINK_REL_PREFIX + 'branch-version',
          :parent_links => LINK_REL_PREFIX + 'parent-links',
          :child_links => LINK_REL_PREFIX + 'child-links',
          :search => LINK_REL_PREFIX + 'search',
          :first => 'first',
          :next => 'next',
          :previous => 'previous',
          :last => 'last',
          :comments => LINK_REL_PREFIX + 'comments',
          :replies => LINK_REL_PREFIX + 'replies'
      }

      def initialize(relation, href)
        @relation = relation
        @href = href
      end
    end
  end
end