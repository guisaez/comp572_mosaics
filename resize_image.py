import os
from PIL import Image
os.getcwd()
collection = "./images"
for i, filename in enumerate(os.listdir(collection)):
   try:
      image = Image.open('./images/' + filename)
      image.thumbnail((150,150))
      image.save('./images/' + filename)
   except:
      continue
   