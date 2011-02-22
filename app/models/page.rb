# class Page < Ohm::Model
#   include Ohm::Boundaries
#   
#   attribute :writer_id
#   attribute :page_title
#   attribute :page_url
#   attribute :tracked_page_id
#   collection :page_views, PageView
#   
#   counter :total_view_count
#   index :tracked_page_id
#   index :writer_id
#   
#   def validate
#     assert_present :page_title
#     assert_present :tracked_page_id
#     assert_present :page_url
#     assert_present :writer_id
#     assert_unique :tracked_page_id
#   end
#   
#   def insert_page_view(pv_hash)
#     if unique_page_view?(pv_hash[:cookie_id])
#       pv_hash[:visited_at] ||= Time.now
#       pv_hash[:page_id] = self.id
#       self.page_views << PageView.create(pv_hash)
#       incr(:total_view_count)
#     end
#   end
#   
#   # Get an array of the least viewed pages which belong
#   # to the given writer.
#   def self.least_viewed_for(writer_id, limit)
#     Page.pages_for_writer(writer_id).sort_by(:total_view_count, :limit => limit)
#   end  
#   
#   def self.total_page_views_for(writer_id)
#     views = 0
#     Page.pages_for_writer(writer_id).each do |page|
#       views += page.total_view_count
#     end
#     return views
#   end
#   
#   def self.find_or_create_by_tracked_page_id(tracked_page_id, params)
#     page_set = Page.find(:tracked_page_id => tracked_page_id)
#     if page_set.empty?
#       Page.create(params)
#     else
#       page_set.first
#     end
#   end
#   
#   private
#   
#   # Would a new view with the identifier "cookie_id" be unique?
#   def unique_page_view?(cookie_id)
#     last_user_page_view = self.page_views.find(:cookie_id => cookie_id).all.last
#     last_user_page_view.blank? || Time.parse(last_user_page_view.visited_at) < 30.minutes.ago
#   end
#   
#   def self.pages_for_writer(writer_id)
#     Page.find(:writer_id => writer_id)
#   end
# end
