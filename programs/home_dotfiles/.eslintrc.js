module.exports = {
  // extends: 'eslint:recommended',
  extends: ['plugin:prettier/recommended'],
  env: {
    node: true,
    es2017: true,
  },
  rules: {
    'comma-dangle': ['error', 'always-multiline'],
    'max-len': ['error', { code: 85 }],
    'prettier/prettier': 'error',
  },
  plugins: ['prettier'],
  parserOptions: {
    sourceType: 'module',
  },
};
