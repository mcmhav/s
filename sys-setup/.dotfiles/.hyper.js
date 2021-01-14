// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.

const dynamicShells = {
  win32: [
    { shell: 'C:\\Program Files\\Git\\bin\\bash.exe' },
    { shell: 'C:\\cygwin64\\bin\\bash.exe' },
    { shell: 'C:\\msys64\\usr\\bin\\bash.exe' },
    { shell: 'C:\\msys64\\bin\\bash.exe' },
    { shell: 'C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe' },
    { shell: 'C:\\Windows\\System32\\bash.exe' },
  ],
  darwin: [
    { shell: '/usr/local/bin/fish' },
    { shell: '/usr/local/bin/bash' },
    { shell: '/bin/bash' },
  ],
  linux: [{ shell: '/bin/bash' }],
};

const customPlugins = {
  callback: ({ config, module }) => {
    // Select shell based on os and availability
    // If no found, let hyper find shell
    // TODO: move into separate plugin?
    const platform = module.require('os').platform();
    const fs = module.require('fs');

    if (config && config.dynamicShells && config.dynamicShells[platform]) {
      config.dynamicShells[platform].every(({ shell }) => {
        if (fs.existsSync(shell)) {
          config.shell = shell;
          return false;
        }
        return true;
      });
    }
  },
};

const hyperTabs = {
  // The height(unit px) of zone over tabs to drag the window
  navMoveable: 1,
  // The hotkeys of move tabs
  hotkeys: {
    moveLeft: 'ctrl+alt+left',
    moveRight: 'ctrl+alt+right',
  },
};

module.exports = {
  config: {
    // `'stable'`, `'canary'`
    updateChannel: 'stable',
    fontSize: 11,
    fontFamily:
      '"Meslo LG S for Powerline", Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace, powerline',
    // "Roboto Mono for Powerline"
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
    // Windows
    // - Make sure to use a full path if the binary name doesn't work
    // - Remove `--login` in shellArgs
    shell: '',
    shellArgs: ['--login'],
    scrollback: 10000,
    env: {},
    bell: false,
    copyOnSelect: false,
    defaultSSHApp: true,
    // Plugins-configs
    hyperTabs,
    dynamicShells,
    customPlugins,
  },
  plugins: [
    'hyper-custom-plugins',
    'hyper-search',
    'hyper-pane',
    'hyper-reorderable-tabs',
  ],
  // localPlugins: ['hyper-dynamic-shell-selector'],
  keymaps: {},
};
