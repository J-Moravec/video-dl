library("curl")
library("stringr")
library("magrittr")


read_data = function(file){
    data = readLines(file, skipNul=TRUE, warn=FALSE)
    data
    }


parse_data = function(data, pattern="https://[^;]*\\.mp4"){
    match = str_extract_all(data, pattern) %>% unlist
    match
    }


get_file_name = function(url){
    name = strsplit(url, "/") %>% unlist %>% last
    name = gsub("%20", "_", name)
    name
    }


make_name = function(url, i){
    name = get_file_name(url)
    if(name == "file.mp4"){
        name = paste0(i, ".mp4")
        }
    name
    }


last = function(x){
    x[length(x)]
    }


mkdir = function(dir){
    if(!dir.exists(dir)){
        dir.create(dir, recursive=TRUE)
        }
    }


download_video = function(url, file){
    if(file.exists(file)){
        message(file, " already exists. Skipping!")
        } else {
        message("Processing: ", file)
        try_download_video(url, file)
        Sys.sleep(5)
        }
    }


try_download_video = function(url, file){
    tryCatch(
        curl_download(url, file),
        error = function(e){
            message("Error during downloading file:")
            message(e)
            message("\nCleaning incomplete file.")
            file.remove(file)
            stop()
            }
        )
    }


video_dl = function(x, outdir="videos", ext="mp4", prefix="https://", url=TRUE){

    if(url){
        file = tempfile()
        download.file(x, file)
        } else {
        file = x
        }

    pattern = paste0(prefix, "[^;]*\\.", ext)

    mkdir(outdir)
    data = read_data(file)
    matches = parse_data(data, pattern)

    # iterate over i so that we keep positional information as alternative name
    for(i in seq_along(matches) ){
        url = matches[i]
        file = make_name(url, i)
        filepath = file.path(outdir, file)
        download_video(url, filepath)
        }
    }


if(!interactive()){
    args = commandArgs(TRUE)
    video_dl(args[1])
    }
