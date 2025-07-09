#!/bin/bash
# テストファイル・フォルダ削除スクリプト
# test_ プレフィックスが付いたフォルダとファイルを削除します

echo "テストファイル・フォルダを削除しています..."

# public/papers/test_* フォルダを削除
rm -rf public/papers/test_*

# public/slides/test_* フォルダを削除  
rm -rf public/slides/test_*

# papers フォルダが空なら削除
if [ -d "public/papers" ] && [ -z "$(ls -A public/papers)" ]; then
    rmdir public/papers
    echo "空のpapersフォルダを削除しました"
fi

# このスクリプト自体も削除
rm -f clean_test_files.sh

echo "テストファイル・フォルダの削除が完了しました"
