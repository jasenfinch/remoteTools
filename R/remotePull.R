#' remotePull
#' @description copy files to a remote host
#' @param files character vector of file or directory paths to copy.
#' @param user user name to use for ssh connection
#' @param host host name to use for ssh connection
#' @param to directory path to copy the files to
#' @importFrom ssh scp_download
#' @export

remotePull <- function(files,user,host,to = '.'){
    session <- str_c(user,'@',host) %>%
        ssh_connect()
    scp_download(session,files,to = to)
}