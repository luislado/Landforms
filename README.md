# Landforms
Script to calculate Landforms from Digital Elevation Models using a modified function of the envRaster::land_class function.
The new functions is called 'landscapes' and eliminates the bug in the original function. 

The goal is to derive landscape class maps explained in the documentation of the envRaster package. 
The landscape features are grouped into 6 clases according to 
The landscape features are grouped into:
6 clases according to Weiss (2001) as follows:
– valleys
– lower slopes
– flat slopes
– middle slopes
– upper slopes
– ridges

or 10 classes according to Jenness (2006) as:
– canyons, deeply incised streams
– midslope drainages, shallow valleys
– upland drainages, headwaters
– u-shaped valleys
– plains
– open slopes
– upper slopes, mesas
– local ridges, hills in valleys
– midslope ridges, small hills
– mountain tops, high ridges

REFERENCES:
Jenness J (2006) Topographic Position Index (tpi_jen.avx) extension for ArcView 3.x, v. 1.3a. Jenness Enterprises. http://www. jennessent.com/arcview/tpi.htm

Weiss A (2001) Topographic position and landforms analysis. In: Poster presentation, ESRI user conference, San Diego, CA
