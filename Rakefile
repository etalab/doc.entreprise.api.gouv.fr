# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

production1 = 'production1.entreprise.api.gouv.fr'
production2 = 'production2.entreprise.api.gouv.fr'

domains = [production2]
#domains = [production1, production2]

task :setup do
  domains.each do |domain|
    sh "mina setup domain=#{domain}"
  end
end

task :deploy do
  domains.each do |domain|
    sh "mina deploy domain=#{domain}"
  end
end
