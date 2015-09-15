all: ironyard.sqlite3

ironyard.sqlite3: insert.sql
	rm -f ironyard.sqlite3 
	sqlite3 ironyard.sqlite3 < create.sql
	sqlite3 ironyard.sqlite3 < insert.sql

insert.sql: scrape.rb
	ruby scrape.rb > insert.sql

clean:
	rm insert.sql
	rm ironyard.sqlite3

.PHONY: clean all