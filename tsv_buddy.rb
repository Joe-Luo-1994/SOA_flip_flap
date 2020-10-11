# frozen_string_literal: true

# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format

  def take_tsv(tsv)
    @data = []
    lines = tsv.split("\n")

    # Split out headers
    headers = lines[0].split("\t")
    headers.map!(&:chomp)

    # zip headers with values and turn into hashes
    lines[1..].each do |line|
      values = line.split("\t")
      @data << headers.zip(values).to_h
    end
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    tsv = []
    tsv << @data[0].keys.join("\t") # headers
    @data.each do |record|
      tsv << record.values.join("\t")
    end
    tsv << '' # let the last line to have "\n"
    tsv.join("\n")
  end
end
