/** Add layers to the map
 */

import map from '../map';
import TileLayer from 'ol/layer/Tile.js';
import OSM from 'ol/source/OSM';
import LayerGroup from 'ol/layer/Group'
import View from 'ol/View';
import XYZ from 'ol/source/XYZ';

const xyz_tmeanJanELNin = new TileLayer({
    title: 'Mean Jan El Nino Temp',
    source: new XYZ({
    url: "https://www.davidjleifer.com/tmean_bil2tif_LaElNeu_analysis_xyz/xyz_tmeanJanELNin/{z}/{x}/{y}.png",
    }),
});
const xyz_tmeanJanLANin = new TileLayer({
    title: 'Mean Jan La Nina Temp',
    source: new XYZ({
    url: "https://www.davidjleifer.com/tmean_bil2tif_LaElNeu_analysis_xyz/xyz_tmeanJanLANin/{z}/{x}/{y}.png",
    }),
});
const xyz_tmeanJanNeutral = new TileLayer({
    title: 'Mean Jan Neutral Temp',
    source: new XYZ({
    url: "https://www.davidjleifer.com/tmean_bil2tif_LaElNeu_analysis_xyz/xyz_tmeanJanNeutral/{z}/{x}/{y}.png",
    }),
});

const xyz_pptJanELNin = new TileLayer({
    title: 'Mean Jan El Nino ppt',
    source: new XYZ({
    url: "https://www.davidjleifer.com/ppt_bil2tif_LaElNeu_analysis_xyz/xyz_pptJanELNin/{z}/{x}/{y}.png",
    }),
});
const xyz_pptJanLANin = new TileLayer({
    title: 'Mean Jan La Nina ppt',
    source: new XYZ({
    url: "https://www.davidjleifer.com/ppt_bil2tif_LaElNeu_analysis_xyz/xyz_pptJanLANin/{z}/{x}/{y}.png",
    }),
});
const xyz_pptJanNeutral = new TileLayer({
    title: 'Mean Jan Neutral ppt',
    source: new XYZ({
    url: "https://www.davidjleifer.com/ppt_bil2tif_LaElNeu_analysis_xyz/xyz_pptJanNeutral/{z}/{x}/{y}.png",
    }),
});

/* OSM layer */
const osm = new TileLayer({
    title: 'OSM',
    source: new OSM()
});

/* Add to map */
map.addLayer(osm);
map.addLayer(xyz_tmeanJanELNin);
//map.addLayer(xyz_tmeanJanLANin);
//map.addLayer(xyz_tmeanJanNeutral);
//map.addLayer(xyz_pptJanELNin);
//map.addLayer(xyz_pptJanLANin);
//map.addLayer(xyz_pptJanNeutral);

$(function() {
    $( "#slider" ).slider({
        value:0,
        step: 1,
        min: 0,
        max: 5,
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
      map.removeLayer(xyz_tmeanJanLANin);
      map.removeLayer(xyz_tmeanJanNeutral);
      map.removeLayer(xyz_pptJanELNin);
      map.removeLayer(xyz_pptJanLANin);
      map.removeLayer(xyz_pptJanNeutral);
      map.addLayer(xyz_tmeanJanELNin);
   }
   else if (v == "1"){
      map.removeLayer(xyz_tmeanJanELNin);
      map.removeLayer(xyz_tmeanJanLANin);
      map.removeLayer(xyz_tmeanJanNeutral);
      map.removeLayer(xyz_pptJanELNin);
      map.removeLayer(xyz_pptJanLANin);
      map.removeLayer(xyz_pptJanNeutral);
      map.addLayer(xyz_tmeanJanLANin);
      console.log("1");
      }
    else if (v == "2"){
      map.removeLayer(xyz_tmeanJanELNin);
      map.removeLayer(xyz_tmeanJanLANin);
      map.removeLayer(xyz_tmeanJanNeutral);
      map.removeLayer(xyz_pptJanELNin);
      map.removeLayer(xyz_pptJanLANin);
      map.removeLayer(xyz_pptJanNeutral);
      map.addLayer(xyz_tmeanJanNeutral);
      console.log("2");
      }
    else if (v == "3"){
      map.removeLayer(xyz_tmeanJanELNin);
      map.removeLayer(xyz_tmeanJanLANin);
      map.removeLayer(xyz_tmeanJanNeutral);
      map.removeLayer(xyz_pptJanELNin);
      map.removeLayer(xyz_pptJanLANin);
      map.removeLayer(xyz_pptJanNeutral);
      map.addLayer(xyz_pptJanELNin);
      console.log("3");
      }
    else if (v == "4"){
      map.removeLayer(xyz_tmeanJanELNin);
      map.removeLayer(xyz_tmeanJanLANin);
      map.removeLayer(xyz_tmeanJanNeutral);
      map.removeLayer(xyz_pptJanELNin);
      map.removeLayer(xyz_pptJanLANin);
      map.removeLayer(xyz_pptJanNeutral);
      map.addLayer(xyz_pptJanLANin);
      console.log("4");
      }
    else if (v == "5"){
      map.removeLayer(xyz_tmeanJanELNin);
      map.removeLayer(xyz_tmeanJanLANin);
      map.removeLayer(xyz_tmeanJanNeutral);
      map.removeLayer(xyz_pptJanELNin);
      map.removeLayer(xyz_pptJanLANin);
      map.removeLayer(xyz_pptJanNeutral);
      map.addLayer(xyz_pptJanNeutral);
      console.log("5");
      }
    else{
      console.log("Fuckified");
   } 
 });
});

export {xyz_tmeanJanELNin, xyz_tmeanJanLANin, xyz_tmeanJanNeutral, xyz_pptJanELNin, xyz_pptJanLANin, xyz_pptJanNeutral, osm}
