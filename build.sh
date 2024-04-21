# /Users/lxthyme/Desktop/Lucky/Caddy/nvm/versions/node/v18.19.1/bin/node /Users/lxthyme/.hvigor/project_caches/dec88c375e1ec3ce7acebec47f45fd0a/workspace/node_modules/@ohos/hvigor/bin/hvigor.js --mode module -p product=default assembleHap --analyze --parallel --incremental --daemon

# /Users/lxthyme/Desktop/Lucky/Caddy/nvm/versions/node/v18.19.1/bin/node /Users/lxthyme/.hvigor/project_caches/dec88c375e1ec3ce7acebec47f45fd0a/workspace/node_modules/@ohos/hvigor/bin/hvigor.js --mode module -p product=default -p module=library_share_common@default assembleHsp --analyze --parallel --incremental --daemon

# /Users/lxthyme/Desktop/Lucky/Caddy/nvm/versions/node/v18.19.1/bin/node /Users/lxthyme/.hvigor/project_caches/dec88c375e1ec3ce7acebec47f45fd0a/workspace/node_modules/@ohos/hvigor/bin/hvigor.js --mode module -p product=default -p module=library_static_common@default assembleHar --analyze --parallel --incremental --daemon

# localnode=/Users/lxthyme/Desktop/Lucky/Caddy/nvm/versions/node/v18.19.1/bin/node
# localhvigor=/Users/lxthyme/.hvigor/project_caches/dec88c375e1ec3ce7acebec47f45fd0a/workspace/node_modules/@ohos/hvigor/bin/hvigor.js
localnode=''
localhvigor='./hvigorw'
localoptions='--analyze --parallel --incremental --daemon'

# chmod +x hvigorw
$localnode $localhvigor --mode module -p product=default assembleHap $localoptions
$localnode $localhvigor --mode module -p product=default -p module=library_share_common@default assembleHsp $localoptions
$localnode $localhvigor --mode module -p product=default -p module=library_static_common@default assembleHar $localoptions
