declare-option -docstring "Shell command run to get logs from an iOS device" \
    str iossyslogcmd 'idevicesyslog -d'
declare-option -docstring "Grep command with line buffering instead of block" \
    str grepcmd 'grep --line-buffered'
declare-option -docstring "name of the client in which the logs are displayed" \
    str toolsclient

define-command -params .. \
    -docstring %{idevicesyslog [<arguments>]: open a fifo
iOS syslog buffer with optional grep patterns} \
    idevicesyslog %{
        evaluate-commands %sh{
            if [ $# -eq 0 ]; then
                set -- "."
            fi

            output=$(mktemp -d "${TMPDIR:-/tmp}"/kak-idevicesyslog.XXXXXXXX)/fifo
            mkfifo ${output}
            ( ${kak_opt_iossyslogcmd} | ${kak_opt_grepcmd} $@ > ${output} 2>&1 & ) > /dev/null 2>&1 < /dev/null

            printf %s\\n "evaluate-commands -try-client '$kak_opt_toolsclient' %{
                edit! -fifo ${output} *iossyslog*
                hook -always -once buffer BufCloseFifo .* %{ nop %sh{ rm -r $(dirname ${output}) } }
            }"
    }
}
