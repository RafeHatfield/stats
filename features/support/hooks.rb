Before do
  # Clear raw_page_view memcache
  RawPageView.uniqueness_cache.flush_all
end