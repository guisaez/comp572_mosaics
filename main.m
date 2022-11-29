%% Mosaics Project %%

%% Author: Guillermo Saez Santana
%% PID: 730-445-041

%{
%% ----- Objective -----
Given a target image, the objective is to recreate the image as a mosaic
that gets images from an images dataset. The quality of the created mosaic
depends on the amount of imgPerRow parameter (amount of pictures per row).

Input: img (Target Image), imgPerRow (Amount of Images Per Row)
Output: mosaic (Mosaic Image)

%% ----- Image Dataset -----
The image dataset for this project was downloaded from 
https://www.kaggle.com/datasets/puneet6060/intel-image-classification?resource=download
The Intel Image Classifiaction Dataset includes 7301 images of Nature
around the Wolrd.
    * Buildings images 
    * Forest images
    * Glacier images 
    * Mountain imagess
    * Sea images
    * Street images 
This Image dataset was intended for creating a Neural Network able to
clissify the images.

%% ----- Results ------
Notice that in order to see the results, the output images have been
provided since the proram cannot work with the image dataset throught the
grader platform. We can see that the output images successfully represent
the target picture and the color contrast they create is similar to the
original due to the avergae color modification before placing the tile.
Additionally, we can see that some of the images repeat but at a lower
frequency since for each original tile is selecting the top-k images and
choosing one at random. 
Notes: 
    The quality of the results is shown better on function calls that have
    a lower number of TilesPerRow, that is, tiles are going represent most
    of the picture at the cost of not being able to visualize all small
    details on the target picture.

    If we increase the number of TilesPerRow, the mosaic will be compose of
    more images and the small details of the target picture are going to
    be detected easily.

    Both examples are provided.

%% ----- Procedure -----
The image dataset for this project was downloaded locally from flicker.com
(the image dataset has also been uploaded to gitHub). Every picture of the
image dataset was renamed and resize to 100 by 100 using python scripts.
(rename_files.py and resize_image.py).

Pyhtons scrypts can be found here: 
# https://github.com/guisaez/comp_572_mosaics

%% ----- Algorithm -----

%% 1. Reading in Tiles 
1.1 - Read all the tiles from source folder.
1.2 - Resize the images to ensure they all have the same height and width
(not squared tiles will modify aspect ratio of image (stretch, make wide))
1.3 - Calculate the average value for each color channel of each tile and
store it in memory.

%% 2. Reading in Target Image
2.1 - Make sure the formatted img is in double format using im2double(img)

%% 3. Reading in Dimensions to Create Grid
3.1 - Get single tile dimensions.
3.2 - Get target image dimensions.

%% 4. Cell Grid Dimensions
4.1 - CellGridWidth = floor(target_width / imgTilesPerRow)
4.2 - CellGridHight = round(CellGridWidth * TileHeight / TileWidth)
4.3 - TilesPerColumn = floor(target_height / CellGridHeight)

%% 5. Divide the Image into Subimages, Place Them in the Corresponding Grid
%%    And Find the Averge of Each Color Channel for Subimage.
For each tile Top-to-Bottom
   For each tile Left-to-Right
     imagePortion = img(1 + (i-1 * CellGridHeight):i*cellGridHeight),
                       (1 + (j-1 * CellGridWidth):j*cellGridWidth)
    
     Find Average of Image portion and store it in memory.
     grid{i,j} = subimage.

%% 6. Find the Best Candidate for each SubImage and Store the corresponding
%% Index.
6.1 - Create index table to store the index of the selected tile.
6.2 - For every subimage, finds its average.
    6.2.1 - Compare the average with the average of each tile.
    6.2.2 - Compare the differences between averages and select k tiles with the
lowest differences.
    6.2.3 - Randomly select one tile out of the selected k tiles.
6.3 - Return completed index table.

%% 7. For each grid, replace grid content with tile at bestIndex.
7.1 - Compare the average color for the original sub-image.
7.2 - Multiply the new tile times a factor to generate similar color
average.
7.3 - Place adjusted tile in grid.

%% 8. Use cell2mat to create final image.
%}

%% Define desired tile Width and Height (UP TO 100 DUE TO TILE ORIGINAL SIZE), If we want to keep the original
%% aspect of the image we have to provide equal values (avoid stretching image)
TILE_HEIGHT = 100;
TILE_WIDTH = 100;

%% Fetch all tiles and their averages. (COMMENTED FOR MATLAB GRADER)
% tilesAverage = getTilesAndTilesAverages(TILE_HEIGHT, TILE_WIDTH);

