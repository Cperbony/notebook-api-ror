# frozen_string_literal: true

class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate

  belongs_to :kind do
    link(:related) { contact_kind_url(object.id) }
  end
  # :author

  belongs_to :kind

  has_many :phones do
    link(:related) { contact_phones_url(object.id) }
  end

  has_one :address do
    link(:related) { contact_address_url(object.id) }
  end

  link(:self) { contact_path(object.id) }
  link(:kind) { kind_path(object.kind.id) }
  # def author
  #   'Claus'
  # end

  meta do
    { author: "Claus" }
  end

  def test_rub
  end

  def attributes(*args)
    h = super(*args)
    h[:birthdate] = object.birthdate.to_time.iso8601 unless object.birthdate.blank?
    h
  end
end
