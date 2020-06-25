var path = require("path");

module.exports = {
    context: __dirname,
    entry: "./frontend/entry.jsx",
    output: {
        filename: 'app/assets/javascripts/bundle.js',
    },
    plugins: plugins,
    module: {
        loaders: [
            {
                test: /\.jsx?$/,
                exclude: /node_modules/,
                loader: 'babel-loader',
                query: {
                    presets: ['react', 'env']
                }
            }
        ]
    },
    devtool: 'source-map',
    resolve: {
        extensions: [".js", ".jsx", "*"]
    }
};