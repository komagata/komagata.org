require 'sinatra'

class App < Sinatra::Base
  configure do
    use Rack::Static, :urls => ['/images'], :root => 'public'
    set :app_file, __FILE__
    set :haml, {:attr_wrapper => '"', :ugly => false}
    set :sass, {:style => :expanded}
    set :raise_errors, true
  end

  helpers do
    alias h escape_html
  end

  get '/' do
    haml :index
  end

  get '/*.css' do |path|
    content_type 'text/css'
    sass path.to_sym, :sass => {:load_paths => [options.views]}
  end
end
