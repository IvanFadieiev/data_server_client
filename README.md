# README

```ruby ./lib/servers/server.rb``` - run eventmachine server

```foreman start``` - run servers in dev env

```foreman start -f Procfile.prod``` - to start daemonized servers for production env

```netcat localhost 1111 < original_file``` or ```telnet localhost 8080 < original_file```

```
stream {
  server {
    listen 1111;
    proxy_pass stream_backend;
  }

  upstream stream_backend {
    server localhost:8080 max_fails=3 fail_timeout=30s; # proxy host:port_1
    server localhost:8082 max_fails=3 fail_timeout=30s; # proxy host:port_2
  }
}

```
add to the very top ```/etc/nginx/nginx.conf```



data.unpack("B*")[0][0*8...3*8].scan(/.{1,8}/).map { |part|  part.to_i(2).chr }.join
time = DateTime.parse('1997-01-01').to_time.to_i
Time.at(time).gmtime

a = {}
data.each_char.with_index(1) { |char,i| a[i] = char.unpack('B*')[0] }