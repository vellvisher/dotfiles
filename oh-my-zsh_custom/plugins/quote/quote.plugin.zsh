# Quote file
WHO_COLOR="\e[0;33m"
TEXT_COLOR="\e[0;97m"
COLON_COLOR="\e[0;35m"
END_COLOR="\e[m"

if [[ -a $QUOTE_FILE ]]; then
    function quote()
    {
        Q=$(gsort -R $QUOTE_FILE | head -1)
        W=$(echo "$Q" | sed -e 's/\(.*\):\(.*\)/\1/')
        TXT=$(echo "$Q" | sed -e 's/\(.*\):\(.*\)/\2/')
        if [ "$W" -a "$TXT" ]; then
          echo "${WHO_COLOR}${W}${COLON_COLOR}: ${TEXT_COLOR}“${TXT}”${END_COLOR}\n"
        else
          quote
        fi
    }
    #quote
else
    echo "quote file does not exist" >&2
fi
