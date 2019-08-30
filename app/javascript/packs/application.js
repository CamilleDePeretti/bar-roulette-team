import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!
import tippy from 'tippy.js'
import { initAlgolia } from '../plugins/init_algolia';
import { initMapbox } from '../plugins/init_mapbox';
import { dynamicForm } from '../components/address_form';
import { initGiphy } from '../components/wheel_spinning';

initMapbox();
initAlgolia();
dynamicForm();
initGiphy();

