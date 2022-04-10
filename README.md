# video-dl.r
Download videos contained in a HTML website.

`video-dl.r` will try to find a links to videos (`.mp4` by default) in the passed HTML and download them.

This is a simple script and is nowhere close to the `youtube-dl`, it does not
try to de-encode the URL or any of the other smart things.

## Installation
No installation required, simply copy the script and `source` it or run it with `Rscript`.

Following dependencies are required: `curl`, `stringr` and `magrittr`.

## How to run

In a command line, write:
```
Rscript video-dl.r [url]
```

or run alternatively, run `R` and then type:

```
source("video-dl.r")
video_dl(url)
```

Addition arguments are:
* **outdir** an output directory (default: `videos`)
* **ext** an extension (file type) of videos (default: `mp4`)
* **prefix** each video url starts with prefix (default: `https://`)
* **url** whether the first input is an url link or html file (default: `TRUE`)
