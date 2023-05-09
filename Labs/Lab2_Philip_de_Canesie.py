from sqlalchemy import create_engine
from sqlalchemy.engine import URL
from sqlalchemy import text
import os

server_name = "localhost"
database_name = "bokhandel"

connection_string = f"DRIVER=ODBC Driver 17 for SQL Server;SERVER={server_name};DATABASE={database_name};Uid=sa;Pwd=reallyStrongPwd123;"
url_string = URL.create("mssql+pyodbc", query={"odbc_connect": connection_string})


def display_page(items, page, shopnames, numbooks):

    startpos = (page - 1) * 5
    endpos = 0
    if startpos + 5 > len(items):
        endpos = len(items)
    else:
        endpos = startpos + 5

    pageitems = items[startpos:endpos]
    header_str = "Titles:".ljust(40) + "Stores:".ljust(15)

    for s in shopnames:

        header_str += f"{s[0]}".ljust(15)

    print(header_str + "\n")

    for i in pageitems:

        book_str = str(i[1]).ljust(55)

        for s in shopnames:

            for count, n in enumerate(numbooks):

                if n[0] == i[0] and n[1] == s[1]:

                    book_str += str(n[2]).ljust(15)
                    break

                elif count == (len(numbooks) - 1):

                    book_str += str(0).ljust(15)

        print(book_str)

def main(engine):

    os.system("clear")

    inputvalue = input("input book title: ")

    query = text("SELECT ISBN13, Titel FROM Böcker Where Titel LIKE '%' + :inputvalue +'%';")
    query_storenames = text("SELECT butiksnamn, Id FROM Butiker;")
    query_numbooks = text("SELECT l.ISBN, l.ButikID, SUM(Antal) FROM LagerSaldo l JOIN Butiker b on b.Id = l.ButikID WHERE ISBN IN (SELECT ISBN13 FROM Böcker Where Titel LIKE '%' + :inputvalue +'%') GROUP BY l.ButikID, l.ISBN, b.butiksnamn;")

    with engine.connect() as conn:
        
        # fetch titles based on input.
        result = conn.execute(query, {"inputvalue": inputvalue})
        result = result.fetchall()

        # fetch all the store names. 
        result_storenames = conn.execute(query_storenames)
        result_storenames = result_storenames.fetchall()

        # fetch number of books per store.
        result_numbooks = conn.execute(query_numbooks, {"inputvalue": inputvalue})
        result_numbooks = result_numbooks.fetchall()

        # calculate number of pages needed. 
        num_pages = round(len(result) / 5)
        current_page = 1 # sets current page to one.
        
        while True:
            os.system("clear")

            display_page(result, current_page, result_storenames, result_numbooks)
            print("\n" + f"Page: {current_page} of {num_pages}" + "\n" + "-"*54)

            print()
            option_value = input("Press 'n' for next page, 'b' to go back, 'q' for quit: ")

            if option_value == "n" and current_page != num_pages:
                current_page += 1
            elif option_value == "b" and current_page > 1:
                current_page -= 1
            elif option_value == "q":
                os.system("clear")
                break
            else:
                print("Invalid choice. Please try again.")


print("\tConnecting to database...")

try:
    engine = create_engine(url_string)

    with engine.connect() as connection:

        print(f"\tSuccessfully connected to {database_name}!")
        main(engine)
        

except Exception as e:

    print("\tError while connecting to database:\n")
    print(e)



