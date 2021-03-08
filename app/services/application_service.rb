class ApplicationService
  private 
  def self.json_parse(request)
    JSON.parse(request.body, symbolize_names: true)
  end
end
