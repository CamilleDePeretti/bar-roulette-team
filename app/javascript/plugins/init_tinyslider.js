import Glide from '@glidejs/glide'
import '@glidejs/glide/dist/css/glide.core.css'
import '@glidejs/glide/dist/css/glide.theme.min.css'

const initTinySlider = () => {
  const glides = document.querySelectorAll("[class^=glide-div-]");

  if (glides.length > 0) {
    for (let i = 0; i < glides.length; i++) {
      let className = glides[i].classList.item(0);
      console.log(className);
      new Glide(`.${className}`).mount()
    }
  }

  const bars = document.querySelectorAll("[id^=bar-]");

  if (bars.length > 0) {
    for (let i = 0; i < bars.length; i++) {
      bars[i].style.display = 'none';
    }
  }
}



export { initTinySlider };