%% Target 1
disp('Image 1: 55 Tiles Per Row')
target = imread("https://raw.githubusercontent.com/guisaez/comp_572_mosaics/master/in/heart-shape-hand.jpg");
% Commented for Matlab Grader
% result = createMosaic(target, 55, tilesAverage, TILE_HEIGHT, TILE_WIDTH);
% imwrite(result, './out/heart-shape-hand.jpg');
result = imread('https://raw.githubusercontent.com/guisaez/comp_572_mosaics/master/out/heart-shape-hand.jpg');
figure; montage({target, result});
figure; imshow(result);

%% Target 2
disp('Image 2: 25 Tiles Per Row (Bad Result)')
target = imread('https://raw.githubusercontent.com/guisaez/comp_572_mosaics/master/in/world_cup.jpeg');
%% Using Small Number of Tiles Per Row (10)
% Commented for Matlab Grader
% result = createMosaic(target, 25, tilesAverage, TILE_HEIGHT, TILE_WIDTH);
% imwrite(result, './out/wolrd_cup.jpg');
result = imread('https://raw.githubusercontent.com/guisaez/comp_572_mosaics/master/out/wolrd_cup.jpg');
figure; montage({target, result});
figure; imshow(result);

%% Target 2.1
disp('Image 2: 82 Tiles Per Row (Better Result)')
%% Using a reasonable number of Tiles Per Row(70)
% Commented for Matlab Grader
% result = createMosaic(target, 82, tilesAverage, TILE_HEIGHT, TILE_WIDTH);
% imwrite(result, './out/wolrd_cup2.jpg');
result = imread('https://raw.githubusercontent.com/guisaez/comp_572_mosaics/master/out/wolrd_cup2.jpg');
figure; montage({target, result});
figure; imshow(result);

%% Target 3
disp('Image 3: 45 Tiles Per Row (Standard Result)')
target = imread('https://raw.githubusercontent.com/guisaez/comp_572_mosaics/master/in/mona_lisa.jpeg');
%% Using Reasonable-Low Number of Tiles Per Row(40)
% Commented for Matlab Grader
% result = createMosaic(target, 45, tilesAverage, TILE_HEIGHT, TILE_WIDTH);
% imwrite(result, './out/mona_lisa.jpg');
result = imread('https://raw.githubusercontent.com/guisaez/comp_572_mosaics/master/out/mona_lisa.jpg');
figure; montage({target, result});
figure; imshow(result);

%% Target 3.1
disp('Image 3: 80 Tiles Per Row (Better Quality)')
%% Using Large Amout of Tiles Per Row (90)
% Commented for Matlab Grader
% result = createMosaic(target, 80, tilesAverage, TILE_HEIGHT, TILE_WIDTH);
% imwrite(result, './out/mona_lisa2.jpg');
result = imread('https://raw.githubusercontent.com/guisaez/comp_572_mosaics/master/out/mona_lisa2.jpg');
figure; montage({target, result});
figure; imshow(result);

%% Target 4
disp('Image 4: 60 Tiles Per Row')
target = imread('https://raw.githubusercontent.com/guisaez/comp_572_mosaics/master/in/portrait.jpg');
% Commented for Matlab Grader
% result = createMosaic(target, 60, tilesAverage, TILE_HEIGHT, TILE_WIDTH);
% imwrite(result, './out/portrait.jpg');
result = imread('https://raw.githubusercontent.com/guisaez/comp_572_mosaics/master/out/portrait.jpg');
figure; montage({target, result});
figure; imshow(result);

%% Target 5
disp('Image 5: 85 Tiles Per Row')
target = imread('https://raw.githubusercontent.com/guisaez/comp_572_mosaics/master/in/lionel-messi.jpg');
% Commented for Matlab Grader
% result = createMosaic(target, 85, tilesAverage, TILE_HEIGHT, TILE_WIDTH);
% imwrite(result, './out/lionel-messi.jpg');
result = imread('https://raw.githubusercontent.com/guisaez/comp_572_mosaics/master/out/lionel-messi.jpg');
figure; montage({target, result});
figure; imshow(result);

%% Target 5.1 Modifying TILE_HEIGHT, TILEWIDTH
TILE_HEIGHT = 20;
TILE_WIDTH = 150;
disp('Image 5: 90 Tiles Per Row, TILE_HEIGHT = 20, TILE_WIDTH = 150 ("vertical shrink")')
% Commented for Matlab Grader
% result = createMosaic(target, 90, tilesAverage, TILE_HEIGHT, TILE_WIDTH);
% imwrite(result, './out/lionel-messi2.jpg');
result = imread('https://raw.githubusercontent.com/guisaez/comp_572_mosaics/master/out/lionel-messi2.jpg');
figure; montage({target, result});


