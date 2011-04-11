if ['staging', 'production'].include?(Rails.env)
  @hoptoad_config = YAML::load(File.open("#{Rails.root}/config/hoptoad.yml"))[Rails.env]
  HoptoadNotifier.configure do |config|
    config.api_key = @hoptoad_config['api_key']
  end
end