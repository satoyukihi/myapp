## アプリケーションの概要
作った料理を共有できる、料理投稿SNSサービス https://www.my-gohan.com/

## 技術的ポイント
・AWS VPC EC2 ELBを用いたRails本番環境構築  
・AWS ACMでSSL証明書を発行し、SSL化  
・AWS S3へ投稿された画像を保存  
・AWS Route53で独自ドメイン取得、使用  
・RSpecでテスト記述  
・Ajaxを用いた非同期処理（いいね/いいね解除の切り替え表示)  
・Bootstrapによるレスポンシブ対応  
・Rubocopを使用したコード規約に沿った開発  

## アプリケーションの機能
・作った料理を投稿  
・画像を整形して投稿（CarrierWaveを使用)  
・投稿へのタグ付機能  
・タグ検索機能  
・投稿へのコメント機能  
・いいね（お気に入り）登録    
・記事検索(コメントまでの横断検索)  
・ページネーション機能（kaminariを使用）    
・新規ユーザー登録  
・ログイン  
・モデルに対するバリデーション  

## ER図
<img width="635" alt="スクリーンショット 2020-03-28 15 40 13" src="https://user-images.githubusercontent.com/59824319/77817064-5bfb5b80-710b-11ea-9427-342ddce7e96d.png">

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