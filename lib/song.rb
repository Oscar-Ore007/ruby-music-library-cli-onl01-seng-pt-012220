class Song 

    @@all = [] 

     attr_accessor :name , :artist, :genre 
    def initialize(name, artist = nil, genre = nil)
        @name = name 
        self.artist=(artist) if artist != nil 
        self.genre=(genre) if genre != nil 
    end 

    def self.all 
        @@all
    end 

    def self.destroy_all 
    @@all.clear
    end 

    def save 
        @@all << self 
    end 

    def self.create(artist)
        artist = self.new(artist)
        artist.save 
        artist 
    end 

    def artist=(artist)
        @artist = artist 
        artist.add_song(self)
    end 

    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.include?(self)
    end 

    def self.find_by_name(name)
        @@all.detect {|song| song.name == name}

    end 

    def self.find_or_create_by_name(name)
        self.find_by_name(name) || self.create(name)
    end 

    def self.new_from_filename(filename)
        new_filename = filename.split(" - ")

        song_name = new_filename[1]
        artist_name = new_filename[0]
        genre_name = new_filename[2].split(".mp3").join 

        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)
        self.new(song_name,artist,genre)

    end 

    def self.create_from_filename(filename)
        self.new_from_filename(filename).save
    end 

end 