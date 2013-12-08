json.array!(@media) do |medium|
  json.extract! medium, :id, :name, :filename, :extension, :type, :comment
  json.url medium_url(medium, format: :json)
end
