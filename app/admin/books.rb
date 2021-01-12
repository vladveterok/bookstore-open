ActiveAdmin.register Book do
  includes :authors, :category
  permit_params :title, :description, :quantity, :year_of_publication, :price,
                :height, :width, :depth, :material, :category_id,
                author_ids: [], images: []
  decorate_with BookDecorator

  index do
    selectable_column

    column :category
    column :title do |book|
      link_to book.title, resource_path(book)
    end
    column :images do |book|
      image_tag(book.title_image.url(:catalog)) unless book.title_image.nil?
    end
    column :authors, &:all_authors
    column :description, &:short_description
    column :price
    actions
  end

  show do
    attributes_table do
      row :category
      row :title
      row :authors, &:all_authors
      row :description
      row :year_of_publication
      row :height
      row :width
      row :depth
      row :material
      row :price
      book.images.each do |image|
        row image do
          image_tag(image.url(:catalog))
        end
      end
    end
  end

  form(html: { multipart: true }) do |f|
    f.inputs do
      f.input :category
      f.input :title
      f.input :authors, collection: AuthorDecorator.decorate(Author.all), as: :check_boxes
      f.input :description
      f.input :year_of_publication
      f.input :height
      f.input :width
      f.input :depth
      f.input :material
      f.input :price
      f.input :images, as: :file, input_html: { multiple: true }
    end
    actions
  end
end
