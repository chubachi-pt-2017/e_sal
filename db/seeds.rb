table_names = %w( main_categories )

# productionでは以下のseedsファイルは実行しない
unless Rails.env.production?
  table_names.push( "users", "programmings", "original_categories", "programming_answers" )
end

ActiveRecord::Base.connection.execute("set foreign_key_checks = 0;")

table_names.each do |table_name|
  path = Rails.root.join('db', 'seeds', "#{table_name}.rb")
  if File.exist?(path)
    puts "Truncate #{table_name}...."
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table_name};")
    puts "Create #{table_name}...."
    require(path)
  end
end

ActiveRecord::Base.connection.execute("set foreign_key_checks = 1;")
