# Export Isometric Tiles
A simple script for Aseprite that allows you to extract isometric tiles from a larger sprite sheet and save them into a new sprite, arranged in a row. 

From this:

![image](https://user-images.githubusercontent.com/49227260/231942237-3b569e29-ff36-48bd-b0bf-9fac95b6a45e.png)

To this!:

![image](https://user-images.githubusercontent.com/49227260/231942279-b7267a38-b560-4780-8c7a-9c3c1e7bdf24.png)

The output will be loaded in this order:

![image](https://user-images.githubusercontent.com/49227260/231942712-addc3bfa-8cfe-431c-b709-2a2c3b5f63b6.png)

## Usage

Set your canvas size to that of the tiles before running the script.

## Custimisation

You can modify some variables in the script to fit your specific use case:

srcTileWidth: The width of your source isometric tile.
srcTileHeight: The height of your source isometric tile.
gap: The number of pixels you want to have as a gap between the extracted tiles in the new sprite.

We are using 14 x 8 tiles. The shape of each tile is hard coded.
