// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.

module.exports = {
  config: {
    // `'stable'`, `'canary'`
    updateChannel: 'stable',

    fontSize: 11,

    fontFamily: 'Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',

    fontWeight: 'normal',

    fontWeightBold: 'bold',

    cursorColor: 'rgba(248,28,229,0.8)',

    cursorAccentColor: '#000',

    // `'BEAM'` for |, `'UNDERLINE'` for _, `'BLOCK'` for █
    cursorShape: 'BLOCK',

    cursorBlink: true,

    foregroundColor: '#5ee39b',

    backgroundColor: '#101010DD',

    selectionColor: 'rgb(167, 26, 154, 0.5)',

    borderColor: '#333',

    css: '',

    termCSS: '',

    showHamburgerMenu: false,

    // `false`, `'left'`, `true`, ignored on macOS
    showWindowControls: '',

    padding: '0px 2px',

    // the full list. if you're going to provide the full color palette,
    // including the 6 x 6 color cubes and the grayscale map, just provide
    // an array here instead of a color map object
    colors: {
      black: '#313131',
      red: '#ff6262',
      green: '#1DC121',
      yellow: '#C7C329',
      blue: '#3eb5ff',
      magenta: '#C839C5',
      cyan: '#20C5C6',
      white: '#C7C7C7',

      lightBlack: '#686868',
      lightRed: '#FD6F6B',
      lightGreen: '#67F86F',
      lightYellow: '#FFFA72',
      lightBlue: '#7accff',
      lightMagenta: '#FD7CFC',
      lightCyan: '#68FDFE',
      lightWhite: '#FFFFFF',
    },

    opacity: 0.9,

    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    //
    // Windows
    // - Make sure to use a full path if the binary name doesn't work
    // - Remove `--login` in shellArgs
    //
    // Bash on Windows
    // - Example: `C:\\Windows\\System32\\bash.exe`
    //
    // PowerShell on Windows
    // - Example: `C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe`
    shell: '',

    shellArgs: ['--login'],

    scrollback: 20000,

    env: {},

    // set to `false` for no bell
    bell: 'SOUND',

    copyOnSelect: false,

    defaultSSHApp: true,

    // if `true` (without backticks and without quotes), on right click selected text will be copied or pasted if no
    // selection is present (`true` by default on Windows and disables the context menu feature)
    // quickEdit: true,

    // URL to custom bell
    // bellSoundURL: 'http://example.com/bell.mp3',

    // for advanced config flags please refer to https://hyper.is/#cfg
  },

  plugins: ['hyper-search', 'hyper-pane'],
  localPlugins: [],

  keymaps: {
    // Example
    // 'window:devtools': 'cmd+alt+o',
  },
};
