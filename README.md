# Carousel Renderer

![Freelancer](doc/preview.gif
)

## Usage

This module provides a carousel view in the Product List Renderer.       

## Requirements

- Liferay Commerce 2.1.2

## Installation

- Download the `.jar` file in [releases](https://github.com/jhanda/CarouselRenderer/releases/tag/1.0.0) and deploy it 
into Liferay.

or

- Clone this repository, add it to a Liferay workspace and deploy it into Liferay.

## Known Issues
Currently the CSS in [main.scss](src/main/resources/META-INF/resources/css/main.scss) is not being correctly applied so 
product images are stacked vertically instead of horizontally.  As a workaround, copy the contents of 
[main.scss](src/main/resources/META-INF/resources/css/main.scss) and 
[apply at the portlet](https://help.liferay.com/hc/en-us/articles/360029132791-Look-and-Feel-Configuration) or 
[page set level](https://help.liferay.com/hc/en-us/articles/360029132671-Configuring-Page-Sets).     

## License

[MIT](LICENSE)