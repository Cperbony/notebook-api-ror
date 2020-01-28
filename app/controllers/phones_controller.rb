# frozen_string_literal: true
class PhonesController < ApplicationController
  before_action :set_phones

  def show
    render(json: @phones)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_phones
    if params[:contact_id]
      @phones = Contact.find(params[:contact_id]).phones
      return @phones
    end
    @phones = phones.where(id: params[:id])
  end
end
