#' node013Exec
#' @description excute R commands on node013
#' @importFrom ssh ssh_connect ssh_exec_internal ssh_exec_wait
#' @importFrom openssl base64_encode
#' @export

node013Exec <- function(user,expr,h_vmem=2){
    if (is.expression(expr)) {
        
        cmd <- expr %>% 
            as.character() %>%
            base64_encode() %>%
            str_c('qrsh -l h=node013,h_vmem=',h_vmem,'G \"Rscript -e \\"eval(parse(text = rawToChar(openssl::base64_decode(\'',
                  .,'\'))))\\" &> ~/.tmp.txt; cat .tmp.txt; rm .tmp.txt\"')
        
        session <- str_c(user,'@bert.ibers.aber.ac.uk') %>%
            ssh_connect()
        ssh_exec_wait(session,'screen -X -S nan quit &> /dev/null')
        
        out <- ssh_exec_internal(session,cmd)
        
        out %>%
            .$stdout %>%
            rawToChar() %>%
            cat()
    } else {
        stop('expr is not an expression')
    }
}