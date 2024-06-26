module SimpleDiscussion::ForumPostsHelper
  def category_link(category)
    link_to category.name, simple_discussion.forum_category_forum_threads_path(category),
      style: "color: #{category.color}"
  end

  # Override this method to provide your own content formatting like Markdown
  def formatted_content(text)
    simple_format(text)
  end

  def forum_post_classes(forum_post)
    klasses = ["forum-post", "card", "mb-3"]
    klasses << "solved" if forum_post.solved?
    klasses << "original-poster" if forum_post.user == @forum_thread.user
    klasses
  end

  def forum_user_badge(user)
    if user.respond_to?(:moderator) && user.moderator?
      content_tag :span, "Mod", class: "badge badge-default"
    end
  end

  def gravatar_url_for(email, **options)
    hash = Digest::MD5.hexdigest(email&.downcase || "")
    options.reverse_merge!(default: :mp, rating: :pg, size: 48)
    "https://secure.gravatar.com/avatar/#{hash}.png?#{options.to_param}"
  end
end
