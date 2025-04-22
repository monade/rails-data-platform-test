
return unless Rails.env.development?
return unless defined? Debugbar

Debugbar.configure do |config|
  config.enabled = true
end
