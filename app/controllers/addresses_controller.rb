# frozen_string_literal: true
class AddressesController < ApplicationController
  before_action :set_address

  def show
    render(json: @address)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_phones
    @address = Contact.find(params[:contact_id]).address
  end
end
