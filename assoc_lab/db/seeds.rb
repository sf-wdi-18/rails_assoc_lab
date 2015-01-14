class TableReader
  attr_reader :raw_lines, :keys_line, :keys, :params, :val_lines
  def initialize(filename)
    @raw_lines = IO.readlines(filename)
    inter_lines = @raw_lines.clone
    @keys_line = inter_lines.shift(2)[0]
    @val_lines = inter_lines
    create_keys
    process_rows
  end

  def each(&block)
    @params.each(&block)
  end

  include Enumerable

  private
    def create_keys
      format_line = @keys_line.gsub(/(^\|)|(\|$)|\s+|\`/,"")
      @keys = format_line.split("|").map do |key|
        key.split(":")
      end
    end

    def process_rows
      @params = @val_lines.map do |raw_line|
        line = raw_line.gsub(/(^\|)|(\|$)/,"").split("|")
        row_hash = {}
        keys.each_with_index do |key, index|
          if key[1] == "integer"
            row_hash[key[0]] = line[index].to_i
          elsif key[1] == "string"
            row_hash[key[0]] = line[index].strip!
          else
            row_hash[key[0]] = nil
          end
        end
        row_hash
      end
    end
end

files = {"books" => Book, 
  "authors" => Author,
  "book_libraries" => BookLibrary,
  "libraries" => Library }

files.each do |f_name, ar_class|
  table = TableReader.new("db/#{f_name}.txt")
  table.each do |param|
    p param 
    ar_class.create(param)
  end
end

# rud = Author.create({"first_name"=>" Rudyard ", "last_name"=>" Kipling ", "y_o_b"=>1865, "y_o_d"=>1936})
# lewis = Author.create({"first_name"=>" Lewis ", "last_name"=>" Carroll ", "y_o_b"=>1832, "y_o_d"=>1892})
# hg_wells = Author.create({"first_name"=>" H.G.  ", "last_name"=>" Wells ", "y_o_b"=>1866, "y_o_d"=>1946})

# rud.books.create({"title"=>" The Jungle Book ", "description"=>" The Jungle Book is a collection of stories by English author Rudyard Kipling. The stories were first published in magazines in 1893–94. The original publications contain illustrations, some by Rudyard's father, John Lockwood Kipling. ", "publication_year"=>1894, "isbn"=>" 9788497896696 ", "author_id"=>1})
# rikki_tikki = Book.create({"title"=>" Rikki-Tikki-Tavi ", "description"=>"\"Rikki-Tikki-Tavi\" is a short story in The Jungle Book by Rudyard Kipling about the adventures of a valiant young mongoose. The story has often been anthologized, and has been published more than once as a short book in its own right. ", "publication_year"=>1894, "isbn"=>" 1484123689 ", "author_id"=>1})
# rikki_tikki = rud.books.find_by({isbn: " 1484123689 "})
# rikki_tikki.update({description: "very cool"})
# rud.books.push(rikki_tikki)

# lewis.books.create({"title"=>" Alice's Adventures in Wonderland ", "description"=>" Alice's Adventures in Wonderland is an 1865 novel written by English author Charles Lutwidge Dodgson under the pseudonym Lewis Carroll. ", "publication_year"=>1865, "isbn"=>" 9781552465707 ", "author_id"=>2})
# looking_glass = Book.create({"title"=>" Through the Looking-Glass ", "description"=>" Through the Looking-Glass, and What Alice Found There is a novel by Lewis Carroll, the sequel to Alice's Adventures in Wonderland. It is based on his meeting with another Alice, Alice Raikes ", "publication_year"=>1871, "isbn"=>" 9781489500182 ", "author_id"=>2})
# lewis.books.push(looking_glass)

# Book.create({"title"=>" The Time Machine ", "description"=>" The Time Machine is a science fiction novel by H. G. Wells, published in 1895. Wells is generally credited with the popularisation of the concept of time travel by using a vehicle that allows an operator to travel purposefully and selectively ", "publication_year"=>1895, "isbn"=>" 9781423794417 ", "author_id"=>3})

# congress = Library.create({"name"=>" Library of Congress ", "city"=>"  Washington ", "state"=>" DC \n"})
# g_p_lib = Library.create({"name"=>" George Peabody Library ", "city"=>" Baltimore ", "state"=>" Maryland \n"})
# central = Library.create({"name"=>" Central Library ", "city"=>"   Seattle ", "state"=>"  Washington "})

# congress.books.push Book.find_by({id: 1})
# congress.books.push looking_glass
# congress.books.push Book.find_by({id: 1})

# central.books.push Book.find_by({id: 2})
# BookLibrary.create({"library_id"=>2, "book_id"=>3})

# g_p_lib.books.push Book.find_by({id: 1})
# g_p_lib.books.push Book.find_by({id: 2})
