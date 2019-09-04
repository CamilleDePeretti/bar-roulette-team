import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!
import tippy from 'tippy.js'
import { initAlgolia } from '../plugins/init_algolia';
import { initMapbox } from '../plugins/init_mapbox';
import { initTinySlider } from '../plugins/init_tinyslider';
import { dynamicForm } from '../components/address_form';
import { initGif } from '../components/wheel_spinning';
import { showFilters } from '../components/filters.js';
import { clipboardBtn } from '../components/clipboard_btn';

initMapbox();
initAlgolia();
dynamicForm();
initGif();
initTinySlider();
showFilters();
clipboardBtn();


