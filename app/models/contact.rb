# frozen_string_literal: true

class Contact < ApplicationRecord
  belongs_to :kind
  # optional: true
  has_many :phones
  # optional: true
  has_one :address

  accepts_nested_attributes_for :phones,
                                allow_destroy: true
  accepts_nested_attributes_for :address, update_only: true

  def as_json(options = {})
    h = super(options)
    h[:birthdate] = birthdate_br
    h
  end

  def birthdate_br
    I18n.l(birthdate) unless birthdate.blank?
  end
end

# def to_br
#   {
#     name: name,
#     email: email,
#     birthdate: (I18n.l(birthdate) unless birthdate.blank?)
#   }
# end

# def author
#   'Claudinei Perboni'
# end

# def kind_description
#   kind.description
# end

# def as_json(_options = {})
#   super(
#     methods: %i[author kind_description],
#     root: true,
#     include: { kind: { only: :description } }
#   )
# end
# end
