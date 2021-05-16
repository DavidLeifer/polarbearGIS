library(prism)

cwd <- getwd()
end_string <- '/data/ppt'
path_concat <- paste(cwd, end_string, sep='')
prism_set_dl_dir(path_concat)

get_prism_monthlys(type = "ppt", year = 1981:2014, mon = 1, keepZip = FALSE)
