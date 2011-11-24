xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Feed of #{@user.name}"
    xml.description "Rails. Feed of user."
    #xml.link users_url :rss

    number_of_post = @microposts.size                                         #Last post has last number.
    for post in @microposts
      xml.item do
        xml.title number_of_post
        xml.description post.content
        xml.pubDate post.created_at.to_s(:rfc822)
      end
      number_of_post -= 1
    end
  end
end
