ActiveAdmin.register Author do
  permit_params :first_name, :last_name, :description
  decorate_with AuthorDecorator

  index do
    selectable_column

    column :full_name do |author|
      link_to author.full_name, resource_path(author)
    end
    column :description

    actions
  end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :description
    end
  end
end
