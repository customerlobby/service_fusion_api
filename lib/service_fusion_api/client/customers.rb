# frozen_string_literal: true

module ServiceFusionApi
  class Client
    # module to fetch customers
    module Customers
      def customers(params = {})
        params = {} if params.nil?
        params.merge!(expand: 'contacts,locations,contacts.phones,contacts.emails')
        get('customers', params)
      end

      def customer(id, params = {})
        get("customers/#{id}", params)
      end
    end
  end
end
