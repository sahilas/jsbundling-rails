say "Install esbuild"
run "pnpm add esbuild"

say "Add build script"
build_script = "esbuild app/javascript/*.* --bundle --sourcemap --outdir=app/assets/builds --public-path=/assets"

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
