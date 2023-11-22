# Server Info
HOSTNAME='Example Name' # Server Name just for tips
USERNAME='root' # Login Username
HOST='127.0.0.1' # Server IP
PORT='22' # SSH Port

# If you want use connect by Proxy you need have "nc" or "ncat", you can find ncat in https://nmap.org/ncat/
USEPROXY='false' # Enable proxy, enable with 'true'
PROXYHOST='172.25.0.1' # Proxy IP
PROXYPORT='7890' # Proxy Port
PROXYAUTH='false' # Proxy auth, enable with 'true'
PROXYUSER='' # Proxy Username
PROXYPASS='' # Proxy Password

# color setting

RED='\033[0;31m'
WARNING='\033[1;33m'
KEYV='\033[0;34m'
TIPS='\033[0;36m'
NC='\033[0m'

# System info
# OS='UNKNOWN'
# if test "$(uname)" = "Darwin" 
# then
#     OS='MAC'
# elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
# then   
#     OS='LINUX'
# elif test "$(expr substr $(uname -s) 1 10)" = "MINGW32_NT"
# then    
#     OS='WIN'
# elif test "$(expr substr $(uname -s) 1 10)" = "MINGW64_NT"
# then
#     OS='WIN'
# else
#     echo "$(expr substr $(uname -s) 1 10)"
#     echo "Your system can't set proxy automatically, please set it manually."
# fi

# check NC or NCAT command
INSTALLED_NC=$(command -v nc)
INSTALLED_NCAT=$(command -v ncat)

# args
SSHARG=""
PROXYARG=""

# check proxy config
if test "${USEPROXY}" = 'true'
then
    # use nc
    if [ -n "${INSTALLED_NC}" ]
    then
        # ready add option and ProxyCommand
        SSHARG="-o"
        PROXYARG="ProxyCommand=nc -X connect -x ${PROXYHOST}:${PROXYPORT}"
        if test "${PROXYAUTH}" = 'true' # check proxy auth
        then
            # add proxy auth args
            PROXYARG="${PROXYARG} -P ${PROXYUSER}@${PROXYPASS}"
            # tips
            echo -e "${WARNING}Your are using proxy with auth by ${KEYV}${PROXYHOST}:${PROXYPORT}${WARNING}, the proxy loggin by ${PROXYUSER}${NC}"
        else
            echo -e "${WARNING}Your are using proxy with auth by ${KEYV}${PROXYHOST}:${PROXYPORT}${WARNING}${NC} "
        fi
        # end of ProxyCommand
        PROXYARG="${PROXYARG} %h %p"

    # use ncat
    elif [ -n "${INSTALLED_NCAT}" ]
    then
        # ready add option and ProxyCommand
        SSHARG="-o"
        PROXYARG="ProxyCommand=ncat --proxy ${PROXYHOST}:${PROXYPORT}"
        if test "${PROXYAUTH}" = 'true' # check proxy auth
        then
            # add proxy auth args
            PROXYARG="${PROXYARG} --proxy-auth ${PROXYUSER}:${PROXYPASS}"
            # tips
            echo -e "${WARNING}Your are using proxy with auth by ${KEYV}${PROXYHOST}:${PROXYPORT}${WARNING}, the proxy loggin by ${PROXYUSER}${NC}"
        else
            echo -e "${WARNING}Your are using proxy with auth by ${KEYV}${PROXYHOST}:${PROXYPORT}${WARNING}${NC} "
        fi
        # end of ProxyCommand
        PROXYARG="${PROXYARG} %h %p"
    else
        # no nc or ncat tips
        echo -e "${RED}You don't have nc or ncat, please install them. now we didn't use proxy connect to server.${NC}"
    fi
fi

echo -e "${WARNING}Your are connecting to ${KEYV}${HOSTNAME}${WARNING}... HOST:${KEYV}${HOST}${WARNING} (port ${KEYV}${PORT}${WARNING}) by user:${TIPS}${USERNAME}${WARNING} using SSH Key!${NC}"
#echo  "${PROXYARG}" # debug
ssh -p ${PORT} ${USERNAME}@${HOST} ${SSHARG} "${PROXYARG}"
pasue