module Api
  ##
  # Handles school data requests in JSON format

  class RegionsController < ::ApplicationController
    ##
    # Returns a list of all regions ordered by name
    def index
      render json: Region.order(:name)
    end

    ##
    # Returns a region by id
    #
    # @param :id ID of the region
    def show
      render json: Region.find_by_id(controller_params)
    end

    ##
    # Returns all cities in a region
    #
    # @param :id ID of the region
    def cities_in_region
      render json: City.where(region_id: controller_params).order(:name)
    end

    ##
    # Returns a city by id
    #
    # @param :id ID of the city
    def city
      render json: City.find_by_id(controller_params)
    end

    ##
    # Returns all schools in a city
    #
    # @param :id ID of the city
    def schools_in_city
      render json: School.where(city_id: controller_params).order(:name)
    end

    ##
    # Returns a school by id
    #
    # @param :id ID of the school
    def school
      render json: School.find_by_id(controller_params)
    end

    def controller_params
      params.require(:id)
    end
  end
end