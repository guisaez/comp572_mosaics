import os
os.getcwd()
collection = "./images"
for i, filename in enumerate(os.listdir(collection)):
    os.rename('./images/' + filename, './images2/' + str(i+1) + ".jpg")