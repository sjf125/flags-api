class FlagSerializer < ActiveModel::Serializer
  attributes :id, :location, :name, :level, :imgurl
end
