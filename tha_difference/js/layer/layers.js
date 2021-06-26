/** Add layers to the map
 */

import map from '../map';
import TileLayer from 'ol/layer/Tile.js';
import OSM from 'ol/source/OSM';
import LayerGroup from 'ol/layer/Group'
import View from 'ol/View';
import XYZ from 'ol/source/XYZ';

const tmean_elnino_minus_neutral_xyz = new TileLayer({
    title: 'EN Temp Diff',
    source: new XYZ({
    url: "https://www.davidjleifer.com/tmean_elnino_minus_neutral_xyz/{z}/{x}/{y}.png",
    }),
});
const tmean_lanina_minus_neutral_xyz = new TileLayer({
    title: 'LN Temp Diff',
    source: new XYZ({
    url: "https://www.davidjleifer.com/tmean_lanina_minus_neutral_xyz/{z}/{x}/{y}.png",
    }),
});
const ppt_elnino_minus_neutral_xyz = new TileLayer({
    title: 'EN PPT Diff',
    source: new XYZ({
    url: "https://www.davidjleifer.com/ppt_elnino_minus_neutral_xyz/{z}/{x}/{y}.png",
    }),
});

const ppt_lanina_minus_neutral_xyz = new TileLayer({
    title: 'LN PPT Diff',
    source: new XYZ({
    url: "https://www.davidjleifer.com/ppt_lanina_minus_neutral_xyz/{z}/{x}/{y}.png",
    }),
});

/* OSM layer */
const osm = new TileLayer({
    title: 'OSM',
    source: new OSM()
});

/* Add to map */
map.addLayer(osm);
map.addLayer(tmean_elnino_minus_neutral_xyz);

$(function() {
    $( "#slider" ).slider({
        value:0,
        step: 1,
        min: 0,
        max: 3,
       slide: function( event, ui ) {
          $( "#minbeds" ).val( ui.value );
       }    
    });
    $( "#minbeds" ).val( $( "#slider" ).slider( "value" ) );
});


$(document).ready(function(){
 $("#slider").on("slide", function(event, ui){
   var v = ui.value;
   console.log(ui.value);
   if(v == "0"){
      console.log("0");
      map.removeLayer(tmean_lanina_minus_neutral_xyz);
      map.removeLayer(ppt_elnino_minus_neutral_xyz);
      map.removeLayer(ppt_lanina_minus_neutral_xyz);
      map.addLayer(tmean_elnino_minus_neutral_xyz);
   }
   else if (v == "1"){
      map.removeLayer(tmean_elnino_minus_neutral_xyz);
      map.removeLayer(tmean_lanina_minus_neutral_xyz);
      map.removeLayer(ppt_elnino_minus_neutral_xyz);
      map.removeLayer(ppt_lanina_minus_neutral_xyz);
      map.addLayer(tmean_lanina_minus_neutral_xyz);
      console.log("1");
      }
    else if (v == "2"){
      map.removeLayer(tmean_elnino_minus_neutral_xyz);
      map.removeLayer(tmean_lanina_minus_neutral_xyz);
      map.removeLayer(ppt_elnino_minus_neutral_xyz);
      map.removeLayer(ppt_lanina_minus_neutral_xyz);
      map.addLayer(ppt_elnino_minus_neutral_xyz);
      console.log("2");
      }
    else if (v == "3"){
      map.removeLayer(tmean_elnino_minus_neutral_xyz);
      map.removeLayer(tmean_lanina_minus_neutral_xyz);
      map.removeLayer(ppt_elnino_minus_neutral_xyz);
      map.removeLayer(ppt_lanina_minus_neutral_xyz);
      map.addLayer(ppt_lanina_minus_neutral_xyz);
      console.log("3");
      }
    else{
      console.log("Fuckified");
   } 
 });
});

export {tmean_elnino_minus_neutral_xyz, tmean_lanina_minus_neutral_xyz, ppt_elnino_minus_neutral_xyz, ppt_lanina_minus_neutral_xyz, osm}
