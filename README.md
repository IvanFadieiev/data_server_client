# README

```rackup ./rack_apps/app.ru``` - run rack app endpoint 

```ruby ./lib/server.rb``` - run eventmachine servers

```foreman start -f Procfile.prod``` - to start daemonized scripts

```netcat -z -v localhost 8080 < original_file``` or ```telnet localhost 8080 < original_file```


```
stream {
   server {
       listen 1111;
       proxy_pass localhost:8080;
   }
}
```
add to the very top ```/etc/nginx/nginx.conf```