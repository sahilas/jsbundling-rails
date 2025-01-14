say "Install rollup with config"
copy_file "#{__dir__}/rollup.config.js", "rollup.config.js"
run "pnpm add rollup @rollup/plugin-node-resolve"

say "Add build script"
build_script = "rollup -c --bundleConfigAsCjs rollup.config.js"

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
