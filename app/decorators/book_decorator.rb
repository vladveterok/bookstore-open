class BookDecorator < MyDecorator
  SHORT_DESCRIPTION_MAX_LENGTH = 250

  def all_authors
    AuthorDecorator.decorate(authors).map(&:full_name).join(', ')
  end

  def dimensions
    I18n.t('show.dimensions.dimensions', height: height,
                                         width: width,
                                         depth: depth)
  end

  def title_image
    images.first
  end

  def short_description
    MarkdownService.render(description).truncate(SHORT_DESCRIPTION_MAX_LENGTH)
  end

  def full_description
    MarkdownService.render(description)
  end
end
