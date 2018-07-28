#' remotePush
#' @description copy files to a remote host
#' @param files character vector of file or directory paths to copy.
#' @param user user name to use for ssh connection
#' @param host host name to use for ssh connection
#' @param hostPath directory path to copy the files to on the host
#' @importFrom ssh scp_upload
#' @export

remotePush <- function(files,user,host,hostPath = '.'){
    session <- str_c(user,'@',host) %>%
        ssh_connect()
    scp_upload(session,files,to = hostPath)
}