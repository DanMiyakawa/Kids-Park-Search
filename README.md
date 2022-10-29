# Kid's Park Search

## サイト概要
子どもの遊び場を共有できるコミュニティサイト

レスポンシブ対応しているのでスマホからでもご確認いただけます。
#### PC版
<img width="1061" alt="PC-top" src="https://user-images.githubusercontent.com/110312863/198753770-6541ae77-91fb-4e6e-bf62-3b761413768c.png">

#### スマホ版
<img width="369" alt="phone_top" src="https://user-images.githubusercontent.com/110312863/198754134-cb00efbf-15a9-4fa6-aa81-9aeedc0d484d.png">

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
 * 地元から離れて子育てをしている親

### 主な利用シーン
 * 遊び場を共有したい時
 * 子どもの年齢、月齢に合わせた遊び場を探している時

## 設計書

[ER図](https://app.diagrams.net/#G15gIi581iMAllGybAb8qbwm_mBV_Sh6I8)

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