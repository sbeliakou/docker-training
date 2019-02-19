## Simple Echo HTTP Service

```bash
$ docker run -d -e MSG="Siarhei Beliakou" -p 80:80 sbeliakou/echo-msg
$ curl localhost
<pre>
        .oooooo..o  o8o                     oooo                   o8o
       d8P'    `Y8  `"'                     `888                   `"'
       Y88bo.      oooo   .oooo.   oooo d8b  888 .oo.    .ooooo.  oooo
        `"Y8888o.  `888  `P  )88b  `888""8P  888P"Y88b  d88' `88b `888
            `"Y88b  888   .oP"888   888      888   888  888ooo888  888
       oo     .d8P  888  d8(  888   888      888   888  888    .o  888
       8""88888P'  o888o `Y888""8o d888b    o888o o888o `Y8bod8P' o888o



oooooooooo.            oooo   o8o            oooo
`888'   `Y8b           `888   `"'            `888
 888     888  .ooooo.   888  oooo   .oooo.    888  oooo   .ooooo.  oooo  oooo
 888oooo888' d88' `88b  888  `888  `P  )88b   888 .8P'   d88' `88b `888  `888
 888    `88b 888ooo888  888   888   .oP"888   888888.    888   888  888   888
 888    .88P 888    .o  888   888  d8(  888   888 `88b.  888   888  888   888
o888bood8P'  `Y8bod8P' o888o o888o `Y888""8o o888o o888o `Y8bod8P'  `V88V"V8P'



                       Instance: b9a09abb98b3, 172.17.0.5
                          Date: 12/09/18 21:35:04 UTC
</pre>
```

### Build
```
$ docker build -t myecho .
```

### Run
```
$ docker run -d -e MSG="Custom message" -p 80:80 myecho
```
