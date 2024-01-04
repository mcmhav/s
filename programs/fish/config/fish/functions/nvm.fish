# ref: https://github.com/nvm-sh/nvm?tab=readme-ov-file#fish

function nvm
  bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end

