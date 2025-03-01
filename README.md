Simple OpenGL Image Library (SOIL)
==================================

## Introduction

SOIL is a tiny C library used primarily for uploading textures into OpenGL.
It is based on `stb_image` version 1.16, the public domain code from Sean
Barrett (found here). It has been extended to load TGA and DDS files, and
to perform common functions needed in loading OpenGL textures. SOIL can
also be used to save and load images in a variety of formats.


## Installation

#### From source:

```sh
$ make
$ make install
```

#### Using KISS package manager:

Install and configure KISS to support `ol-packages` repository as [described here](https://github.com/yuriy-chumak/ol-packages).

Then just
```
$ kiss bi libol-soil
```

## Usage

SOIL is meant to be used as a static or shared library (as it's tiny and in the public domain).

Simply `#include <SOIL/SOIL.h>` in your C or C++ file, link in the static or shared library, and then use any of SOIL's functions.
The file `<SOIL/SOIL.h>` contains simple doxygen style documentation.

No other header files are needed besides `SOIL.h`.


## Features

* No external dependencies
* Tiny
* Cross platform (Windows, \*nix, Mac OS X)
* Public Domain
* Can load an image file directly into a 2D OpenGL texture
* Can generate a new texture handle, or reuse one specified
* Can automatically rescale the image to the next largest power-of-two size
* Can automatically create MIPmaps
* Can scale (not simply clamp) the RGB values into the "safe range" for NTSC displays (16 to 235, as recommended [here][1])
* Can multiply alpha on load (for more correct blending / compositing)
* Can flip the image vertically
* Can compress and upload any image as DXT1 or DXT5 (if `EXT_texture_compression_s3tc` is available), using an internal (very fast!) compressor
* Can convert the RGB to YCoCg color space (useful with DXT5 compression: see [this link][2] from NVIDIA)
* Will automatically downsize a texture if it is larger than `GL_MAX_TEXTURE_SIZE`
* Can directly upload DDS files (DXT1/3/5/uncompressed/cubemap, with or without MIPmaps). Note: directly uploading the compressed DDS image will disable the other options (no flipping, no pre-multiplying alpha, no rescaling, no creation of MIPmaps, no auto-downsizing)
* Can load rectangluar textures for GUI elements or splash screens (requires `GL_ARB/EXT/NV_texture_rectangle`)
* Can decompress images from RAM (e.g. via [PhysicsFS][3] or similar) into an OpenGL texture (same features as regular 2D textures, above)
* Can load cube maps directly into an OpenGL texture (same features as regular 2D textures, above)
* Can take six image files directly into an OpenGL cube map texture
* Can take a single image file where `width = 6 * height` (or vice versa), split it into an OpenGL cube map texture

### Readable Image Formats

* BMP - non-1bpp, non-RLE (from `stb_image` documentation)
* PNG - non-interlaced (from `stb_image` documentation)
* JPG - JPEG baseline (from `stb_image` documentation)
* TGA - greyscale or RGB or RGBA or indexed, uncompressed or RLE
* DDS - DXT1/2/3/4/5, uncompressed, cubemaps (can't read 3D DDS files yet)
* PSD - (from `stb_image` documentation)
* HDR - converted to LDR, unless loaded with *HDR* functions (RGBE or RGBdivA or RGBdivA2)

### Writeable Image Formats
* TGA - Greyscale or RGB or RGBA, uncompressed
* BMP - RGB, uncompressed
* DDS - RGB as DXT1, or RGBA as DXT5

## License

Public Domain

Originally sourced from https://github.com/paralin/soil

[1]: http://msdn2.microsoft.com/en-us/library/bb174608.aspx#NTSC_Suggestions
[2]: http://developer.nvidia.com/object/real-time-ycocg-dxt-compression.html
[3]: http://icculus.org/physfs/

### Simple OpenGL Image Library *Ext*#
[The original SOIL from July 7, 2008](http://www.lonesock.net/soil.html) is released with **Public Domain Licence**.

The **Ext** version contains the following changes:

* **[in progress]** Added option to use immutable texture storage
 * When possible (when extension is supported) library can create texture using glTextureStorage and then call glTexSubImage.
 * See more here [OpenGL wiki](http://www.opengl.org/wiki/Texture_Storage)
* **[done]** Mipmap generation using glGenerateMipmap
 * Original library scaled image to be POT and then used custom procedure to generate mipmaps. This can take some time.
 * This change uses glGenerateMipmapEXT (if GL\_EXT\_framebuffer\_object extension is available). This way Soil can create mipmaps for NPOT textures and use hardware support.
 * New flag is added: **SOIL\_FLAG\_GL\_MIPMAPS**. It can be passed to the SOIL\_load_OGL\_texture\* procedures. If the extension (GL\_EXT\_framebuffer\_object) is not supported then function uses the same process as when passing **SOIL\_FLAG\_MIPMAPS**.
* **[done]** upgraded to the version **1.33** of [stb_image](http://www.nothings.org/stb_image.c)
 * stb_image_write.c/.h were created. Those files contain missing functionality that was cut from the newer version of stbi (cut in 1.22)  
* **[done]** Using only Modern OpenGL functionalities (when possible)
 * *CLAMP\_TO\_EDGE* instead of *GL\_CLAMP*
 *  *glGetStringi* instead of *glGetString(GL\_EXTENSIONS)* 

## Notes
* Original functionality is preserved and should work as expected.
* Doc comments were updated to describe changes
* Needs more testing :)
