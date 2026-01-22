# 在源服务器上创建一个独立的 PHP 环境
mkdir -p /tmp/portable_php
cd /tmp/portable_php

# 复制 PHP 可执行文件
cp -r /www/server/php/72/bin/php ./php72/bin

# 复制 php.ini
cp /www/server/php/72/etc/php.ini php72/etc/

# 收集所有依赖库
mkdir -p php72/libs
ldd /www/server/php/72/bin/php | awk '{print $3}' | grep -v "^$" | xargs -I {} cp {} php72/libs/ 2>/dev/null || true

# 创建一个包装脚本
cat > php72/php << 'EOF'
#!/bin/bash
# 便携式 PHP 启动脚本
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# 设置库路径 - 假设库在 DIR/lib 或 DIR/libs
export LD_LIBRARY_PATH="$DIR/lib:$DIR/libs:$LD_LIBRARY_PATH"
# 设置 PHP 额外配置目录（可选）
# export PHP_INI_SCAN_DIR="$DIR/etc/conf.d"
# 执行 PHP
exec "$DIR/bin/php" -c "$DIR/etc/php.ini" "$@"
EOF

chmod +x php72/php