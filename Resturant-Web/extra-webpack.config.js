const webpack = require('webpack');

module.exports = {
  resolve: {
    fallback: {
      "util": require.resolve("util/"),
      "crypto": require.resolve("crypto-browserify")
    }
  },
  plugins: [
    new webpack.ProvidePlugin({
      process: 'process/browser',
    }),
  ],
};
