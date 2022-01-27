require 'webrick'

server = WEBrick::HTTPServer.new({ 
  :DocumentRoot => './',
  :BindAddress => '127.0.0.1',
  :Port => 8000
})

server.mount_proc("/form_html") do |req, res|
  body = File.read("form_html.erb")
  res.status = 200
  res['Content-Type'] = 'text/html'
  res.body = body
end

server.mount_proc("/form_get") do |req, res|
  x = req.query
  body = "<html><body><head><meta charset='utf-8'></head><p>クエリパラメータは#{x}です</p></br>
<p>こんにちは#{x["username"]}さん。あなたの年齢は#{x["age"]}ですね</p></body></html>"
  res.status = 200
  res['Content-Type'] = 'text/html'
  res.body = body
end

server.mount_proc("/form_post") do |req, res|
  x = req.query
  body = 
  "<html><body><head><meta charset='utf-8'></head><p>フォームデータは#{x}です</p></br>
  <p>こんにちは#{x["username"]}さん。あなたの年齢は#{x["age"]}ですね</p></body></html>"
  res.status = 200
  res['Content-Type'] = 'text/html'
  res.body = body
end

server.start