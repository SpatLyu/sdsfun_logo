# setwd('d:/download/sdsfun_logo/')

# bg

library(sf)
library(tidyverse)

'PROJCS["World_Robinson",
    GEOGCS["WGS 84",
        DATUM["WGS_1984",
            SPHEROID["WGS 84",6378137,298.257223563,
                AUTHORITY["EPSG","7030"]],
            AUTHORITY["EPSG","6326"]],
        PRIMEM["Greenwich",0],
        UNIT["Degree",0.0174532925199433]],
    PROJECTION["Robinson"],
    PARAMETER["longitude_of_center",150],
    PARAMETER["false_easting",0],
    PARAMETER["false_northing",0],
    UNIT["metre",1,
        AUTHORITY["EPSG","9001"]],
    AXIS["Easting",EAST],
    AXIS["Northing",NORTH],
    AUTHORITY["ESRI","54030"]]' -> targetCrs

urban = rnaturalearth::ne_download(scale = 10 ,
                                   type = "urban_areas") |> 
  rmapshaper::ms_simplify(keep_shapes = T) |> 
  st_transform(targetCrs)

continent = geocn::load_world_continent()

c(-0.0001 - 30, 90, 0 - 30, 90, 0 - 30, -90,
  -0.0001 - 30, -90, -0.0001 - 30, 90) |> 
  matrix(ncol = 2, byrow = TRUE) |> 
  list() |> 
  st_polygon() |> 
  st_sfc(crs = 4326) %>% 
  st_sf(geometry = .) -> polygon

continent |> 
  st_difference(polygon) |> 
  st_collection_extract() |> 
  st_transform(st_crs(targetCrs)) |> 
  st_cast('MULTIPOLYGON')-> continent

ggplot() +
  geom_sf(data = continent,
          fill = "#090D2A") +
  geom_sf(data = urban,
          color = "#FDF5E6") +
  theme_void() +
  theme(panel.background = element_rect(fill = "#00001C",
                                        color = "#00001C"),
        panel.grid = element_blank(), 
        axis.ticks = element_blank(), 
        axis.title = element_blank(),
        axis.text = element_blank()) -> bg_plot
ggsave('./bg.png', bg_plot, dpi = 120, width = 6.95, height = 6)

# bg1 

library(terra)

hyp = rast('/vsizip/{hypsrw.zip}/hypsrw.tif')

writeRaster(hyp,
            "./bg1.png",
            overwrite = T,
            NAflag = 255)
