class AuthorDecorator < MyDecorator
  def full_name
    "#{first_name} #{last_name}"
  end
end
