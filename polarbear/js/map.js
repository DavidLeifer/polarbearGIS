/** Create a default map
 */

import Map from 'ol/Map.js';
import View from 'ol/View.js';
import popup from './overlay/popup';
import {transform} from 'ol/proj';


// Clear map
$("#map").html('');

const map = new Map({
  target: 'map',
  view: new View({
  	projection: 'EPSG:3857',
    center: transform([-98, 39], 'EPSG:4326', 'EPSG:3857'),
    zoom: 3
  })
});

export default map