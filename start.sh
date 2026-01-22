#!/bin/bash
# 便携式 PHP 启动脚本
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# DIR="$(dirname "$SCRIPT_DIR")"

# 设置库路径 - 假设库在 DIR/lib 或 DIR/libs
export LD_LIBRARY_PATH="$DIR/lib:$DIR/libs:$LD_LIBRARY_PATH"
# 设置 PHP 额外配置目录（可选）
# export PHP_INI_SCAN_DIR="$DIR/etc/conf.d"
# 执行 PHP
exec "$DIR/phpx" -c "$DIR/etc/phpx.ini" "$DIR/../xjob" "$@"