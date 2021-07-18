/** Add layers to the map
 */

import map from '../map';
import TileLayer from 'ol/layer/Tile.js';
import OSM from 'ol/source/OSM';
import LayerGroup from 'ol/layer/Group'
import View from 'ol/View';
import XYZ from 'ol/source/XYZ';
import 'regenerator-runtime/runtime';

//set up the 2 url for cor and og ppt
const xyz_url = "https://www.davidjleifer.com/ppt_cor_xyz/ppt_cor_xyz_ppt_pearson_final_"
const ppt_bil2tif_resize_url = "https://www.davidjleifer.com/ppt_bil2tif_resize_xyz/ppt_bil2tif_resize_xyz_ppt_bil2tif_resize_"
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

//create ppt_bil2tif_resize_year to hold array of url strings
const ppt_bil2tif_resize_year = [];
for (var ii in year){
  var staged = ppt_bil2tif_resize_url + year[ii] + xyz_ending;
  ppt_bil2tif_resize_year.push(staged);
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

//create array ppt_bil2tif_resize_all to hold all the tile layers
//loop over ppt_bil2tif_resize_year and year arrays
const ppt_bil2tif_resize_all = []
ppt_bil2tif_resize_year.forEach((iiii, index) => {
  const ppt_num2 = year[index];
  const ppt_staged_tile_layer = new TileLayer({
    title: ppt_num2 + ' Jan ppt',
    source: new XYZ({
    url: iiii,
    }),
  });
  ppt_bil2tif_resize_all.push(ppt_staged_tile_layer);
});

/* OSM layer */
const osm = new TileLayer({
    title: 'OSM',
    source: new OSM()
});

/* Add to map */
map.addLayer(osm);
map.addLayer(all_tile_layers[0]);

//promise and await for the ppt layer
function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}
async function demo() {
  await sleep(5000);
  map.addLayer(ppt_bil2tif_resize_all[0])
}
demo();

//read in all the cor quantile values, because arrays dont work for this
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

//read in ppt mm quantiles
const ppt_bil2tif_resize_1981_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_1981_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_1982_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_1982_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_1983_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_1983_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_1984_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_1984_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_1985_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_1985_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_1986_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_1986_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_1987_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_1987_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_1988_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_1988_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_1989_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_1989_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_1990_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_1990_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_1991_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_1991_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_1992_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_1992_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_1993_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_1993_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_1994_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_1994_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_1995_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_1995_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_1996_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_1996_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_1997_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_1997_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_1998_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_1998_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_1999_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_1999_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_2000_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_2000_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_2001_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_2001_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_2002_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_2002_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_2003_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_2003_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_2004_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_2004_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_2005_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_2005_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_2006_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_2006_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_2007_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_2007_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_2008_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_2008_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_2009_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_2009_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_2010_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_2010_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_2011_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_2011_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_2012_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_2012_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_2013_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_2013_reclassed.txt', 'utf8')
const ppt_bil2tif_resize_2014_reclassed = fs.readFileSync('./data/reclassed_txt_ppt_og/ppt_bil2tif_resize_2014_reclassed.txt', 'utf8')

const list_of_ppt_var = [ppt_bil2tif_resize_1981_reclassed,
                         ppt_bil2tif_resize_1982_reclassed,
                         ppt_bil2tif_resize_1983_reclassed,
                         ppt_bil2tif_resize_1984_reclassed,
                         ppt_bil2tif_resize_1985_reclassed,
                         ppt_bil2tif_resize_1986_reclassed,
                         ppt_bil2tif_resize_1987_reclassed,
                         ppt_bil2tif_resize_1988_reclassed,
                         ppt_bil2tif_resize_1989_reclassed,
                         ppt_bil2tif_resize_1990_reclassed,
                         ppt_bil2tif_resize_1991_reclassed,
                         ppt_bil2tif_resize_1992_reclassed,
                         ppt_bil2tif_resize_1993_reclassed,
                         ppt_bil2tif_resize_1994_reclassed,
                         ppt_bil2tif_resize_1995_reclassed,
                         ppt_bil2tif_resize_1996_reclassed,
                         ppt_bil2tif_resize_1997_reclassed,
                         ppt_bil2tif_resize_1998_reclassed,
                         ppt_bil2tif_resize_1999_reclassed,
                         ppt_bil2tif_resize_2000_reclassed,
                         ppt_bil2tif_resize_2001_reclassed,
                         ppt_bil2tif_resize_2002_reclassed,
                         ppt_bil2tif_resize_2003_reclassed,
                         ppt_bil2tif_resize_2004_reclassed,
                         ppt_bil2tif_resize_2005_reclassed,
                         ppt_bil2tif_resize_2006_reclassed,
                         ppt_bil2tif_resize_2007_reclassed,
                         ppt_bil2tif_resize_2008_reclassed,
                         ppt_bil2tif_resize_2009_reclassed,
                         ppt_bil2tif_resize_2010_reclassed,
                         ppt_bil2tif_resize_2011_reclassed,
                         ppt_bil2tif_resize_2012_reclassed,
                         ppt_bil2tif_resize_2013_reclassed,
                         ppt_bil2tif_resize_2014_reclassed
                          ]

