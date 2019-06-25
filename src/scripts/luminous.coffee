import { Luminous, LuminousGallery } from 'luminous-lightbox'
import 'luminous-lightbox/dist/luminous-basic.css'

targets = document.querySelectorAll('.luminous')

luminous = () =>
  new LuminousGallery(targets)
  # for e in Array.from(targets) =>
  #   new Luminous(e)

export default luminous
