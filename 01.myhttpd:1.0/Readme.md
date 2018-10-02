# Building myhttpd image

## Building ways:
```
docker build .
docker tag "<< image_id >>" myhttpd:1.0 
```

```
docker build -t myhttpd:1.0 .
```

## Providing multiple tags
```
docker build -t sbeliakou/myhttpd:1.0 -t myhttpd:1.0 .
docker tag "<< image_id >>" sbeliakou/myhttpd:1.0 myhttpd:1.0 
```
