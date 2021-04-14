/** Add layers to the map
 */

import map from '../map';
import TileLayer from 'ol/layer/Tile.js';
import OSM from 'ol/source/OSM';
import LayerGroup from 'ol/layer/Group'
import View from 'ol/View';
import XYZ from 'ol/source/XYZ';

//set up the url
const xyz_url = "https://www.davidjleifer.com/ppt_cor_xyz/ppt_cor_xyz_ppt_pearson_final_"
const xyz_ending = "/{z}/{x}/{y}.png"
//create year array to hold years between 1981 and 2014
const year = [];
for (var i = 1981; i <= 2014; i++) {
    year.push(i);
}

//create xyz_year to hold array of url strings
const xyz_year = [];
for (var ii in year){
  var staged = xyz_url + year[ii] + xyz_ending;
  xyz_year.push(staged);
};

//create array all_tile_layers to hold all the tile layers
const all_tile_layers = []
for (var iii in xyz_year){
  const staged_tile_layer = new TileLayer({
    title: '1981 Jan Correlation',
    source: new XYZ({
    url: xyz_year[iii],
    }),
  });
  all_tile_layers.push(staged_tile_layer);
};

/* OSM layer */
const osm = new TileLayer({
    title: 'OSM',
    source: new OSM()
});

/* Add to map */
map.addLayer(osm);
map.addLayer(all_tile_layers[0]);
//map.addLayer(year1991);
//map.addLayer(year2001);
//map.addLayer(year2011);
$(function() {
    $( "#slider" ).slider({
        value:3,
        step: 1,
        min: 1981,
        max: 2014,
       slide: function( event, ui ) {
          $( "#minbeds" ).val( ui.value );
       }    
    });
    $( "#minbeds" ).val( $( "#slider" ).slider( "value" ) );
});


$(document).ready(function(){
  $("#slider").on("slide", function(event, ui){
    var v = ui.value;
    Object.keys(all_tile_layers).forEach(function(key){
      if (v == year[key]){
        map.addLayer(all_tile_layers[key]);
      }
      else {
        map.removeLayer(all_tile_layers[key]);
      }
    });
 });
});

export {all_tile_layers, osm}
