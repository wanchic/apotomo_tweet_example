class Twitter::PanelWidget < Apotomo::Widget
  responds_to_event :newTweet, with: :redraw_list

  after_initialize do
    root.respond_to_event :tweetDeleted, with: :redraw, on: widget_id
  end

  has_widgets do
    for t in Tweet.all
      self << widget('tweet', "tweet-#{t.id}", tweet: t)
    end

    self << widget('twitter/form', :tweet_form)
  end

  def display
    @tweets = Tweet.all
    render
  end

  def list(tweets)
    render locals: { tweets: tweets }
  end

  def redraw_list(evt)
    #@tweets = Tweet.all
    #replace "##{widget_id} ul", { state: :list}, @tweets
    render text: "$(\"##{widget_id} ul\").append(\"<li>#{evt[:tweet].text}</li>\");"
  end

end
