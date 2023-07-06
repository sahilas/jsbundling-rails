namespace :javascript do
  desc "Install JavaScript dependencies"
  task :install do
    unless system "pnpm install"
      raise "jsbundling-rails: Command install failed, ensure pnpm is installed"
    end
  end

  desc "Build your JavaScript bundle"
  build_task = task :build do
    unless system "pnpm build"
      raise "jsbundling-rails: Command build failed, ensure `pnpm build` runs without errors"
    end
  end
  build_task.prereqs << :install unless ENV["SKIP_PNPM_INSTALL"]
end

unless ENV["SKIP_JS_BUILD"]
  if Rake::Task.task_defined?("assets:precompile")
    Rake::Task["assets:precompile"].enhance(["javascript:build"])
  end

  if Rake::Task.task_defined?("test:prepare")
    Rake::Task["test:prepare"].enhance(["javascript:build"])
  elsif Rake::Task.task_defined?("spec:prepare")
    Rake::Task["spec:prepare"].enhance(["javascript:build"])
  elsif Rake::Task.task_defined?("db:test:prepare")
    Rake::Task["db:test:prepare"].enhance(["javascript:build"])
  end
end
