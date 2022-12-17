# Kid's Park Search

## サイトイメージ
#### PC版
![jvmfsC1gE6iCfMg6fpWq1671153156-1671153179](https://user-images.githubusercontent.com/110312863/207999505-1789b771-1aea-4f7e-968f-ae72173efffd.gif)


#### スマホ版
![WkAevi6PUnoJRI5BZtGh1671153281-1671153300](https://user-images.githubusercontent.com/110312863/207999630-0b9ad2f3-0354-4d64-8717-04f6ee9a47ea.gif)

#### 管理者側
![XcuhZqsVSPWolTxMWCZf1671237701-1671237733](https://user-images.githubusercontent.com/110312863/208213895-4b3376df-3b2f-4602-a7f9-833fccbe1e84.gif)

URL: https://kids-park-search.com/

## サイト概要
子どもの遊び場を共有できるコミュニティサイト

レスポンシブ対応しているのでスマホからでもご確認いただけます。

### サイトテーマ
子どもの遊び場が減っている現代に年齢や月齢に合わせて地域の遊び場を検索、共有することができるコミュニティサイト。
遊び場の閲覧、追加投稿、コメント、いいね機能などで簡単に遊び場を共有することができるサイトになっています。

### テーマを選んだ理由
私は、現在１歳の子供がいます。
子育てをしている中で、子どもと一緒に遊べる場所が時代と共に減ってきていると感じています。
また、地元を離れ子育てをしている家族も多くいます。そういった家族で住まいの近くの公園などの遊び場がわからない方も多くいらっしゃいます。
遊び場がわからない時、子どもが泣き止まない時、家ですることがない時、いつもと違う場所で新しい刺激を与えたい時、ネットで遊び場を探す方が多く見受けられます。
しかし、検索しても有料のものしか出てこない、広い公園しか出てこない、対象の年齢がわからない、そんな場面が多くあります。

なので今回、子育て中の親に向けて、情報の共有ができればと思い、このテーマにしました。
さまざまな遊び場の共有があれば、親歴0年の親でも地域に詳しくない親でも子育ての手助けになるのではないかと考えました。
地域の小さな公園や商業施設内のキッズスペースから、遊園地や広い公園などさまざまな遊び場情報を掲載しているサイトにしていき、
少しでも子育ての悩みを解消するお手伝いができればと思います。

### ターゲットユーザ
 * 子育て中のご夫婦
 * 地元から離れて子育てをしているご夫婦

### 主な利用シーン
 * 遊び場を共有したい時
 * 子どもの年齢、月齢に合わせた遊び場を探している時

## 設計書

[ER図](https://user-images.githubusercontent.com/110312863/202975102-0aa6c7f9-c342-4a00-8e9c-872e25450825.jpg)

[アプリケーション詳細設計書](https://docs.google.com/spreadsheets/d/1H_9ljrj8AheMexKkDozxxWHkoTXMl2If-lthdds6YLU/edit#gid=549108681)

[テーブル定義書](https://docs.google.com/spreadsheets/d/1VN8J3OWy0Z6RvbROLpgLzgZ-u4-4LmkSQBxYVKkFHAw/edit#gid=1373217982)

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## gem一覧

### ログイン機能
 * gem 'devise'

### レイアウト
 * gem 'kaminari', '~> 1.2', '>= 1.2.1'
 * gem 'bootstrap5-kaminari-views', '~> 0.0.1'
 * gem "image_processing", "~> 1.2"

### マップの実装機能
 * gem 'geocoder', '~> 1.4'

### 検索機能
 * gem 'ransack'

### バリデーション日本語化
 * gem "rails-i18n"

### 都道府県情報
 * gem 'jp_prefecture'

### デプロイ
 * gem 'mysql2'

### テスト関係
 * gem 'pry-rails'
 * gem 'byebug'
 * gem 'capybara'
 * gem 'rspec-rails'
 * gem "factory_bot_rails"
 * gem 'faker'

### その他
 * gem 'enam-help'
 * gem 'dotenv-rails'

## 使用素材
[イラストAC](https://www.ac-illust.com/)