import tkinter as tk
import sqlite3

conn = sqlite3.connect('coffee.db')
cur = conn.cursor()


def save_order(coffee, price):
    cur.execute("INSERT INTO orders (coffee, price) VALUES (?, ?)", (coffee, price))
    conn.commit()

def order_screen():
    
    window = tk.Tk()
    window.title("커피 주문")

    title_label = tk.Label(window, text="커피 주문", font=("Helvetica", 16))
    title_label.pack(pady=10)

    coffee_var = tk.StringVar()
    for coffee, price in [("아메리카노", 2000), ("카페라떼", 2500), ("카푸치노", 2500)]:
        radio_button = tk.Radiobutton(window, text=f"{coffee} - {price}원", variable=coffee_var, value=coffee)
        radio_button.pack()

    order_button = tk.Button(window, text="주문하기", font=("Helvetica", 12), command=lambda: submit_order(coffee_var.get()))
    order_button.pack(pady=10)

   
    def submit_order(coffee):
        if coffee:
            save_order(coffee, get_price(coffee))

            message_label = tk.Label(window, text=f"{coffee}를 주문하셨습니다.", font=("Helvetica", 12))
            message_label.pack(pady=10)

    
    def get_price(coffee):
        prices = {"아메리카노": 2000, "카페라떼": 2500, "카푸치노": 2500}
        return prices[coffee]

    window.mainloop()

if __name__ == "__main__":
    order_screen()
