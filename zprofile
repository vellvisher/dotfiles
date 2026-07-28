if [[ "$(uname -m)" == "arm64" ]]; then
  # Apple Silicon (M1/M2/M3)
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ "$(uname -m)" == "x86_64" ]]; then
  # Intel
  eval "$(/usr/local/bin/brew shellenv)"
fi
