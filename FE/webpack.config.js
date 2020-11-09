const HtmlWebpackPlugin = require("html-webpack-plugin");
const path = require("path");

module.exports = {
  mode: "development",
  entry: {
    main: ["babel-polyfill", "./src/index.js"],
  },
  output: {
    filename: "bundle.[name].js",
  },
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader",
        },
      },
      {
        test: /\.html$/,
        use: [
          {
            loader: "html-loader",
            options: {
              minimize: true,
            },
          },
        ],
      },
    ],
  },
  resolve: {
    extensions: [".js", ".jsx"],
    alias: {
      "@": path.resolve(__dirname, "src/"),
      "@component": path.resolve(__dirname, "src/component"),
      "@pages": path.resolve(__dirname, "src/pages"),
      "@util": path.resolve(__dirname, "src/util"),
    },
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: "./public/index.html",
    }),
  ],
  devServer: {
    contentBase: path.join(__dirname, "dist"),
    compress: true,
    host: "localhost",
    port: 5000,
    open: true,
    historyApiFallback: true,
  },
};
