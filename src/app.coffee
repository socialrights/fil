import Prism from 'prismjs'

import './styles/index.styl'
import './scripts/index.coffee'

Prism.highlightAll()

requireAll = (r) =>
  r.keys().forEach(r)
requireAll(require.context('./images/', true, /\.svg$/))
