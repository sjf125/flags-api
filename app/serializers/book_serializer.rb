#
class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :isbn
end
