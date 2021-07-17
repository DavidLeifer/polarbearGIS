/** Add layers to the map
 */

import map from '../map';
import TileLayer from 'ol/layer/Tile.js';
import OSM from 'ol/source/OSM';
import LayerGroup from 'ol/layer/Group'
import View from 'ol/View';
import XYZ from 'ol/source/XYZ';

//set up the url
const xyz_url = "https://www.davidjleifer.com/tmean_cor_xyz/tmean_cor_xyz_tmean_pearson_final_"
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
//loop over xyz_year and year arrays
const all_tile_layers = []
xyz_year.forEach((iii, index) => {
  const num2 = year[index];
  const staged_tile_layer = new TileLayer({
    title: num2 + ' Jan Correlation',
    source: new XYZ({
    url: iii,
    }),
  });
  all_tile_layers.push(staged_tile_layer);
});

/* OSM layer */
const osm = new TileLayer({
    title: 'OSM',
    source: new OSM()
});

/* Add to map */
map.addLayer(osm);
map.addLayer(all_tile_layers[0]);

//angular
var myApp = angular.module('myApp', ['rzSlider'])
myApp.controller('GreetingController', ['$scope', function($scope) {
    var dates = [];
    for (var i = 1981; i <= 2014; i++) {
      dates.push(i);
    }
    $scope.slider = {
      value: dates[0],
      options: {
        stepsArray: dates,
        id: 'slider-id',
        onChange: function(event, id) {
          var v = id;
          console.log(v)
          Object.keys(all_tile_layers).forEach(function(key){
            if (v == year[key]){
              map.addLayer(all_tile_layers[key]);
            }
            else {
              map.removeLayer(all_tile_layers[key]);
            }
          });
        }
      }
    };
}]);

export {all_tile_layers, osm}