import 'ol/ol.css';
import Map from 'ol/Map';
import Stamen from 'ol/source/Stamen';
import TileLayer from 'ol/layer/Tile';
import TileWMS from 'ol/source/TileWMS';
import GeoJSON from 'ol/format/GeoJSON';
import VectorLayer from 'ol/layer/Vector';
import VectorSource from 'ol/source/Vector';
import Layer from 'ol/layer/Layer';
import View from 'ol/View';
import {getCenter} from 'ol/extent';
import {transformExtent} from 'ol/proj';
import {transform} from 'ol/proj';
import {Style, Fill, Stroke, Circle} from 'ol/style';
import 'regenerator-runtime/runtime';

import geojson from '../data/*.geojson'

//create extent and use it in the VectorLayer called all_ween
var extent = transformExtent([-89.30, 24.71, -64.70, 48.07], 'EPSG:4326', 'EPSG:3857');

//define make before adding to it
var map = new Map({
  target: 'map',
  view: new View({
    center: transform([-77.3765, 38.1667], 'EPSG:4326', 'EPSG:3857'),
    zoom: 5,
  }),
});

//define basemap and radar as a TileLayer
const basemap = new TileLayer({
  source: new Stamen({
    layer: 'terrain',
  }),
});
const radar = new TileLayer({
  extent: extent,
  source: new TileWMS({
    attributions: ['Iowa State University'],
    url: 'https://mesonet.agron.iastate.edu/cgi-bin/wms/nexrad/n0r-t.cgi',
    params: {'LAYERS': 'nexrad-n0r-wmst'},
  }),
});

/* Add to map */
map.addLayer(basemap);
map.addLayer(radar);

//empty array for our dates
var dates = [];
var all_ween_array = []
//loop over each property of of the geojson object and add it to the map
for (const property in geojson) {
    const ween = new VectorSource({
      url: geojson[property],
      format: new GeoJSON(),
    });
    //create the layers for the point_changer function
    const all_ween = new VectorLayer({
      extent: extent,
      source: ween,
    });
    //push property (our datetime) to empty array called dates
    const property_t = property.replace(/\s/g, 'T')
    dates.push(property_t + ".000Z")
    //push layer to empty all_ween_array
    all_ween_array.push(all_ween)
    //console.log(`${property}: ${geojson[property]}`);
};
//console.log(all_ween_array)
//console.log(dates)

