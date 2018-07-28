#' listRemoteDirectory
#' @description list the contents of a remote directory
#' @param user user name to use for ssh connection
#' @param host host name to use for ssh connection
#' @param directory directory path to list
#' @importFrom stringr coll str_split
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