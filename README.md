# Typst & Quarto Docker Environment

- [Public page](https://m02uku.github.io/resumes/)

## 概要

このDockerfileは、typstとquartoの最新安定版を含むDebianベースのコンテナ環境を提供します。

## 使用方法

### 1. イメージのビルド

```bash
docker build -t typst-quarto .
```

### 2. Docker Composeを使用（推奨）

```bash
# コンテナを起動してシェルに入る
docker-compose run --rm typst-quarto
```

### 3. 単体でのコンテナ実行

```bash
# インタラクティブモードで実行
docker run -it --rm -v $(pwd):/workspace typst-quarto

# 特定のコマンドを実行
docker run --rm -v $(pwd):/workspace typst-quarto typst compile document.typ
docker run --rm -v $(pwd):/workspace typst-quarto quarto render document.qmd
```

## 含まれるツール

- **Typst**: 最新安定版（GitHubから自動取得）
- **Quarto**: 最新安定版（GitHubから自動取得）
- **Git**: バージョン管理とリモートリポジトリ操作
- **Deno**: Quartoの依存関係として必要
- **Pandoc**: Quartoの依存関係として必要

## 特徴

- **超軽量**: 必要最小限のパッケージのみをインストール
- **単一レイヤー**: 全ツールを1つのRUNコマンドで統合してレイヤー数を削減
- **安定性**: Debian slimベースで高い互換性と安定性
- **最新版**: GitHubから最新の安定版リリースを自動取得
- **自動更新**: ビルド時に常に最新版をダウンロード
- **ボリュームマウント**: ホストのファイルシステムと連携

## 使用例

### Typstドキュメントのコンパイル

```bash
docker-compose run --rm typst-quarto typst compile paper.typ
```

### Quartoドキュメントのレンダリング

```bash
docker-compose run --rm typst-quarto quarto render presentation.qmd
```

### Git操作

```bash
# コンテナ内でgit操作が可能
docker-compose run --rm typst-quarto git status
docker-compose run --rm typst-quarto git add .
docker-compose run --rm typst-quarto git commit -m "Update documents"
docker-compose run --rm typst-quarto git push origin main
```

### インタラクティブな作業

```bash
docker-compose run --rm typst-quarto
# コンテナ内でシェルが起動し、typst、quarto、gitコマンドを実行可能
```

## Git SSH設定

コンテナ内でSSH鍵を使用したgit操作を行うために、以下の設定が自動的に適用されます：

- **SSH鍵**: `~/.ssh`ディレクトリをコンテナ内にマウント（読み取り専用）
- **Git設定**: `~/.gitconfig`をコンテナ内にマウント（読み取り専用）

### 初回セットアップ

1. ホストマシンでSSH鍵を生成（未作成の場合）:

   ```bash
   ssh-keygen -t ed25519 -C "your-email@example.com"
   ```

2. GitHubにSSH公開鍵を追加

3. Git設定を確認:

   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your-email@example.com"
   ```

4. コンテナ内でSSH接続をテスト:

   ```bash
   docker-compose run --rm typst-quarto ssh -T git@github.com
   ```
