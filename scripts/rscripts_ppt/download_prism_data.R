library(prism)

cwd <- getwd()
end_string <- '/data/ppt/'
path_concat <- paste(cwd, end_string)

get_prism_monthlys(type = "ppt", year = 1981:2014, mon = 1, keepZip = FALSE)