radar.addEventListener('change', point_changer, false);
function point_changer(){
  var el = document.getElementById('date_value').textContent;
  console.log(el)
  if (el == dates[0]){
    map.addLayer(all_ween_array[0]);
    map.removeLayer(all_ween_array[1]);
    map.removeLayer(all_ween_array[2]);
    map.removeLayer(all_ween_array[3]);
    map.removeLayer(all_ween_array[4]);
    map.removeLayer(all_ween_array[5]);
    map.removeLayer(all_ween_array[6]);
    map.removeLayer(all_ween_array[7]);
    map.removeLayer(all_ween_array[8]);
    map.removeLayer(all_ween_array[9]);
  }
  else if (el == dates[1]){
    map.removeLayer(all_ween_array[0]);
    map.addLayer(all_ween_array[1]);
    map.removeLayer(all_ween_array[2]);
    map.removeLayer(all_ween_array[3]);
    map.removeLayer(all_ween_array[4]);
    map.removeLayer(all_ween_array[5]);
    map.removeLayer(all_ween_array[6]);
    map.removeLayer(all_ween_array[7]);
    map.removeLayer(all_ween_array[8]);
    map.removeLayer(all_ween_array[9]);
  }
  else if (el == dates[2]){
    map.removeLayer(all_ween_array[0]);
    map.removeLayer(all_ween_array[1]);
    map.addLayer(all_ween_array[2]);
    map.removeLayer(all_ween_array[3]);
    map.removeLayer(all_ween_array[4]);
    map.removeLayer(all_ween_array[5]);
    map.removeLayer(all_ween_array[6]);
    map.removeLayer(all_ween_array[7]);
    map.removeLayer(all_ween_array[8]);
    map.removeLayer(all_ween_array[9]);
  }
  else if (el == dates[3]){
    map.removeLayer(all_ween_array[0]);
    map.removeLayer(all_ween_array[1]);
    map.removeLayer(all_ween_array[2]);
    map.addLayer(all_ween_array[3]);
    map.removeLayer(all_ween_array[4]);
    map.removeLayer(all_ween_array[5]);
    map.removeLayer(all_ween_array[6]);
    map.removeLayer(all_ween_array[7]);
    map.removeLayer(all_ween_array[8]);
    map.removeLayer(all_ween_array[9]);
  }
  else if (el == dates[4]){
    map.removeLayer(all_ween_array[0]);
    map.removeLayer(all_ween_array[1]);
    map.removeLayer(all_ween_array[2]);
    map.removeLayer(all_ween_array[3]);
    map.addLayer(all_ween_array[4]);
    map.removeLayer(all_ween_array[5]);
    map.removeLayer(all_ween_array[6]);
    map.removeLayer(all_ween_array[7]);
    map.removeLayer(all_ween_array[8]);
    map.removeLayer(all_ween_array[9]);
  }
  else if (el == dates[5]){
    map.removeLayer(all_ween_array[0]);
    map.removeLayer(all_ween_array[1]);
    map.removeLayer(all_ween_array[2]);
    map.removeLayer(all_ween_array[3]);
    map.removeLayer(all_ween_array[4]);
    map.addLayer(all_ween_array[5]);
    map.removeLayer(all_ween_array[6]);
    map.removeLayer(all_ween_array[7]);
    map.removeLayer(all_ween_array[8]);
    map.removeLayer(all_ween_array[9]);
  }
  else if (el == dates[6]){
    map.removeLayer(all_ween_array[0]);
    map.removeLayer(all_ween_array[1]);
    map.removeLayer(all_ween_array[2]);
    map.removeLayer(all_ween_array[3]);
    map.removeLayer(all_ween_array[4]);
    map.removeLayer(all_ween_array[5]);
    map.addLayer(all_ween_array[6]);
    map.removeLayer(all_ween_array[7]);
    map.removeLayer(all_ween_array[8]);
    map.removeLayer(all_ween_array[9]);
  }
  else if (el == dates[7]){
    map.removeLayer(all_ween_array[0]);
    map.removeLayer(all_ween_array[1]);
    map.removeLayer(all_ween_array[2]);
    map.removeLayer(all_ween_array[3]);
    map.removeLayer(all_ween_array[4]);
    map.removeLayer(all_ween_array[5]);
    map.removeLayer(all_ween_array[6]);
    map.addLayer(all_ween_array[7]);
    map.removeLayer(all_ween_array[8]);
    map.removeLayer(all_ween_array[9]);
  }
  else if (el == dates[8]){
    map.removeLayer(all_ween_array[0]);
    map.removeLayer(all_ween_array[1]);
    map.removeLayer(all_ween_array[2]);
    map.removeLayer(all_ween_array[3]);
    map.removeLayer(all_ween_array[4]);
    map.removeLayer(all_ween_array[5]);
    map.removeLayer(all_ween_array[6]);
    map.removeLayer(all_ween_array[7]);
    map.addLayer(all_ween_array[8]);
    map.removeLayer(all_ween_array[9]);
  }
  else if (el == dates[9]){
    map.removeLayer(all_ween_array[0]);
    map.removeLayer(all_ween_array[1]);
    map.removeLayer(all_ween_array[2]);
    map.removeLayer(all_ween_array[3]);
    map.removeLayer(all_ween_array[4]);
    map.removeLayer(all_ween_array[5]);
    map.removeLayer(all_ween_array[6]);
    map.removeLayer(all_ween_array[7]);
    map.removeLayer(all_ween_array[8]);
    map.addLayer(all_ween_array[9]);
  }
};
// style vars
var white = new Fill({color: 'white'})
var green = new Fill({color: 'green'})
var red = new Fill({color: 'red'});
//rgba opacity
var invis = new Fill({color: 'rgba(255, 0, 0, 0)'});

//create color style vars
var white_style = new Style({
      image: new Circle({
        radius: 7,
        fill: white,
        stroke: new Stroke({
          color: [255,255,255], width: 2
        })
      })
});
var green_style = new Style({
      image: new Circle({
        radius: 7,
        fill: green,
        stroke: new Stroke({
          color: [255,255,255], width: 2
        })
      })
});
var red_style = new Style({
      image: new Circle({
        radius: 7,
        fill: red,
        stroke: new Stroke({
          color: [255,255,255], width: 2
        })
      })
});
var invis_style = new Style({
      image: new Circle({
        radius: 0,
        fill: invis,
        stroke: new Stroke({
          color: [255,255,255,0], width: 0
        })
      })
});

