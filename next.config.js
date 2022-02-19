const path = require("path");
const smartyPants = require("@silvenon/remark-smartypants");

const withMDX = require("@next/mdx")({
  extension: /\.mdx?$/,
  options: {
    remarkPlugins: [smartyPants],
  },
});

module.exports = withMDX({
  webpack(config, _options) {
    // config.node = { fs: "empty", child_process: "empty" };
    config.node = {};
    config.resolve.alias["@purescript"] = path.join(__dirname, "output");
    return config;
  },
  env: {},
  publicRuntimeConfig: {},
  pageExtensions: ["js", "jsx", "mdx"],
});
