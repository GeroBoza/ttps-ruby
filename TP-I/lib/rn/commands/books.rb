require_relative '../models/books.rb'
module RN
  module Commands
    module Books
        BOOK = Book.new
      class Create < Dry::CLI::Command
        desc 'Create a book'

        argument :name, required: true, desc: 'Name of the book'

        # example [
        #   '"My book" # Creates a new book named "My book"',
        #   'Memoires  # Creates a new book named "Memoires"'
        # ]

        def call(name:, **)
            puts BOOK.create(name)
        end
      end

      class Delete < Dry::CLI::Command
            desc 'Delete a book, options: --global'

            
            argument :name, required: false, desc: 'Name of the book'
            option :global, type: :boolean, default: false, desc: 'Operate on the global book'
            
            example [
                '--global  # Deletes all notes from the global book',
                '"My book" # Deletes a book named "My book" and all of its notes',
                'Memoires  # Deletes a book named "Memoires" and all of its notes'
            ]
            
            def call(name: nil, **options)               
                puts BOOK.delete(name, **options)
            end
      end

      class List < Dry::CLI::Command
        desc 'List books'

        def call(*)
            puts BOOK.list()
        end
      end

      class Rename < Dry::CLI::Command
        desc 'Rename a book'

        argument :old_name, required: true, desc: 'Current name of the book'
        argument :new_name, required: true, desc: 'New name of the book'

        # example [
        #   '"My book" "Our book"         # Renames the book "My book" to "Our book"',
        #   'Memoires Memories            # Renames the book "Memoires" to "Memories"',
        #   '"TODO - Name this book" Wiki # Renames the book "TODO - Name this book" to "Wiki"'
        # ]

        def call(old_name:, new_name:, **)
            
            puts BOOK.rename(old_name, new_name)
            
        end
      end
    end
  end
end