//make invis
all_ween_array[0].setStyle(invis_style)
all_ween_array[1].setStyle(invis_style)
all_ween_array[2].setStyle(invis_style)
all_ween_array[3].setStyle(invis_style)
all_ween_array[4].setStyle(invis_style)
all_ween_array[5].setStyle(invis_style)
all_ween_array[6].setStyle(invis_style)
all_ween_array[7].setStyle(invis_style)
all_ween_array[8].setStyle(invis_style)
all_ween_array[9].setStyle(invis_style)

//Proimise and await. who came up with that, its a(time)sync function
function resolveAfter2Seconds(x) {
  return new Promise(resolve => {
    setTimeout(() => {
      resolve(x);
    }, 500);
    radar.addEventListener('change', style_points, false);
  });
};
async function style_points() {
  var x = await resolveAfter2Seconds(10);
  //var uidIndex_ = polarVortex_six30_layer.get("source").uidIndex_;
  all_ween_array[0].getSource().forEachFeature(function(feature){
    if ((feature.get('compound') === 0)) {
      feature.setStyle(white_style)
    }
    else if (feature.get('compound') > 0) {
      feature.setStyle(green_style)
    }
    else{
      feature.setStyle(red_style)
    }
  })
  all_ween_array[1].getSource().forEachFeature(function(feature){
    if ((feature.get('compound') === 0)) {
      feature.setStyle(white_style)
    }
    else if (feature.get('compound') > 0) {
      feature.setStyle(green_style)
    }
    else{
      feature.setStyle(red_style)
    }
  })
  all_ween_array[2].getSource().forEachFeature(function(feature){
    if ((feature.get('compound') === 0)) {
      feature.setStyle(white_style)
    }
    else if (feature.get('compound') > 0) {
      feature.setStyle(green_style)
    }
    else{
      feature.setStyle(red_style)
    }
  })
  all_ween_array[3].getSource().forEachFeature(function(feature){
    if ((feature.get('compound') === 0)) {
      feature.setStyle(white_style)
    }
    else if (feature.get('compound') > 0) {
      feature.setStyle(green_style)
    }
    else{
      feature.setStyle(red_style)
    }
  })
  all_ween_array[4].getSource().forEachFeature(function(feature){
    if ((feature.get('compound') === 0)) {
      feature.setStyle(white_style)
    }
    else if (feature.get('compound') > 0) {
      feature.setStyle(green_style)
    }
    else{
      feature.setStyle(red_style)
    }
  })
  all_ween_array[5].getSource().forEachFeature(function(feature){
    if ((feature.get('compound') === 0)) {
      feature.setStyle(white_style)
    }
    else if (feature.get('compound') > 0) {
      feature.setStyle(green_style)
    }
    else{
      feature.setStyle(red_style)
    }
  })
  all_ween_array[6].getSource().forEachFeature(function(feature){
    if ((feature.get('compound') === 0)) {
      feature.setStyle(white_style)
    }
    else if (feature.get('compound') > 0) {
      feature.setStyle(green_style)
    }
    else{
      feature.setStyle(red_style)
    }
  })
  all_ween_array[7].getSource().forEachFeature(function(feature){
    if ((feature.get('compound') === 0)) {
      feature.setStyle(white_style)
    }
    else if (feature.get('compound') > 0) {
      feature.setStyle(green_style)
    }
    else{
      feature.setStyle(red_style)
    }
  })
  all_ween_array[8].getSource().forEachFeature(function(feature){
    if ((feature.get('compound') === 0)) {
      feature.setStyle(white_style)
    }
    else if (feature.get('compound') > 0) {
      feature.setStyle(green_style)
    }
    else{
      feature.setStyle(red_style)
    }
  })
  all_ween_array[9].getSource().forEachFeature(function(feature){
    if ((feature.get('compound') === 0)) {
      feature.setStyle(white_style)
    }
    else if (feature.get('compound') > 0) {
      feature.setStyle(green_style)
    }
    else{
      feature.setStyle(red_style)
    }
  })
};
style_points()

//define the slider and do some stuff
var sliderRange = document.getElementById("myRange");
sliderRange.max = dates.length-1;

var dateValue = document.getElementById("date_value");
dateValue.innerHTML = dates[sliderRange.value];
radar.getSource().updateParams({'TIME': dates[sliderRange.value]});

// Update the current slider value (each time you drag the slider handle)
sliderRange.oninput = function() {
  dateValue.innerHTML = dates[this.value];
  radar.getSource().updateParams({'TIME': dates[this.value]});
}
