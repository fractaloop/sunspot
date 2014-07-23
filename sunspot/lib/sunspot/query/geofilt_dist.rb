module Sunspot
  module Query
    class GeofiltDist
      include Filter
      attr_reader :field

      def initialize(field, lat, lon, radius, options = {})
        @field, @lat, @lon, @radius, @options = field, lat, lon, radius, options
      end

      def to_boolean_phrase
        func = @options[:bbox] ? "bbox" : "geofilt"
        geodist_key = @options[:geodist_key] || "_dist_"
        "{!#{func} sfield=#{@field.indexed_name} pt=#{@lat},#{@lon} d=#{@radius} fl=*,#{geodist_key}:geodist()}"
      end

      def to_params
        {:fq => to_filter_query}
      end
    end
  end
end
