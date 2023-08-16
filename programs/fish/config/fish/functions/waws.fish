function waws
  switch $argv
    case 'select-profile'
      $CSYS_BIN/waws $argv --no-fzf | ij
    case '*'
      $CSYS_BIN/waws $argv
  end

  function ij
    # TODO: make generic
    # Add option to pass output formatter
    # maybe as an env var
    begin
      set -l fzf_input
      if isatty stdin
        # we have no pipe
        set fzf_input $argv
      else
        # we have pipe
        read -l -z pipe_input
        set fzf_input echo $pipe_input
      end

      if set -q fzf_input[1]
        $fzf_input | fzf | read -l result
        and commandline -- "export AWS_PROFILE=$result"
      end
    end
    commandline -f repaint
  end
end
