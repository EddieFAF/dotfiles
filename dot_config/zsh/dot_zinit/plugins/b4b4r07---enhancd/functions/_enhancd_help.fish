function _enhancd_help
    _enhancd_ltsv_open \
        | _enhancd_command_awk -f "$ENHANCD_ROOT/lib/help.awk"
    return $status
end
