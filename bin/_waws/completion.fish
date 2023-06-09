set -l commands decode-message select-profile sso-profiles eks ec2 whoami

complete -c waws -f

complete -c waws -n "not __fish_seen_subcommand_from $commands" \
    -a "$commands"

