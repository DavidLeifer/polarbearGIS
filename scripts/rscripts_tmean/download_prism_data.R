library(prism)

cwd <- getwd()
end_string <- '/data/tmean/'
path_concat <- paste(cwd, end_string)

prism_set_dl_dir(cwd)
get_prism_monthlys(type = "tmean", year = 1981:2014, mon = 1, keepZip = FALSE)
