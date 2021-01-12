class MarkdownService
  class << self
    def render(text)
      markdown&.render(text)
    end

    def markdown
      @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    end
  end
end
