# stunnel-sni
Stunnel docker container.  It adds TLS support for HTTP only clients.

## Usage

### For client that runs in docker container 

Don't foget LINK client container to stunnel. Client must have STUNNEL_CONNECT host and stunnel contaner ip entry in its /etc/hosts file
```
docker run -itd --name stunnel-sni \
-e STUNNEL_ACCEPT=8000 -e STUNNEL_CONNECT=ya.ru:443 \
-p 8000:8000  ilijaz/stunnel-sni
```

### For hosted clients

You can't use FQDN in STUNNEL_CONNECT variable in this case. Because you must put 'example.com 127.0.0.1' entiry in /etc/hosts or use docker inspect in clients run scripts.

```
docker run -itd --name stunnel-sni \
-e STUNNEL_ACCEPT=8000 -e STUNNEL_CONNECT=x.x.x.x:443 -e SNI=example.com \
-p 8000:8000  ilijaz/stunnel-sni
```

