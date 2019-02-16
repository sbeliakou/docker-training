#!/bin/bash

cat << EOF > /usr/share/nginx/html/index.html
<pre>
$(figlet -f /usr/share/figlet/roman.flf -W -c ${MSG})
$(figlet -f /usr/share/figlet/term.flf  -W -c Instance: $(hostname), $(hostname -i))
$(figlet -f /usr/share/figlet/term.flf  -W -c Date: $(date +"%D %T %Z"))
</pre>
EOF

nginx -g 'daemon off;'
