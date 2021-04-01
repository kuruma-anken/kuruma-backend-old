const path = require("path");
const glob = require("glob");
const HardSourceWebpackPlugin = require("hard-source-webpack-plugin");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const TerserPlugin = require("terser-webpack-plugin");
const OptimizeCSSAssetsPlugin = require("optimize-css-assets-webpack-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");
const BundleAnalyzerPlugin = require("webpack-bundle-analyzer")
  .BundleAnalyzerPlugin;

module.exports = (env, options) => {
  const devMode = options.mode !== "production";
  const analyze = !!process.env.ANALYZE;

  return {
    resolve: {
      extensions: [".mjs", ".js", ".ts", ".tsx"],
      mainFields: ["svelte", "browser", "module", "main"],
      alias: {
        svelte: path.dirname(require.resolve("svelte/package.json"))
      }
    },
    optimization: {
      minimize: true,
      minimizer: [
        new TerserPlugin({
          cache: true,
          parallel: true,
          sourceMap: devMode,
          terserOptions: {
            module: true,
            mangle: {
              toplevel: true
            },
            compress: {
              toplevel: true
            }
          }
        }),
        new OptimizeCSSAssetsPlugin({})
      ]
    },
    entry: {
      app: glob.sync("./vendor/**/*.js").concat(["./js/app.js"])
    },
    output: {
      filename: "[name].js",
      path: path.resolve(__dirname, "../priv/static/js"),
      publicPath: "/js/"
    },
    devtool: devMode ? "eval-cheap-module-source-map" : undefined,
    module: {
      rules: [
        {
          test: /\.(j|t)s$/,
          exclude: /node_modules/,
          use: {
            loader: "babel-loader"
          }
        },
        {
          test: /\.svelte$/,
          use: {
            loader: "svelte-loader",
            options: {
              compilerOptions: {
                dev: devMode
              },
              emitCss: !devMode,
              preprocess: require("svelte-preprocess")({})
            }
          }
        },
        {
          test: /\.[s]?(a|c)ss$/,
          use: [MiniCssExtractPlugin.loader, "css-loader", "sass-loader"]
        }
      ]
    },
    plugins: [
      new MiniCssExtractPlugin({ filename: "../css/app.css" }),
      new CopyWebpackPlugin([{ from: "static/", to: "../" }])
    ]
      .concat(devMode ? [new HardSourceWebpackPlugin()] : [])
      .concat(analyze ? [new BundleAnalyzerPlugin()] : [])
  };
};
