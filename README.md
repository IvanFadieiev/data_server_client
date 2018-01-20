# README

```ruby ./lib/server.rb``` - run eventmachine servers

```foreman start -f Procfile.prod``` - to start daemonized scripts

```netcat -N localhost 1111 < original_file``` or ```telnet localhost 8080 < original_file```

```
stream {
   server {
       listen localhost:1111;
       proxy_pass localhost:8079; # proxy host:port
   }
}
```
add to the very top ```/etc/nginx/nginx.conf```



data.unpack("B*")[0][0*8...3*8].scan(/.{1,8}/).map { |part|  part.to_i(2).chr }.join
time = DateTime.parse('1997-01-01').to_time.to_i
Time.at(time).gmtime

a = {}
data.each_char.with_index(1) { |char,i| a[i] = char.unpack('B*')[0] }