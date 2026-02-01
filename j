import tkinter as tk
from PIL import Image, ImageTk
from datetime import datetime

root = tk.Tk()
root.title("ECON 2 MIDTERM COUNTDOWN")
root.geometry("500x300")

# Loads in the background image
bg_image = Image.open("car.png")

desired_width = 500
desired_height = 300
bg_image = bg_image.resize((desired_width, desired_height), resample=Image.Resampling.LANCZOS)
bg_photo = ImageTk.PhotoImage(bg_image)

root.bg_photo = bg_photo

canvas = tk.Canvas(root, width=bg_image.width, height=bg_image.height)
canvas.pack(fill="both", expand=True)
canvas.create_image(0, 0, anchor="nw", image=bg_photo)

# Countdown label
label = tk.Label(root, font=("Pixelify Sans", 50, "bold"), fg="#50416e", bg="#f5e9da")
canvas.create_window(bg_image.width // 2, 100, window=label)

# Countdown target date
target_date = datetime(2026, 2, 2, 0, 0, 0)

gif_image = Image.open("catpixel.gif")

gif_width = 100   
gif_height = 100  

gif_frames = []

gif_image = Image.open("catpixel.gif")
gif_frames = []

bg_width, bg_height = bg_image.size

try:
    while True:
        frame = gif_image.copy().resize(
            (gif_width, gif_height), 
            resample=Image.Resampling.LANCZOS
        )
        gif_frames.append(ImageTk.PhotoImage(frame))
        gif_image.seek(len(gif_frames)) 
except EOFError:
    pass

canvas = tk.Canvas(root, width=bg_image.width, height=bg_image.height)
canvas.pack(fill="both", expand=True)

canvas_bg = canvas.create_image(0, 0, anchor="nw", image=bg_photo)

gif_label = tk.Label(root, bg="#f5e9da") # Creates a background for the gif
canvas.create_window(bg_image.width//2, bg_image.height//2, window=gif_label)

def animate_gif(frame_index=0):
    gif_label.config(image=gif_frames[frame_index])
    root.after(100, lambda: animate_gif((frame_index + 1) % len(gif_frames)))

animate_gif()

gif_label.place(x=350, y=150)

def update_countdown():
    now = datetime.now()
    remaining = target_date - now
    if remaining.total_seconds() > 0:
        days = remaining.days
        hours, rem = divmod(remaining.seconds, 3600)
        minutes, seconds = divmod(rem, 60)
        label.config(text=f"{days}d {hours}h {minutes}m {seconds}s")
        root.after(1000, update_countdown)
    else:
        label.config(text="Time's up!")

update_countdown()
root.mainloop()
