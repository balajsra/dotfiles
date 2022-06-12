# This function allows you to switch to a different task
# when an interactive command takes too long
# by notifying you when it is finished.
#
# It is invoked by the fish shell automatically using its event system.
function __postexec_notify_on_long_running_commands --on-event fish_postexec
    set --function interactive_commands 'vim' 'vlc' 'zathura' 'gitk' 'man' 'less'
    set --function command (string split ' ' $argv[1])
    if contains $command $interactive_commands
        # We quit interactive commands manually,
        # no need for a notification.
        return
    end

    if test $CMD_DURATION -gt 5000
        notify-send 'command finished' "$argv"
    end
end
