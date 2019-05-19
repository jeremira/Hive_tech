class StoresController < ApplicationController
  before_action :authenticate_user!

  def index
    @campaigns = current_user.networks
      .collect { |network| Campaign.matching(network, current_user) }
      .flatten

    render json: @campaigns, status: 200
  end
end
