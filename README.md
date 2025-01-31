# Fractal Dimension Estimation using Box Counting Method

This repository contains MATLAB functions to estimate the fractal dimension, also known as *box counting dimension* or [*Minkowski dimension*](https://assets.cambridge.org/97811071/34119/excerpt/9781107134119_excerpt.pdf), od 2D dimensional images, using the box counting algorithm. The implementation allows visualization of the process and provides options to generate plots and GIFs.

## Features

- Computes the **Minkowski (fractal) dimension of a 2D images** of a 2D image.
- Allows visualization of the box counting process
- Support optional parameters for **plotting, saving results** and **Gif generation**

## Installation

Clone this repository using 

```bash
git clone https://github.com/RicardxJMG/box-counting-fractal-dimension
```

## Usage

Load the functions in MATLAB and call `minkowski_dimension` with an image input.

```matlab
image = imread('your_image.jpg')
divider_factor = 2;

% For estimate the fractal dimension
fd_estimation = minkowski_dimension(image, divider_factor)

% Estimate the fractal dimension and generates the log-log fit plot and save it with specific name 

fd_estimation = minkowski_dimension(image, divider_factor, 'plot_fit', 'save_plot', 'name_figure', 'your_figure_name')

% Create the box counting process in a GIF
minkowski_dimension(image, 'create_gif', 'gif_name', 'your_gif_name')
```

## Function

### 1. `minkowski_dimension`

**Inputs**

- `image_input` (3D matrix): RGB Image.
- `divider_factor` reduction factor for box size.
- **Optional Parameters:**
  - `'plot_fit'`: Generates log-log fit plot.
  - `'save_plot'`: Saves log-log plot in PNG and PDF.
  - `'name_figure'`: Custom name for saved plots.
  - `'create_gif'`: Generates a GIF of the box-counting process.
  - `'gif_name'`: Custom name for the GIF file.

**Outputs:**

- `fd`: Estimated fractal dimension.
- `box_data`: Iteration details (box count, sizes, images).

---

### `box_counting`

**Description** Counts the number of boxes intersecting a non-white pixels in an image.
**Inputs:**

- `image` (3D matrix): RGB image.
- `box_length` (int): Box size.
- `previous_count` (binary matrix, optional): Prior count for optimization.

**Outputs:**

- `matrix_count`: Binary matrix indicating intersecting boxes.
- `total_boxes`: Total number of counted boxes.

---

### `draw_boxes`

**Description:**
Overlays a grid on an image, drawing only the boxes that intersect non-white pixels.

**Inputs:**

- `image` (3D matrix): RGB image.
- `box_length` (int): Box size.

**Output:**

- `mesh`: Image with overlaid boxes.

## License

This project is licensed under the MIT License.

## Author

- [Ricardo Mtz](https://github.com/RicardxJMG)
