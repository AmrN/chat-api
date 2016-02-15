class PrettyJson
  def parse(json)
    if json.respond_to? :to_json
      json = json.to_json
    end
    JSON.pretty_generate(JSON.parse(json))
  end
end
