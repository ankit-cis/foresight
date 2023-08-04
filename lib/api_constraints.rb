class ApiConstraints
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  def matches?(req)
    @default || req.headers['Accept-Version'].include?("application/uk.co.4sightplus.v#{@version}")
  end
end