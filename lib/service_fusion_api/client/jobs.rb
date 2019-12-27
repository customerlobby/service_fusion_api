# frozen_string_literal: true

module ServiceFusionApi
  class Client
    # module to fetch jobs
    module Jobs
      def jobs(params = {})
        get('jobs', params)
      end

      def job(id, params = {})
        get("jobs/#{id}", params)
      end
    end
  end
end
