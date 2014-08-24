require 'rack/contrib/try_static'

use Rack::TryStatic,
    :root => "_site",
    :urls => %w[/],
    :try => ['.html', 'index.html', '/index.html']

run ->(*) do
  [404, { 'Content-Type' => 'text/html' }, ['Not Found']]
end