function mosaic = createMosaic(img, tilesPerRow, tilesAverage, TILE_HEIGHT, TILE_WIDTH)

    img = im2double(img); % Ensure img is in double format.
    
    %% Get target image dimensions.
    [img_h, img_w, ~] = size(img);

    %% Determine Mosaic Dimensions and Grid Separation
    cellWidth = floor(img_w / tilesPerRow);
    cellHeight = round(cellWidth * TILE_HEIGHT / TILE_WIDTH);
    tilesPerColumn = floor(img_h / cellHeight);

    %% Initialize grid.
    grid = cell(tilesPerColumn, tilesPerRow);
    cellAverages = cell(tilesPerColumn, tilesPerRow, 3);

    disp('Subplotting Original Image ...')
    %% Subplot Image Portion into Corresponding Tile and Find Its Average

   
    for row = 1:tilesPerColumn
        for column = 1:tilesPerRow
            grid{row, column} = getImagePortion(img, 1 + (row - 1) * cellHeight:(row*cellHeight),...
                1 + (column - 1) * cellWidth:(column*cellWidth));
            
            % Get Average of Image Portion
            [cellAverages{row, column, 1}, cellAverages{row, column, 2}, cellAverages{row, column, 3}] = ...
                getAverageRGB(grid{row, column});
        end
    end

    disp('Obtaining Best Cadidate for Each Sub-Tile ...')
    candidateIndexTable = getBestTile(cellAverages, tilesAverage);

    [rows, cols] = size(candidateIndexTable);

    for i = 1:rows
        for j = 1:cols
            or = grid{i, j};
            tile = getTileFromDataSet(candidateIndexTable{i,j}, TILE_HEIGHT, TILE_WIDTH);

            tileAvg = tilesAverage(candidateIndexTable{i,j}, :);

            %% Adjust Tile
            tile = adjustTile(or, tile, tileAvg);

            grid{i, j} = tile;
        end
    end
    
    mosaic = cell2mat(grid);
end

function tile = adjustTile(or, tile, tileAvg)
    
    % Get Average for each color channel of original
    [red_avg, green_avg, blue_avg] = getAverageRGB(or);

    % Get Average for each color channel of tile
    red_avg_t = tileAvg(1);
    green_avg_t = tileAvg(2);
    blue_avg_t = tileAvg(3);

    % Determine Factor to Modofy Tile Average
    red_factor = red_avg / red_avg_t;
    green_factor = green_avg / green_avg_t;
    blue_factor = blue_avg / blue_avg_t;

    % Modify Tile Average
    red_tile = tile(:,:,1) * red_factor;
    green_tile = tile(:,:,2) * green_factor;
    blue_tile = tile(:,:,3) * blue_factor;

    % Return modified tile
    tile = cat(3, red_tile, green_tile, blue_tile);
end

function indexTable = getBestTile(cellAverages, tilesAverage)
    [rows, cols, ~] = size(cellAverages);
    [totalTiles, ~] = size(tilesAverage);

    indexTable = cell(rows, cols);

    K = 40;

    for i = 1:rows
        for j = 1:cols

            red = cellAverages{i,j,1};
            green = cellAverages{i,j,2};
            blue = cellAverages{i,j,3};
            
            temp = zeros(1, totalTiles);
            for k=1:totalTiles
                temp(k) = abs(tilesAverage(k, 1) - red) + abs(tilesAverage(k, 2) - green) + ...
                    abs(tilesAverage(k, 3) - blue);
            end

            %% Find Best K Matches
            
            best_k = mink(temp, K);
            
            randomPosition = randi(K);
            best = best_k(randomPosition);

            index = find(temp == best, 1);
          
            indexTable{i, j} = index;

        end
    end
end

function subImage = getImagePortion(img, rowrange, colrange)
    subImage = img(rowrange, colrange, :);
end

function tileAverages = getTilesAndTilesAverages(tile_height, tile_width)
    
    disp('Reading Tiles and Obtaining Averages ...')
    %% Get all Image Files From Directory
    images = dir('./images/*.jpg');

    %% Get total number of tiles read
    N = size(images, 1);

    %% Initialize Tile Average Matrix n x 3.
    tileAverages = zeros(N , 3);
    
    %% Iterate throught all files and for each tile, find its average.
    for i = 1:N

        %% Get current Tile
        tile = getTileFromDataSet(i, tile_height, tile_width);

        %% Get Average RGB for tile and Store it in TileAverages.
        [tileAverages(i,1), tileAverages(i,2), tileAverages(i,3)] = getAverageRGB(tile);

    end
    
end

function [red_avg, green_avg, blue_avg] = getAverageRGB(img)
    
    %% Get Average RGB of Image.
    red_avg = mean(img(:,:,1), 'all');  % Get average of red channel.
    green_avg = mean(img(:,:,2), 'all'); % Get average of green channel.
    blue_avg = mean(img(:,:,3), 'all');  % Get average of blue channel.

end

function tile = getTileFromDataSet(index, tile_height, tile_width)

    %% Read Tile and Resize
    tile = im2double(imread(['./images/' int2str(index) '.jpg']));
    tile = imresize(tile, [tile_height tile_width]);
end
