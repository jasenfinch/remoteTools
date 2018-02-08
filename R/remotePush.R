#' remotePush
#' @description copy files to a remote host
#' @importFrom ssh scp_upload
#' @export

remotePush <- function(files,user,host,hostPath = '.'){
    session <- str_c(user,'@',host) %>%
        ssh_connect()
    scp_upload(session,files,to = hostPath)
}