import Glide from '@glidejs/glide'
import '@glidejs/glide/dist/css/glide.core.css'
import '@glidejs/glide/dist/css/glide.theme.min.css'

const initTinySlider = () => {
  new Glide('.glide').mount()
}

export { initTinySlider };
