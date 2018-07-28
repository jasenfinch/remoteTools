#' remoteExec
#' @description execute an R expression on a remote host.
#' @importFrom stringr str_c
#' @importFrom magrittr %>%
#' @importFrom ssh ssh_connect ssh_exec_internal
#' @importFrom openssl base64_encode
#' @export

remoteExec <- function(user,host,expr){
    if (is.expression(expr)) {
        session <- str_c(user,'@',host) %>%
            ssh_connect()
        cmd <- expr %>% 
            as.character() %>%
            base64_encode()
        cmd <- str_c('Rscript -e \'eval(parse(text = rawToChar(openssl::base64_decode(\"',cmd,'\"))))\' &> .tmp.txt; cat .tmp.txt; rm .tmp.txt')
        out <- ssh_exec_internal(session,cmd,error = F) 
        
        out %>%
            .$stdout %>%
            rawToChar()
    } else {
        stop('expr is not an expression')
    }
    
}