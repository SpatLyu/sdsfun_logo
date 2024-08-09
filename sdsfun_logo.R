library(showtext)
showtext_auto(enable = TRUE)
font_add("ShineTypewriter", regular = "./ShineTypewriter-lgwzd.ttf")
library(magick)
library(hexSticker)

sticker(
  subplot = './bg.png',
  s_x = 0.96,
  s_y = 0.95,
  s_width = 2,
  s_height = 2,
  package = "sdsfun",
  p_family = "ShineTypewriter",
  p_size = 25,
  p_color = ggplot2::alpha("#ffffff",.85),
  p_x = 1.05,
  p_y = 1,
  dpi = 300,
  asp = 1,
  h_size = 1.75,
  h_color = ggplot2::alpha("#d8c8ab",.75),
  h_fill = ggplot2::alpha('#ffffff',0),
  white_around_sticker = T,
  url = "https://spatlyu.github.io/sdsfun",
  u_color = "white",
  u_size = 4.5,
  filename = "sdsfun_logo1.png"
)

# finally make sdsfun_logo1.png background transparent
# https://uutool.cn/img-matting/

image_read('./sdsfun_logo1.png') |> 
  image_resize("256x256")|> 
  image_write('./sdsfun_logo.png')

