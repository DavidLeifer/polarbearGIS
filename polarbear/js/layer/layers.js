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

const fs = require('fs')

const ppt_pearson_final_1981_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_1981_reclassed.txt', 'utf8')
const ppt_pearson_final_1982_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_1982_reclassed.txt', 'utf8')
const ppt_pearson_final_1983_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_1983_reclassed.txt', 'utf8')
const ppt_pearson_final_1984_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_1984_reclassed.txt', 'utf8')
const ppt_pearson_final_1985_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_1985_reclassed.txt', 'utf8')
const ppt_pearson_final_1986_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_1986_reclassed.txt', 'utf8')
const ppt_pearson_final_1987_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_1987_reclassed.txt', 'utf8')
const ppt_pearson_final_1988_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_1988_reclassed.txt', 'utf8')
const ppt_pearson_final_1989_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_1989_reclassed.txt', 'utf8')
const ppt_pearson_final_1990_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_1990_reclassed.txt', 'utf8')
const ppt_pearson_final_1991_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_1991_reclassed.txt', 'utf8')
const ppt_pearson_final_1992_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_1992_reclassed.txt', 'utf8')
const ppt_pearson_final_1993_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_1993_reclassed.txt', 'utf8')
const ppt_pearson_final_1994_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_1994_reclassed.txt', 'utf8')
const ppt_pearson_final_1995_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_1995_reclassed.txt', 'utf8')
const ppt_pearson_final_1996_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_1996_reclassed.txt', 'utf8')
const ppt_pearson_final_1997_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_1997_reclassed.txt', 'utf8')
const ppt_pearson_final_1998_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_1998_reclassed.txt', 'utf8')
const ppt_pearson_final_1999_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_1999_reclassed.txt', 'utf8')
const ppt_pearson_final_2000_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_2000_reclassed.txt', 'utf8')
const ppt_pearson_final_2001_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_2001_reclassed.txt', 'utf8')
const ppt_pearson_final_2002_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_2002_reclassed.txt', 'utf8')
const ppt_pearson_final_2003_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_2003_reclassed.txt', 'utf8')
const ppt_pearson_final_2004_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_2004_reclassed.txt', 'utf8')
const ppt_pearson_final_2005_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_2005_reclassed.txt', 'utf8')
const ppt_pearson_final_2006_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_2006_reclassed.txt', 'utf8')
const ppt_pearson_final_2007_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_2007_reclassed.txt', 'utf8')
const ppt_pearson_final_2008_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_2008_reclassed.txt', 'utf8')
const ppt_pearson_final_2009_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_2009_reclassed.txt', 'utf8')
const ppt_pearson_final_2010_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_2010_reclassed.txt', 'utf8')
const ppt_pearson_final_2011_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_2011_reclassed.txt', 'utf8')
const ppt_pearson_final_2012_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_2012_reclassed.txt', 'utf8')
const ppt_pearson_final_2013_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_2013_reclassed.txt', 'utf8')
const ppt_pearson_final_2014_reclassed = fs.readFileSync('./data/reclassed_txt/ppt_pearson_final_2014_reclassed.txt', 'utf8')

const list_of_txt_var = [ppt_pearson_final_1981_reclassed,
                         ppt_pearson_final_1982_reclassed,
                         ppt_pearson_final_1983_reclassed,
                         ppt_pearson_final_1984_reclassed,
                         ppt_pearson_final_1985_reclassed,
                         ppt_pearson_final_1986_reclassed,
                         ppt_pearson_final_1987_reclassed,
                         ppt_pearson_final_1988_reclassed,
                         ppt_pearson_final_1989_reclassed,
                         ppt_pearson_final_1990_reclassed,
                         ppt_pearson_final_1991_reclassed,
                         ppt_pearson_final_1992_reclassed,
                         ppt_pearson_final_1993_reclassed,
                         ppt_pearson_final_1994_reclassed,
                         ppt_pearson_final_1995_reclassed,
                         ppt_pearson_final_1996_reclassed,
                         ppt_pearson_final_1997_reclassed,
                         ppt_pearson_final_1998_reclassed,
                         ppt_pearson_final_1999_reclassed,
                         ppt_pearson_final_2000_reclassed,
                         ppt_pearson_final_2001_reclassed,
                         ppt_pearson_final_2002_reclassed,
                         ppt_pearson_final_2003_reclassed,
                         ppt_pearson_final_2004_reclassed,
                         ppt_pearson_final_2005_reclassed,
                         ppt_pearson_final_2006_reclassed,
                         ppt_pearson_final_2007_reclassed,
                         ppt_pearson_final_2008_reclassed,
                         ppt_pearson_final_2009_reclassed,
                         ppt_pearson_final_2010_reclassed,
                         ppt_pearson_final_2011_reclassed,
                         ppt_pearson_final_2012_reclassed,
                         ppt_pearson_final_2013_reclassed,
                         ppt_pearson_final_2014_reclassed
                          ]

var words = list_of_txt_var[0].split(" ");
var zero_value = words[0].substr(0, 22);
document.getElementById('percentile_0').innerHTML = zero_value;
var twenty_value = words[1].substr(0, 22);
document.getElementById('percentile_20').innerHTML = twenty_value;
var forty_value = words[2].substr(0, 22);
document.getElementById('percentile_40').innerHTML = forty_value;
var sixty_value = words[3].substr(0, 22);
document.getElementById('percentile_60').innerHTML = sixty_value;
var eighty_value = words[4].substr(0, 22);
document.getElementById('percentile_80').innerHTML = eighty_value;

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
          Object.keys(all_tile_layers).forEach(function(key){
            if (v == year[key]){
              map.addLayer(all_tile_layers[key]);
              //split the txt file by space and send it to the p id in html doc
              var words = list_of_txt_var[key].split(" ");
              var zero_value = words[0].substr(0, 22);
              document.getElementById('percentile_0').innerHTML = zero_value;
              var twenty_value = words[1].substr(0, 22);
              document.getElementById('percentile_20').innerHTML = twenty_value;
              var forty_value = words[2].substr(0, 22);
              document.getElementById('percentile_40').innerHTML = forty_value;
              var sixty_value = words[3].substr(0, 22);
              document.getElementById('percentile_60').innerHTML = sixty_value;
              var eighty_value = words[4].substr(0, 22);
              document.getElementById('percentile_80').innerHTML = eighty_value;
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
