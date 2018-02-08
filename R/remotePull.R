#' remotePull
#' @description copy files to a remote host
#' @importFrom ssh scp_download
#' @export

remotePull <- function(files,user,host,to = '.'){
    session <- str_c(user,'@',host) %>%
        ssh_connect()
    scp_download(session,files,to = to)
}