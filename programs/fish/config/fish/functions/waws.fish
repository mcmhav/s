function waws
  switch $argv[1]
    case 'select-profile'
      set -g IJ_TEMPLATE '{print "export AWS_PROFILE="$0}'
      $CSYS_BIN/waws $argv --no-fzf | ij
    case '*'
      $CSYS_BIN/waws $argv
  end
end
