## アプリケーションの概要
作った料理を共有できる、料理投稿SNSサービス https://www.my-gohan.com/

## 技術的ポイント
・dockerを用いた開発環境構築(rails+Mysql+テスト用db+selenium_chrome(systemtest用))  
・AWS VPC EC2 ELBを用いたRails本番環境構築  
・AWS ACMでSSL証明書を発行し、SSL化  
・AWS S3へ投稿された画像を保存  
・AWS Route53で独自ドメイン取得、使用  
・RSpecでテスト記述  
・Ajaxを用いた非同期処理（いいね/いいね解除の切り替え表示)  
・Bootstrapを使用したレスポンシブ対応  
・Rubocopを使用したコード規約に沿った開発  

## アプリケーションの機能
・投稿機能  
・画像を整形して投稿（CarrierWaveを使用)  
・投稿へのタグ付機能  
・タグ検索機能  
・投稿へのコメント機能  
・いいね（お気に入り）登録    
・通知機能  
・記事検索(コメントまでの横断検索)  
・ページネーション機能（kaminariを使用）    
・新規ユーザー登録  
・ログイン  
・モデルに対するバリデーション  

## ER図
<img width="732" alt="スクリーンショット 2020-04-04 16 22 02" src="https://user-images.githubusercontent.com/59824319/78450727-aeb0b680-76bb-11ea-9277-e26c7b04c71b.png">

## 環境
■フレームワーク  
　Ruby on Rails  
■インフラ  
　AWS EC2  
■データベース  
　 Mysql  
■アプリケーションサーバー  
　Unicorn  
■Webサーバー  
　Nginx  
