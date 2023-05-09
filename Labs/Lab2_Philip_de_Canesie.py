from sqlalchemy import create_engine
from sqlalchemy.engine import URL
from sqlalchemy import text
import os

server_name = "localhost"
database_name = "bokhandel"

connection_string = f"DRIVER=ODBC Driver 17 for SQL Server;SERVER={server_name};DATABASE={database_name};Uid=sa;Pwd=reallyStrongPwd123;"
url_string = URL.create("mssql+pyodbc", query={"odbc_connect": connection_string})


def header():
    os.system("clear")
    return (
        "\t"
        + "=" * 39
        + "\n\t||        Book searcher 3000         ||"
        + "\n\t"
        + "=" * 39
        + "\n" * 10
    )


def footer():
    return "\n" * 10

def display_page(items, page):

    startpos = (page - 1) * 5
    endpos = 0
    if startpos + 5 > len(items):
        endpos = len(items)
    else:
        endpos = startpos + 5

    pageitems = items[startpos:endpos]

    for i in pageitems:
        print(i[1])



def main(engine):

    os.system("clear")

    inputvalue = input("input book title: ")

    query = text("SELECT ISBN13, Titel FROM Böcker Where Titel LIKE '%' + :inputvalue +'%';")
    query_stores = text("SELECT butiksnamn, SUM(Antal) FROM LagerSaldo l JOIN Butiker b on b.Id = l.ButikID WHERE ISBN IN (SELECT ISBN13 FROM Böcker Where Titel LIKE '%' + :inputvalue +'%') GROUP BY l.ButikID, l.ISBN, b.butiksnamn;")

    with engine.connect() as conn:
        
        result = conn.execute(query, {"inputvalue": inputvalue})

        result = result.fetchall()

        num_pages = round(len(result) / 5)
        current_page = 1
        
        while True:
            os.system("clear")

            display_page(result, current_page)
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


        




print(header())

print("\tConnecting to database...")


try:
    engine = create_engine(url_string)

    with engine.connect() as connection:

        print(header())
        print(f"\tSuccessfully connected to {database_name}!")
        main(engine)
        

except Exception as e:

    print("\tError while connecting to database:\n")
    print(e)

print(footer())


