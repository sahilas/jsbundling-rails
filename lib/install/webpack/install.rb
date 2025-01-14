say "Install Webpack with config"
copy_file "#{__dir__}/webpack.config.js", "webpack.config.js"
run "pnpm add webpack webpack-cli"

say "Add build script"
build_script = "webpack --config webpack.config.js"

case `npx -v`.to_f
when 7.1...8.0
  run %(npm set-script build "#{build_script}")
  run %(pnpm build)
when (8.0..)
  run %(npm pkg set scripts.build="#{build_script}")
  run %(pnpm build)
else
  say %(Add "scripts": { "build": "#{build_script}" } to your package.json), :green
end
