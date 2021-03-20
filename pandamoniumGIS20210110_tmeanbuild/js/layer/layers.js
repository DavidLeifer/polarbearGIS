/** Add layers to the map
 */

import map from '../map';
import TileLayer from 'ol/layer/Tile.js';
import OSM from 'ol/source/OSM';
import LayerGroup from 'ol/layer/Group'
import View from 'ol/View';
import XYZ from 'ol/source/XYZ';

const year1981 = new TileLayer({
    title: '1981 Jan Correlation',
    source: new XYZ({
    url: "https://davidjleifer.com/tmean_cor_xyz/tmean_cor_xyz_tmean_pearson_final_1981/{z}/{x}/{y}.png",
    }),
});
const year1991 = new TileLayer({
    title: '1991 Jan Correlation',
    source: new XYZ({
    url: "https://davidjleifer.com/tmean_cor_xyz/tmean_cor_xyz_tmean_pearson_final_1991/{z}/{x}/{y}.png",
    }),
});
const year2001 = new TileLayer({
    title: '2001 Jan Correlation',
    source: new XYZ({
    url: "https://davidjleifer.com/tmean_cor_xyz/tmean_cor_xyz_tmean_pearson_final_2001/{z}/{x}/{y}.png",
    }),
});
const year2011 = new TileLayer({
    title: '2011 Jan Correlation',
    source: new XYZ({
    url: "https://davidjleifer.com/tmean_cor_xyz/tmean_cor_xyz_tmean_pearson_final_2011/{z}/{x}/{y}.png",
    }),
});

/* OSM layer */
const osm = new TileLayer({
    title: 'OSM',
    source: new OSM()
});

/* Add to map */
map.addLayer(osm);
map.addLayer(year1981);
//map.addLayer(year1991);
//map.addLayer(year2001);
//map.addLayer(year2011);

$(function() {
    $( "#slider" ).slider({
        value:3,
        step: 10,
        min: 1981,
        max: 2011,
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
   if(v == "1981"){
      console.log("1981");
      map.removeLayer(year1991);
      map.removeLayer(year2001);
      map.removeLayer(year2011);
      map.addLayer(year1981);
   }
   else if (v == "1991"){
      map.removeLayer(year1981);
      map.removeLayer(year1991);
      map.removeLayer(year2001);
      map.removeLayer(year2011);
      map.addLayer(year1991);
      console.log("1991");
      }
    else if (v == "2001"){
      map.removeLayer(year1981);
      map.removeLayer(year1991);
      map.removeLayer(year2001);
      map.removeLayer(year2011);
      map.addLayer(year2001);
      console.log("2001");
      }
    else if (v == "2011"){
      map.removeLayer(year1981);
      map.removeLayer(year1991);
      map.removeLayer(year2001);
      map.removeLayer(year2011);
      map.addLayer(year2011);
      console.log("2011");
      }
    else{
      console.log("Fuckified");
   } 
 });
});

export {year1981, year1991, year2001, year2011, osm}
