function ij
  # template with awk string
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
      set ij_output ($fzf_input | fzf | awk "$IJ_TEMPLATE")
      and commandline -- "$ij_output"
    end
  end
  # commandline -f repaint # NOTE: does not seem to be necessary
end
