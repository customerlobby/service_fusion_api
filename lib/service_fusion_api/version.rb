module ServiceFusionApi
  class Version
    MAJOR = 0 unless defined? ServiceFusionApi::Version::MAJOR
    MINOR = 1 unless defined? ServiceFusionApi::Version::MINOR
    PATCH = 0 unless defined? ServiceFusionApi::Version::PATCH

    class << self
      # @return [String]
      def to_s
        [MAJOR, MINOR, PATCH].compact.join('.')
      end
    end
  end
  
end
