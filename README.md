# キッズパークサーチ

## サイト概要
子どもの遊び場を共有できるコミュニティサイト

### サイトテーマ
子どもの遊び場が減っている現在に月齢に合わせて遊び場を共有することに特化したコミュニティサイト。
遊び場の閲覧、追加投稿、コメント、いいね機能などで簡単に遊び場を共有することができるサイトになっています。

### テーマを選んだ理由
私は、現在１歳の子供がいます。
子育ての中で、一緒に遊べる場が時代と共に減ってきていると感じました。
日常の中で、家で遊んでいても子どもが泣き止まない時、家にいてもすることがない時、外で遊べる場所を検索します。
しかし、検索しても有料のものしか出てこない、広い公園しか出てこない、対象の年齢がわからない、そんな場面が多くあります。

なので今回、遊び場の知識が少ない親に向けて、情報の共有ができればと思い、このテーマにしました。
経験豊富な親からの共有があれば、親歴0年の親でも非常に助かるのではないかと考えました。
知識豊富な親と繋がり、遊び場のアイデアをもらえることで子育ての悩みが少しでも解決するようなサイトにしていきたいです。

### ターゲットユーザ
 * 子育て中のご夫婦

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
 * gem 'devise'
 * gem 'enam-help'
 * gem 'kaminari', '~> 1.2', '>= 1.2.1'
 * gem 'bootstrap5-kaminari-views', '~> 0.0.1'
 * gem 'ransack'
 * gem "image_processing", "~> 1.2"
 * gem 'geocoder', '~> 1.4'
 * gem 'dotenv-rails'
 * gem 'ransack'
 * gem 'jp_prefecture'
 * gem "rails-i18n"
 * gem 'pry-rails'

## 使用素材