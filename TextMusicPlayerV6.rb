# Credit to Ben Moritz for all of his help.
# Credit to the lab material and lecture material as it provided a lot of the frameowrk for this.
# Much of the code was walked through during lectures and labs.

require './input_functions'


# an array of genres that can be assigned to albums. the $ symbolises its a global variable
$genre_names = ['Film Score', 'Pop', 'Hip Hop', 'Jazz']


class Album
    attr_accessor :title, :artist, :genre, :tracks
    def initialize( title, artist, genre, tracks)
        @title = title
        @artist = artist
        @genre = genre
        @tracks = tracks
    end
end
class Track
    attr_accessor :name, :location
    def initialize(name, location)
        @name = name
        @location = location
    end
end

# a loop that calls read album and pushes it onto the end of the albums array. 
# The array pushes the information from every line of the .txt file into the corrisponding attributes of the Class. 
# This class is then stored within the albums array. 
def read_albums(music_file, albums)
  albums = Array.new()
# Read count specifies the amount of itirations the loop will be processed. 
  read_count = music_file.gets.to_i
      index = 0
      while (index < read_count)
          albums.push(read_album(music_file))
          index += 1
      end
    #   As per good practice. The file is then clossed. 
      music_file.close()

      puts "#{read_count} albums have been read."
      read_string("Press enter to continue")
  return albums
end

# read a single album. This function reads in information from input.txt
def read_album(music_file)
    album_title = music_file.gets()
    album_artist = music_file.gets()
    album_genre = music_file.gets()
    album_tracks = read_tracks(music_file)
    album = Album.new(album_title, album_artist, album_genre, album_tracks)
end
# a loop that calls "read track" and then appends the entry to the array named tracks
def read_tracks(music_file)
    tracks = Array.new()
    count = music_file.gets().to_i
    index = 0
    while (index < count)
    tracks.push(read_track(music_file))
    index += 1
    end
    return tracks
end
# read in a single track
def read_track(music_file)
    song_title = music_file.gets
    file_location = music_file.gets
    track = Track.new(song_title, file_location)
    track
end
# loop that calls print album bellow
def print_albums(albums)
  if (!albums)
      puts "No album has been read, please anter an album first"
  else
          count = albums.length
          index = 0


          while (index < count)
		      puts ""
              puts "Album details for album #{index + 1}"
              print_album(albums[index])
              index += 1
      end
  end
  read_string("Press any key to continue...")
end
# print album
def print_album(album)
    puts 'Genre is ' + album.genre
    puts 'Artist is ' + album.artist
    puts 'Title is ' + album.title
    tracks = album.tracks
    print_tracks(album.tracks)
end
# Loop that calls "print track" bellow
def print_tracks(tracks)
    count = tracks.length
    puts 'There are ' + count.to_s + ' tracks in this album:'
    index = 0
    while (index < count)
        print_track(tracks[index], index)
        index += 1
    end
end
# Print track
def print_track(track, index)
    puts(index.to_s + '. Track title: ' + track.name)
    puts('Track file location: ' + track.location)
end
# Print album names.
def print_album_names(albums)
  if (!albums)
      puts "Error: No album in database"
  else
      puts "Play Albums"
      i = 0
      count = albums.length
      while (i < count)
          puts ("Album #{i + 1}:" + albums[i].title)
          i += 1
      end
      album_select = read_integer_in_range("Select an album to play", 1, count)
      puts ("Tracks in album #{album_select}: ")
      print_tracks(albums[album_select - 1].tracks)

      track_selection = read_integer_in_range("Select a track to play", 1, (albums[album_select].tracks.length + 1))
      puts ("Playing Track #{track_selection}: " + albums[album_select - 1].tracks[track_selection - 1].name)
      sleep(3.0)
      read_string("Press enter to continue...")
      end
  end
#   Update Album details. 
  def update_album(albums)
    if (!albums)
        puts "No album has been selected."
    else
    album_menu = true
    while (album_menu  == true)
        index = 0
        count = albums.length
        modify_menu = true
        album_select = modify_menu(albums)

        while (index < count && modify_menu == true)
            if (album_select == (index + 1))
                puts ""
                puts ("Current Title: " + albums[index].title)
                puts ("Current Genre: " + albums[index].genre)
                puts "1: Update Genre"
                puts "2: Update Title"
                puts "3: Return"
            menu_choice = read_integer_in_range("Please select an option", 1, 3)
            case menu_choice
            when 1
              albums[album_select - 1].genre = read_string("Enter updated genre: ")
              puts ("Updated Genre is:" + albums[album_select - 1].genre)
              modify_menu = false
                
            when 2
              albums[album_select - 1].title = read_string("Enter revised title: ")
              puts ("Updated Title is: " + albums[album_select - 1].title)
              modify_menu = false
            when 3
                modify_menu = false
        end
        elsif (album_select == (count + 1))
          modify_menu = false
          album_menu = false
        end
        end
      end
  end
    return albums
end

def modify_menu(albums)
    puts "Change title or genre of album"
    index = 0
    count = albums.length
    while (index < count)
		puts ""
        puts "Albums #{index +1} Details: "
        puts ("Title: " + albums[index].title)
        puts ("Genre: " + albums[index].genre)
        index += 1
    end
    index = 0
    while (index < count)
        puts "#{index + 1}: " + albums[index].title.chomp
        index += 1
    end
    puts("#{index + 1}: Return Home")
    album_select = read_integer_in_range("Menu Choice: ", 1, (index + 1))
    return album_select
end
# The main menu. Called in main and siplayed for the user. Each corisponding
# input calls a diffferent function. 
def main_menu(albums)
    finished = false
    while (finished == false)
      puts "Main Menu:"
      puts "1. Read in Album"
      puts "2. Display Album Infomation"
      puts "3. Play Album"
      puts "4. Update Album"
      puts "5. Exit"
      user_selection = read_integer_in_range("Please enter your choice: ", 1, 5)
      case user_selection
        when 1
          # Asks the user to enter the ame of the file containing album information
          file_name = read_string("Please enter the filename of the album: ")
          # assignes the variable music_file to the file name and opens in a read only state. 
          music_file = File.new(file_name, "r")
          
          albums = read_albums(music_file, albums)
        when 2
          print_albums(albums)
        when 3
          print_album_names(albums)
        when 4
          albums = update_album(albums)
        when 5
          finished = true
      end
    end
  end
def main
    finished = false
    albums = nil
    main_menu(albums)
end
main()