//add in txt files for initial year for cor quantiles
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

//add in txt files for initial year for ppt_og quantiles
var words_og = list_of_ppt_var[0].split(" ");
var zero_value_og = words_og[0].substr(0, 22);
document.getElementById('percentile_0_ppt_og').innerHTML = zero_value_og;
var twenty_value_og = words_og[1].substr(0, 22);
document.getElementById('percentile_20_ppt_og').innerHTML = twenty_value_og;
var forty_value_og = words_og[2].substr(0, 22);
document.getElementById('percentile_40_ppt_og').innerHTML = forty_value_og;
var sixty_value_og = words_og[3].substr(0, 22);
document.getElementById('percentile_60_ppt_og').innerHTML = sixty_value_og;
var eighty_value_og = words_og[4].substr(0, 22);
document.getElementById('percentile_80_ppt_og').innerHTML = eighty_value_og;

//read in nino34 index
const elnino_index_sub = fs.readFileSync('../data/nino34.csv', 'utf8').substr(16, 352);
//replace the strings and split by comma
const elnino_index = elnino_index_sub.replace(/\n/g, ",").split(",")
//get every other index value and make an array
const elnino_index_value = elnino_index.filter((element, index) => {
  return index % 2 === 0;
})
document.getElementById('nino').innerHTML = elnino_index_value[0];
//make initial year type
document.getElementById('year_type').innerHTML = "Neutral"

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
              //wait 5 seconds to add the ppt layer
              async function demo1() {
                await sleep(5000);
                map.addLayer(ppt_bil2tif_resize_all[key])
              }
              demo1();
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
              //add in nino index
              var nino_index_key = elnino_index_value[key]
              //logic to decide what year type it is
              document.getElementById('nino').innerHTML = nino_index_key;
              if (nino_index_key > .5){
                document.getElementById('year_type').innerHTML = "El Nino"
              } else if (nino_index_key < -.5){
                document.getElementById('year_type').innerHTML = "La Nina"
              } else{
                document.getElementById('year_type').innerHTML = "Neutral"
              }
              //add in txt files for initial year for ppt_og quantiles
              var words_og = list_of_ppt_var[key].split(" ");
              var zero_value_og = words_og[0].substr(0, 22);
              document.getElementById('percentile_0_ppt_og').innerHTML = zero_value_og;
              var twenty_value_og = words_og[1].substr(0, 22);
              document.getElementById('percentile_20_ppt_og').innerHTML = twenty_value_og;
              var forty_value_og = words_og[2].substr(0, 22);
              document.getElementById('percentile_40_ppt_og').innerHTML = forty_value_og;
              var sixty_value_og = words_og[3].substr(0, 22);
              document.getElementById('percentile_60_ppt_og').innerHTML = sixty_value_og;
              var eighty_value_og = words_og[4].substr(0, 22);
              document.getElementById('percentile_80_ppt_og').innerHTML = eighty_value_og;
            }
            else {
              map.removeLayer(all_tile_layers[key]);
              map.removeLayer(ppt_bil2tif_resize_all[key])
              //remove ppt layer
              async function demo2() {
                await sleep(5001);
                //clear the map of ppt layer
                map.removeLayer(ppt_bil2tif_resize_all[key])
              }
              demo2();
            }
          });
        }
      }
    };
}]);

export {all_tile_layers, osm, ppt_bil2tif_resize_all}
