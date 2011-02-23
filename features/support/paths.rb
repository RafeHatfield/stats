module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /a test article/
      article_id = @article_id
      visited_at = CGI::escape(Time.now.to_s)
      pv = FactoryGirl.attributes_for(:raw_page_view)
      "/add_page_view?tracked_page_id=#{article_id}&page_url=pv[:page_url]&page_title=pv[:page_title]&writer_id=pv[:writer_id]&cookie_id=[:cookie_id]&visited_at=#{visited_at}&referrer_url=pv[:referrer_url]"
    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)