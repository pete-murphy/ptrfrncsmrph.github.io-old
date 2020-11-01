const path = require("path")

const withMDX = require("@next/mdx")({
  extension: /\.mdx?$/,
})

module.exports = withMDX({
  webpack(config, _options) {
    config.node = { fs: "empty", child_process: "empty" }
    config.resolve.alias["@purescript"] = path.join(__dirname, "output")
    return config
  },
  env: {},
  publicRuntimeConfig: {},
  pageExtensions: ["js", "jsx", "mdx"],
})
