namespace :cleanup do
  desc "東京オフィス用　当日の掃除当番とゴミ種別通知"
  task :tokyo_office => :environment do
    Cleanups::TokyoService.new.run
  end
end
