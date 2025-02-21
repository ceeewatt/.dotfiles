###
#  Function: notify_print_status()
#  Usage: notify_print_status "<msg>"
#  Description: print out a formatted notification.
###
notify_print_status()
{
  printf "[${MGN}symp${DEF}] [${GRN}STATUS${DEF}] %s\n" "${1}"
}

###
#  Function: notify_print_error()
#  Usage: notify_print_error "<msg>"
#  Description: print out a formatted error message.
###
notify_print_error()
{
  printf "[${MGN}symp${DEF}] [${RED}FAILED${DEF}] %s\n" "${1}"
}
