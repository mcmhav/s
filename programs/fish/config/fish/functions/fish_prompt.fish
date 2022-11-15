function fish_prompt
	set -l __last_command_exit_status $status

    if not set -q -g __fish_cake_functions_defined
        set -g __fish_cake_functions_defined

        function _is_git_dirty
            echo (git status -s --ignore-submodules=dirty 2>/dev/null)
        end

        function _is_git_repo
            type -q git
            or return 1
            git rev-parse --git-dir >/dev/null 2>&1
        end

        function _hg_branch_name
            echo (hg branch 2>/dev/null)
        end

        function _is_hg_dirty
            echo (hg status -mard 2>/dev/null)
        end

        function _is_hg_repo
            fish_print_hg_root >/dev/null
        end


        function _is_repo_dirty
            _is_$argv[1]_dirty
        end

        function _repo_type
            if _is_hg_repo
                echo 'hg'
                return 0
            else if _is_git_repo
                echo 'git'
                return 0
            end
            return 1
        end

        function _is_ssh
          if test -n "$SSH_CLIENT"; or test -n "$SSH_TTY"
            return 0
          end
          return 1
        end
    end

    set -l cyan (set_color -o cyan)
    set -l yellow (set_color -o yellow)
    set -l red (set_color -o red)
    set -l green (set_color -o green)
    set -l blue (set_color -o blue)
    set -l normal (set_color normal)

    set -l prev_command_usage "$blue$CMD_DURATION_STR "

    set -l arrow "▲ "
    if test "$USER" = 'root'
        set arrow "# "
    end

    if _is_ssh
      set arrow "$blue$arrow"
    else
      set arrow "$green$arrow"
    end
    if test $__last_command_exit_status != 0
        set arrow "$red▼ "
        # giphy explosion
    end

    set -l cwd (basename (prompt_pwd))
    if _is_ssh
      set cwd "$red$cwd"
    else
      set cwd "$cyan$cwd"
    end

    if set -l repo_type (_repo_type)
        # set repo_info "$blue ⭔"
        # set repo_info "$blue ⚇"
        set repo_info "$blue ❱"

        if [ (_is_repo_dirty $repo_type) ]
            # set repo_info "$yellow ⭓ "
            # set repo_info "$yellow ⚉"
            set repo_info "$yellow ❱"
        end
    end

    echo -n -s $prev_command_usage $arrow $cwd $repo_info $normal ' '
    # echo -n -s ⭓
end
