module RecordsHelper

  def record_start_time(record)
    t = record.created_at
    Time.now - t < 7.day ? time_ago_in_words(t) + " ago" : "on " + t.strftime( "%b %d, %Y")
  end
 
  def record_owner_display(record)
    if params[:action] == "feed" 
      ("by " + link_to( record.user.name.capitalize, user_path(record.user) ) )
      .html_safe
    end
  end

  def record_content_head(record)
    content = h(record.content)
    # first take the 10 first lines, delete the blank lines, 
    # wrap it, then take the 3 first resulting lines
    content_preview = word_wrap( content.match( /(?:.*\n){0,10}[^\n]*/ )[0].gsub( /[\r\n]+/, "\n"),
                                 :line_width => 80 
                                 ).match( /(?:.*\n){0,2}[^\n]*/ )[0]
      content_preview += " ... " if (content_preview.length + 10 <= content.length)
      content_preview += '<span class="stats">(' + record.word_count + ' words)</span>' if record.word_count
    simple_format(content_preview ) 
  end

end
