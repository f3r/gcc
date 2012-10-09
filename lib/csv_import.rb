require 'csv'
class CsvImport
  class << self
    def parse_file(model_name, data)
      CSV.foreach(data.tempfile, :headers => true) do |row|
        model_name.create!(row.to_hash)
      end
    end

    def to_hashes(data)
      list = []
      CSV.foreach(data.tempfile, :headers => true) do |row|
        list << row.to_hash.symbolize_keys
      end
      list
    end
  end
end