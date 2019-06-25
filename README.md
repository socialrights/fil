# fil
filはFrontendIndentLoverの略で、webpack4をベースに pug, stylus, coffeeScript2を採用した制作環境パッケージです。 
IE11を含む各ブラウザの最新バージョンで動作する、最新のツールと技術を導入しています。 
フロントエンド開発のベースにしたり、webpackでの各ツールの使い方の参考にお使い下さい。

## 特徴
使用しているツールや技術、フレームワークなどは下記になります。 

- dev server → browsersync
- template engine → pug
- post css → stylus + stylint
- javascript → es6 + babel + eslint (jquery less)
- svg-sprite
- bootstrapのreboot.cssをリセットに使用
- css grid layout
- etc...

## 使い方
導入から開発・ビルドまでの説明です。yarn派なのでnpm派の方は適時置き換えてください。

### 導入
npmのパッケージたちをインストールします。コマンドラインでプロジェクトフォルダを選択し、下記を入力します。  
`yarn install`

### 開発モード
開発モードはローカルサーバーが起動しwatchを開始します。  
開発フォルダは`src`フォルダで、`dist`フォルダへビルドします。ローカルサーバーのdocument rootは`dist`フォルダです。  
`yarn dev`

### プロダクションモード
プロダクションモードでは、ローカルサーバーが立ち上がらず、watchもされません。ただwebpackがプロダクションモードでビルドします。プロダクションモードでは、css, jsファイルを圧縮し軽量化します。  
`yarn build`
