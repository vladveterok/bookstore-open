class MyDecorator < SimpleDelegator
  class << self
    def decorate(relation)
      collection?(relation) ? relation.map { |object| new(object) } : new(relation)
    end

    def collection?(relation)
      relation.is_a?(Enumerable)
    end
  end
end
