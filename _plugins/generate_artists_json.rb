# _plugins/generate_artists_json.rb
require 'json'

module Jekyll
  class GenerateArtistsJson < Jekyll::Generator
    safe true

    def generate(site)
      # Create a hash to store artist counts
      artist_counts = {}

      # Loop through posts and count artist occurrences
      site.posts.docs.each do |post|
        artist_name = post.data['artist']
        next if artist_name.nil? || artist_name.strip.empty?

        artist_counts[artist_name] ||= 0
        artist_counts[artist_name] += 1
      end

      # Prepare the JSON data
      artists_data = artist_counts.map do |name, count|
        { "name" => name, "count" => count }
      end

      # Convert to JSON format
      json_data = JSON.pretty_generate(artists_data)

      # Write the JSON data to _data/artists.json
      output_path = File.join(site.source, '_data', 'artists.json')
      File.write(output_path, json_data)

      puts "Generated _data/artists.json with artist data"
    end
  end
end
