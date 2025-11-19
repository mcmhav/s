function waws
  switch $argv[1]
    case 'select-profile'
      set -g IJ_TEMPLATE '{print "export AWS_PROFILE="$0}'
      set fz_output ($CSYS_BIN/waws $argv)
      commandline -- "$fz_output"
    case '*'
      $CSYS_BIN/waws $argv
  end
end
