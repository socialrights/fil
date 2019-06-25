path = require('path')
globule = require('globule')
CleanWebpackPlugin = require('clean-webpack-plugin')
CopyWebpackPlugin = require('copy-webpack-plugin')
MiniCssExtractPlugin = require('mini-css-extract-plugin')
autoprefixer = require('autoprefixer')
UglifyJsPlugin = require('uglifyjs-webpack-plugin')
OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin')
HtmlWebpackPlugin = require('html-webpack-plugin')
BrowserSyncPlugin = require('browser-sync-webpack-plugin')

src = './src'
dist = './dist'

app =
  entry: "#{src}/app.coffee"
  output:
    filename: 'script.js'
    path: path.resolve(__dirname, dist)
    publicPath: '/'
  resolve:
    extensions: [
      '.js'
      '.css'
      '.styl'
      '.coffee'
      '.html'
      '.php'
      '.pug'
      '.png'
      '.jpg'
      '.gif'
      '.svg'
      '.ico'
    ]
  module:
    rules: [
      {
        test: /\.pug$/
        exclude: /node_modules/
        use: [
          {
            loader: 'pug-loader'
            options:
              pretty: true
              root: path.resolve(__dirname, 'src/documents')
          }
        ]
      }
      {
        test: /\.js?$/
        exclude: /node_modules\/(?!(dom7|ssr-window|swiper)\/).*/
        use: 'babel-loader'
      }
      {
        test: /\.coffee$/
        use: [
          'babel-loader'
          'coffee-loader'
        ]
      }
      {
        test: /\.css$/
        use: [
          MiniCssExtractPlugin.loader
          'css-loader'
        ]
      }
      {
        test: /\.styl$/
        # exclude: /node_modules/,
        use: [
          MiniCssExtractPlugin.loader
          {
            loader: 'css-loader'
            options:
              url: false
          }
          {
            loader: 'postcss-loader'
            options:
              plugins: [
                autoprefixer(
                  {
                    grid: true
                    flexbox: true
                  }
                )
              ]
          }
          'stylus-loader'
        ]
      }
      {
        test: /\.(jpg|png|gif)$/
        use: [
          {
            loader: 'file-loader'
            options:
              name: '[name].[ext]'
              outputPath: 'images/'
          }
        ]
      },
      {
        test: /\.svg$/
        use: [
          'svg-sprite-loader'
          'svg-transform-loader'
          'svgo-loader'
        ]
      }
    ]
  plugins: [
    new CleanWebpackPlugin("#{dist}")
    new BrowserSyncPlugin({
      server:
        baseDir: dist
      host: 'localhost'
      port: 3000
      open: 'external'
      https: true
    })
    new MiniCssExtractPlugin(
      {
        filename: 'style.css'
        chunkFilename: '[id].css'
      }
    )
    new CopyWebpackPlugin([
      {
        from: "#{src}"
        to: "../#{dist}"
        ignore: [
          '_*.*'
          '.DS_Store'
          '*.pug'
          '*.js'
          '*.styl'
          '*.svg',
          '*.coffee'
        ]
      }
    ])
  ]
  optimization: {
    minimizer: [
      new UglifyJsPlugin({
        cache: true,
        parallel: true
      })
      new OptimizeCSSAssetsPlugin()
    ]
  }

docs = globule.find(
  './src/documents/**/*.pug',
  {
    ignore: [
      './src/documents/**/_*/*.pug'
    ]
  }
)

for key, e of docs
  if e.match(/_template/)
    dirName = e.replace('./src/documents/', '').replace('/_template.pug', '')
    replaceJson = e.replace('_template', '_data').replace('.pug', '.json')
    json = require(replaceJson)
    for key, f of Object.keys(json)
      fileName = f
      app.plugins.push(
        new HtmlWebpackPlugin({
          filename: "#{dirName}/#{fileName}.html",
          template: e,
          data: json[f],
          json
        })
      )
  else
    fileName = e.replace('./src/documents/', '').replace('.pug', '.html')
    app.plugins.push(
      new HtmlWebpackPlugin({
        filename: "#{fileName}",
        template: e,
      })
    )


module.exports = app
