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

//make invis
//polarVortex_six30_layer.setStyle(invis_style)

/* Add to map */
map.addLayer(basemap);
map.addLayer(radar);

//empty array for our date
var date = [];
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
    //console.log(`${property}: ${geojson[property]}`);
    //Proimise and await. who came up with that, its a(time)sync function
    function resolveAfter2Seconds(x) {
      return new Promise(resolve => {
        setTimeout(() => {
          resolve(x);
        }, 2000);
        radar.addEventListener('change', style_points, false);
      });
    };
    async function style_points() {
      var x = await resolveAfter2Seconds(10);
      //var uidIndex_ = polarVortex_six30_layer.get("source").uidIndex_;
      all_ween.getSource().forEachFeature(function(feature){
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
    map.addLayer(all_ween);
    // Define the available dates

    date.push(property)
}
console.log(date)

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

// Define the available dates
var dates = ['2019-01-29T18:30:00.000Z', '2019-01-29T18:45:00.000Z', '2019-01-29T19:00:00.000Z', '2019-01-29T19:15:00.000Z', 
             '2019-01-29T19:30:00.000Z', '2019-01-29T19:45:00.000Z', '2019-01-29T20:00:00.000Z']

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

radar.addEventListener('change', point_changer, false);
function point_changer(){
  var el = document.getElementById('date_value').textContent;
  console.log(el)
  if (el == "2019-01-29T18:30:00.000Z"){
  	map.addLayer(polarVortex_six30_layer);
  	map.removeLayer(polarVortex_six45_layer);
  	map.removeLayer(polarVortex_seven_layer);
  	map.removeLayer(polarVortex_seven15_layer);
  	map.removeLayer(polarVortex_seven30_layer);
  	map.removeLayer(polarVortex_seven45_layer);
  	map.removeLayer(polarVortex_eight_layer);
  }
  else if (el == "2019-01-29T18:45:00.000Z"){
  	map.addLayer(polarVortex_six45_layer);
  	map.removeLayer(polarVortex_six30_layer);
  	map.removeLayer(polarVortex_seven_layer);
  	map.removeLayer(polarVortex_seven15_layer);
  	map.removeLayer(polarVortex_seven30_layer);
  	map.removeLayer(polarVortex_seven45_layer);
  	map.removeLayer(polarVortex_eight_layer);
  }
  else if (el == "2019-01-29T19:00:00.000Z"){
  	map.addLayer(polarVortex_seven_layer);
  	map.removeLayer(polarVortex_six30_layer);
  	map.removeLayer(polarVortex_six45_layer);
  	map.removeLayer(polarVortex_seven15_layer);
  	map.removeLayer(polarVortex_seven30_layer);
  	map.removeLayer(polarVortex_seven45_layer);
  	map.removeLayer(polarVortex_eight_layer);
  }
  else if (el == "2019-01-29T19:15:00.000Z"){
  	map.addLayer(polarVortex_seven15_layer);
  	map.removeLayer(polarVortex_six30_layer);
  	map.removeLayer(polarVortex_six45_layer);
  	map.removeLayer(polarVortex_seven_layer);
  	map.removeLayer(polarVortex_seven30_layer);
  	map.removeLayer(polarVortex_seven45_layer);
  	map.removeLayer(polarVortex_eight_layer);
  }
  else if (el == "2019-01-29T19:30:00.000Z"){
  	map.addLayer(polarVortex_seven30_layer);
  	map.removeLayer(polarVortex_six30_layer);
  	map.removeLayer(polarVortex_six45_layer);
  	map.removeLayer(polarVortex_seven_layer);
  	map.removeLayer(polarVortex_seven15_layer);
  	map.removeLayer(polarVortex_seven45_layer);
  	map.removeLayer(polarVortex_eight_layer);
  }
  else if (el == "2019-01-29T19:45:00.000Z"){
  	map.addLayer(polarVortex_seven45_layer);
  	map.removeLayer(polarVortex_six30_layer);
  	map.removeLayer(polarVortex_six45_layer);
  	map.removeLayer(polarVortex_seven_layer);
  	map.removeLayer(polarVortex_seven15_layer);
  	map.removeLayer(polarVortex_seven30_layer);
  	map.removeLayer(polarVortex_eight_layer);
  }
  else if (el == "2019-01-29T20:00:00.000Z"){
  	map.addLayer(polarVortex_eight_layer);
  	map.removeLayer(polarVortex_six30_layer);
  	map.removeLayer(polarVortex_six45_layer);
  	map.removeLayer(polarVortex_seven_layer);
  	map.removeLayer(polarVortex_seven15_layer);
  	map.removeLayer(polarVortex_seven30_layer);
  	map.removeLayer(polarVortex_seven45_layer);
  }

};



