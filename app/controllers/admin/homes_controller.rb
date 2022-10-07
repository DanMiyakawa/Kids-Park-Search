class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @contacts = Contact.all
  end
end
