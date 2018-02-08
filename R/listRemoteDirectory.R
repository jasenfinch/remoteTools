#' listRemoteDirectory
#' @description list the contents of a remote directory
#' @export

listRemoteDirectory <- function(user,host,directory = '.'){
    session <- str_c(user,'@',host) %>%
        ssh_connect()
    ssh_exec_internal(session,str_c('ls ',directory)) %>%
        .$stdout %>%
        rawToChar() %>%
        str_split(.,coll('\n')) %>%
        .[[1]] %>%
        .[!(. == '')]
}